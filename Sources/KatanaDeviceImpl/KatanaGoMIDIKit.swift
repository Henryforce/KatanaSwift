import Foundation
import KatanaCore
import MIDIKit

/// MIDI implementation of the KatanaDevice protocol.
public actor KatanaGoMIDIKit: KatanaDevice {
  private let endpoint: MIDIEndpointProtocol
  private let midiManager: MIDIManagerProtocol

  private var inputTag: String { "KatanaGo_In_\(endpoint.uniqueID)" }
  private var outputTag: String { "KatanaGo_Out_\(endpoint.uniqueID)" }

  private var continuation: AsyncStream<[UInt8]>.Continuation?

  private var pendingReads: [UInt32: CheckedContinuation<[UInt8], Error>] = [:]

  private let deviceType: KatanaDeviceType

  public init(
    deviceType: KatanaDeviceType, endpoint: MIDIEndpointProtocol, midiManager: MIDIManagerProtocol
  ) {
    self.deviceType = deviceType
    self.endpoint = endpoint
    self.midiManager = midiManager
  }

  public func connectionStatus() async -> ConnectionStatus {
    let isInputConnected = midiManager.loadManagedInputConnections()[inputTag] != nil
    let isOutputConnected = midiManager.loadManagedOutputConnections()[outputTag] != nil
    return (isInputConnected && isOutputConnected) ? .connected : .disconnected
  }

  public func connect() async throws {
    // 1. Find matching input endpoint (the device's destination port)
    // In MIDIKit, MIDIInputEndpoint represents a system destination (where we send TO).
    // MIDIOutputEndpoint represents a system source (where we receive FROM).
    guard
      let destinationEndpoint = midiManager.inputEndpoints.first(where: {
        $0.displayName == endpoint.displayName || $0.name == endpoint.name
      })
    else {
      let displayName = endpoint.displayName ?? endpoint.name
      throw KatanaError.connectionFailed(
        "Could not find matching MIDI input endpoint (destination) for \(displayName)")
    }

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

    for bytes in KatanaGoStartupData.data {
      try writeRawBytes(bytes)
    }
  }

  private func handleMIDIEvents(_ events: [MIDIEvent]) {
    for event in events {
      guard case .sysEx7(let sysEx) = event else {
        continue
      }

      print("SysEx: \(sysEx.data)")

      // TODO: clean up this method to early check if it is a valid read response.

      let message = sysEx.data
      // Check if this is a valid read response.
      if message.count >= 10, message[4] == 18 {
        let address = Array(message[5...8]).address
        if let continuation = pendingReads.removeValue(forKey: address) {
          let data = Array(message[9..<(message.count - 1)])
          continuation.resume(returning: data)

          // Skip further processing as there was a pending read for this address.
          continue
        }
      }

      continuation?.yield(message)
    }
  }

  public func disconnect() async {
    midiManager.remove(.inputConnection, .withTag(inputTag))
    midiManager.remove(.outputConnection, .withTag(outputTag))
    continuation?.finish()
    continuation = nil
  }

  public func readDeviceType() async -> KatanaDeviceType {
    return deviceType
  }

  public func write(at address: UInt32, data: [UInt8]) async throws {
    let bytes = finalizeSysex(address: address, data: data)
    print("Writing bytes: \(bytes)")
    try writeRawBytes(bytes)
  }

  private func readBank<T: WritableBank>(_ type: T.Type, addressModifiers: UInt32) async throws -> T
  {
    let address = addressModifiers
    let size = T.size
    let data = try await readData(at: address, length: UInt16(size))
    return T.buildFromByteArray(data)
  }

  public func readData(at address: UInt32, length: UInt16) async throws -> [UInt8] {
    let bytes = finalizeReadSysex(addressBytes: address.addressBytes, bytesToRead: length)
    return try await withCheckedThrowingContinuation { continuation in
      pendingReads[address] = continuation
      do {
        try writeRawBytes(bytes)
      } catch {
        pendingReads.removeValue(forKey: address)
        continuation.resume(throwing: error)
      }
    }
  }

  public func subscribeToData() -> AsyncStream<[UInt8]> {
    AsyncStream { continuation in
      self.continuation = continuation
    }
  }

  private func finalizeReadSysex(addressBytes: [UInt8], data: [UInt8]) -> [UInt8] {
    let prefix: [UInt8] = [0xf0, 0x41, 0x10] + deviceType.modelIDBytes + [0x11]
    let body = addressBytes + data
    let checksum = calculateChecksum(for: body)
    return prefix + body + [checksum, 0xf7]
  }

  private func writeRawBytes(_ rawBytes: [UInt8]) throws {
    guard let connection = midiManager.loadManagedOutputConnections()[outputTag] else {
      throw KatanaError.connectionFailed("Could not find output connection for \(outputTag)")
    }
    let event = try MIDIEvent.sysEx7(rawBytes: rawBytes)
    try connection.send(event: event)
  }

  private func finalizeSysex(address: UInt32, data: [UInt8]) -> [UInt8] {
    let prefix: [UInt8] = [0xf0, 0x41, 0x10] + deviceType.modelIDBytes + [0x12]
    let body = address.addressBytes + data
    let checksum = calculateChecksum(for: body)
    return prefix + body + [checksum, 0xf7]
  }

  private func finalizeSysex(addressBytes: [UInt8], data: [UInt8]) -> [UInt8] {
    let prefix: [UInt8] = [0xf0, 0x41, 0x10] + deviceType.modelIDBytes + [0x12]
    let body = addressBytes + data
    let checksum = calculateChecksum(for: body)
    return prefix + body + [checksum, 0xf7]
  }

  private func finalizeReadSysex(addressBytes: [UInt8], bytesToRead: UInt16) -> [UInt8] {
    // Use like this:
    // Read preset name example (16 bytes -> 0x10)
    // let bytes = finalizeReadSysex(addressBytes: [0x20, 0x00, 0x00, 0x00], bytesToRead: 0x10)
    let prefix: [UInt8] = [0xf0, 0x41, 0x10] + deviceType.modelIDBytes + [0x11]
    let body = addressBytes + bytesToRead.bytes
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

extension KatanaDeviceType {
  fileprivate var modelIDBytes: [UInt8] {
    switch self {
    case .go: return [0x01, 0x05, 0x0D]
    }
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
