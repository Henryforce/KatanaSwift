import Foundation
import KatanaCore
import KatanaUtils
import SwiftMIDIIO

/// MIDI-based implementation of the KatanaDevice protocol.
public actor KatanaDeviceImpl: KatanaDevice {
  private struct PendingRead {
    let continuation: CheckedContinuation<[UInt8], Error>
    let timeoutTask: Task<Void, Never>?
  }

  private let endpoint: MIDIEndpointProtocol
  private let midiManager: MIDIManagerProtocol
  private let readTimeoutNanoseconds: UInt64
  private let profile: KatanaDeviceProfile

  private var inputTag: String { "\(profile.connectionTagPrefix)_In_\(endpoint.uniqueID)" }
  private var outputTag: String { "\(profile.connectionTagPrefix)_Out_\(endpoint.uniqueID)" }

  private var dataSubscribers: [UUID: AsyncStream<StreamData>.Continuation] = [:]
  private var pendingReads: [UInt32: [UUID: PendingRead]] = [:]

  private var status: ConnectionStatus = .disconnected

  private var memoryBankCache = KatanaMemoryBankCache()

  init(
    deviceType: KatanaDeviceType,
    endpoint: MIDIEndpointProtocol,
    midiManager: MIDIManagerProtocol,
    readTimeoutNanoseconds: UInt64 = 5_000_000_000
  ) {
    self.profile = KatanaDeviceProfile.profile(for: deviceType)
    self.endpoint = endpoint
    self.midiManager = midiManager
    self.readTimeoutNanoseconds = readTimeoutNanoseconds
  }

  public func connectionStatus() async -> ConnectionStatus {
    if status == .connecting || status == .disconnecting {
      return status
    }
    let isInputConnected = midiManager.loadManagedInputConnections()[inputTag] != nil
    let isOutputConnected = midiManager.loadManagedOutputConnections()[outputTag] != nil
    return (isInputConnected && isOutputConnected) ? .connected : .disconnected
  }

  public func connect() async throws {
    status = .connecting

    // 1. Find matching input endpoint (the device's destination port)
    // In SwiftMIDI, MIDIInputEndpoint represents a system destination (where we send TO).
    // MIDIOutputEndpoint represents a system source (where we receive FROM).
    guard
      let destinationEndpoint = midiManager.inputEndpoints.first(where: {
        $0.displayName == endpoint.displayName || $0.name == endpoint.name
      })
    else {
      status = .disconnected
      let displayName = endpoint.displayName
      throw KatanaError.connectionFailed(
        "Could not find matching MIDI input endpoint (destination) for \(displayName)")
    }

    do {
      // 2. Setup output connection (to send TO the device)
      // We connect our output to the device's input endpoint.
      try midiManager.addOutputConnection(
        to: [destinationEndpoint],
        tag: outputTag
      )

      // 3. Setup input connection (to receive FROM the device)
      // We connect our input to the device's output endpoint (which is the 'endpoint' property).
      try midiManager.addInputConnection(
        to: [endpoint],
        tag: inputTag,
        receiver: .events { [weak self] events, timestamp, source in
          Task { [weak self] in
            await self?.handleMIDIEvents(events)
          }
        }
      )

      for bytes in profile.startupPackets {
        try writeRawBytes(bytes)
      }

      status = .connected
    } catch {
      await disconnect()
      throw error
    }
  }

  private func handleMIDIEvents(_ events: [MIDIEvent]) {
    for event in events {
      guard case .sysEx7(let sysEx) = event,
        sysEx.manufacturer == .oneByte(0x41)
      else {
        continue
      }

      let message = sysEx.data
      // Validate Roland model ID and DT1 command (0x12 = 18) with minimum length.
      guard message.count >= 10,
        Array(message[1...3]) == profile.modelIDBytes,
        message[4] == 18
      else {
        continue
      }

      let address = Array(message[5...8]).address
      // Remove checksum byte, hence the < count - 1
      let data = Array(message[9..<(message.count - 1)])

      // Update cache with received data
      memoryBankCache.update(address: address, data: data)

      if let waiters = pendingReads.removeValue(forKey: address), !waiters.isEmpty {
        for (_, waiter) in waiters {
          waiter.timeoutTask?.cancel()
          waiter.continuation.resume(returning: data)
        }
        // Skip further processing as there were pending reads for this address.
        continue
      }

      for subscriber in dataSubscribers.values {
        subscriber.yield((address, data))
      }
    }
  }

  public func disconnect() async {
    status = .disconnecting

    midiManager.remove(.inputConnection, .withTag(inputTag))
    midiManager.remove(.outputConnection, .withTag(outputTag))

    let allPending = pendingReads
    pendingReads.removeAll()
    for (_, waiters) in allPending {
      for (_, waiter) in waiters {
        waiter.timeoutTask?.cancel()
        waiter.continuation.resume(throwing: KatanaError.notConnected)
      }
    }

    let subscribers = dataSubscribers
    dataSubscribers.removeAll()
    for subscriber in subscribers.values {
      subscriber.finish()
    }

    status = .disconnected
  }

  public func readDeviceType() async -> KatanaDeviceType {
    return profile.deviceType
  }

  public func write(at address: UInt32, data: [UInt8]) async throws {
    let bytes = finalizeSysex(address: address, data: data)
    try writeRawBytes(bytes)

    // Update cache only after write succeeds
    memoryBankCache.update(address: address, data: data)
  }

  public func readData(at address: UInt32, length: UInt16, options: ReadDataOptions) async throws
    -> [UInt8]
  {
    switch options {
    case .deviceOnly:
      return try await readFromDevice(at: address, length: length)

    case .deviceFirstCacheSecond:
      do {
        return try await readFromDevice(at: address, length: length)
      } catch {
        if let cached = cachedData(at: address, length: Int(length)) {
          return cached
        }
        throw error
      }

    case .cacheOnly:
      if let cached = cachedData(at: address, length: Int(length)) {
        return cached
      }
      throw KatanaError.cacheMissing

    case .cacheFirstDeviceSecond:
      if let cached = cachedData(at: address, length: Int(length)) {
        return cached
      }
      return try await readFromDevice(at: address, length: length)
    }
  }

  private func readFromDevice(at address: UInt32, length: UInt16) async throws -> [UInt8] {
    let bytes = finalizeReadSysex(addressBytes: address.addressBytes, bytesToRead: length)
    let readID = UUID()

    return try await withTaskCancellationHandler {
      try await withCheckedThrowingContinuation { continuation in
        if Task.isCancelled {
          continuation.resume(throwing: CancellationError())
          return
        }

        let timeoutTask: Task<Void, Never>? =
          readTimeoutNanoseconds > 0
          ? Task { [weak self, readTimeoutNanoseconds] in
            try? await Task.sleep(nanoseconds: readTimeoutNanoseconds)
            await self?.completePendingRead(
              address: address, id: readID, result: .failure(KatanaError.timeout))
          }
          : nil

        pendingReads[address, default: [:]][readID] = PendingRead(
          continuation: continuation, timeoutTask: timeoutTask)

        do {
          try writeRawBytes(bytes)
        } catch {
          completePendingRead(address: address, id: readID, result: .failure(error))
        }
      }
    } onCancel: {
      Task { [weak self] in
        await self?.completePendingRead(
          address: address, id: readID, result: .failure(CancellationError()))
      }
    }
  }

  private func completePendingRead(
    address: UInt32, id: UUID, result: Result<[UInt8], Error>
  ) {
    guard var waiters = pendingReads[address],
      let waiter = waiters.removeValue(forKey: id)
    else {
      return
    }
    if waiters.isEmpty {
      pendingReads.removeValue(forKey: address)
    } else {
      pendingReads[address] = waiters
    }
    waiter.timeoutTask?.cancel()
    waiter.continuation.resume(with: result)
  }

  public func subscribeToData() -> AsyncStream<StreamData> {
    let id = UUID()
    return AsyncStream { continuation in
      dataSubscribers[id] = continuation
      continuation.onTermination = { [weak self] _ in
        Task { [weak self] in
          await self?.removeSubscriber(id: id)
        }
      }
    }
  }

  private func removeSubscriber(id: UUID) {
    dataSubscribers.removeValue(forKey: id)
  }

  /// Returns cached data if available for the given address and length.
  func cachedData(at address: UInt32, length: Int) -> [UInt8]? {
    return memoryBankCache.get(address: address, length: length)
  }

  private func writeRawBytes(_ rawBytes: [UInt8]) throws {
    guard let connection = midiManager.loadManagedOutputConnections()[outputTag] else {
      throw KatanaError.connectionFailed("Could not find output connection for \(outputTag)")
    }
    let event = try MIDIEvent.sysEx7(rawBytes: rawBytes)
    try connection.send(event: event)
  }

  private func finalizeSysex(address: UInt32, data: [UInt8]) -> [UInt8] {
    let prefix: [UInt8] = [0xf0, 0x41, 0x10] + profile.modelIDBytes + [0x12]
    let body = address.addressBytes + data
    let checksum = calculateChecksum(for: body)
    return prefix + body + [checksum, 0xf7]
  }

  private func finalizeReadSysex(addressBytes: [UInt8], bytesToRead: UInt16) -> [UInt8] {
    // Use like this:
    // Read preset name example (16 bytes -> 0x10)
    // let bytes = finalizeReadSysex(addressBytes: [0x20, 0x00, 0x00, 0x00], bytesToRead: 0x10)
    let prefix: [UInt8] = [0xf0, 0x41, 0x10] + profile.modelIDBytes + [0x11]
    let body = addressBytes + RolandAddress.encode7BitBytes(UInt32(bytesToRead))
    let checksum = calculateChecksum(for: body)
    return prefix + body + [checksum, 0xf7]
  }

  private func calculateChecksum(for data: [UInt8]) -> UInt8 {
    var sum: Int = 0
    for byte in data {
      sum += Int(byte)
    }
    return UInt8((128 - (sum % 128)) % 128)
  }
}

extension Array where Element == UInt8 {
  fileprivate var address: UInt32 {
    return reduce(0) { ($0 << 8) | UInt32($1) }
  }
}

extension UInt32 {
  fileprivate var addressBytes: [UInt8] {
    return [
      UInt8((self >> 24) & 0xFF), UInt8((self >> 16) & 0xFF), UInt8((self >> 8) & 0xFF),
      UInt8(self & 0xFF),
    ]
  }
}
