import Foundation
import KatanaCore
import KatanaFx
import KatanaGoAPI
import KatanaGoData
import MIDIKit

/// MIDI implementation of the KatanaGo protocol.
public actor KatanaGoMIDIKit: KatanaGo {
  private let endpoint: MIDIEndpointProtocol
  private let midiManager: MIDIManagerProtocol

  private var inputTag: String { "KatanaGo_In_\(endpoint.uniqueID)" }
  private var outputTag: String { "KatanaGo_Out_\(endpoint.uniqueID)" }

  private var continuation: AsyncStream<KatanaGoDataBank>.Continuation?

  private var pendingReads: [UInt32: CheckedContinuation<[UInt8], Error>] = [:]

  private var dataBank = DataBank()

  public init(endpoint: MIDIEndpointProtocol, midiManager: MIDIManagerProtocol) {
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

      let banks = KatanaGoMIDIParser.parse(message, into: &dataBank)
      for bank in banks {
        print("Bank: \(bank)")
        continuation?.yield(bank)
      }
    }
  }

  public func disconnect() async {
    midiManager.remove(.inputConnection, .withTag(inputTag))
    midiManager.remove(.outputConnection, .withTag(outputTag))
    continuation?.finish()
    continuation = nil
  }

  public func writeBank<T: KatanaGoBank>(_ bank: T) async throws {
    try await writeBank(bank, addressModifiers: T.katanaGoAddress)
  }

  public func writeFxBank<T: KatanaGoFxBank>(_ bank: T, channel: KatanaGoFxChannel) async throws {
    let address: UInt32 = T.katanaGoAddress | (channel == .fx ? 0x00_00_10_00 : 0x00)
    // let address: UInt32 = channel == .fx ? 0x20_00_10_00 : 0x20_00_00_00
    try await writeBank(bank, addressModifiers: address)
  }

  public func writeChannelAddressableBank<T: KatanaGoChannelAddressableBank>(
    _ bank: T, channel: T.BankChannel
  ) async throws {
    let address: UInt32 = T.katanaGoAddress + channel.rawValue
    try await writeBank(bank, addressModifiers: address)
  }

  /// Enable or disable the FX bank.
  /// - Parameter enabled: The bank of parameters to send to the device.
  public func enableFx(_ enabled: Bool, channel: KatanaGoFxChannel) async throws {
    let address: UInt32 = channel == .fx ? 0x20_00_30_02 : 0x20_00_30_01
    let bytes = finalizeSysex(address: address, data: [enabled ? 0x01 : 0x00])
    try writeRawBytes(bytes)
  }

  public func selectFxType(_ type: ModFxType, channel: KatanaGoFxChannel) async throws {
    let address: UInt32 = channel == .fx ? 0x20_00_70_00 : 0x20_00_60_00
    let bytes = finalizeSysex(address: address, data: [type.rawValue])
    try writeRawBytes(bytes)
  }

  // TODO: remove once writefxbank supports a method with a channel input.
  public func writeEQBank(_ bank: EQSelectionBank, id: BankID) async throws {
    let idModifier = id.eqOffset
    try await writeBank(bank, addressModifiers: 0x20_00_00_00 | idModifier)
  }

  private func writeBank(_ bank: WritableBank, addressModifiers: UInt32) async throws {
    for writeData in bank.loadWriteData(baseAddress: addressModifiers) {
      // let address = writeData.address | addressModifiers
      let data = writeData.data

      // let bytes = finalizeSysex(address: address, data: data)
      let bytes = finalizeSysex(address: writeData.address, data: data)
      print("Writing bytes: \(bytes)")
      try writeRawBytes(bytes)
    }
  }

  // TODO: add method to write KatanaGoDataBank enum cases.
  // Note that preset write is different than read. Preset write is on address 0x7f000104 and
  // is of two bytes size (first byte is 00 and second one has the preset's raw value).

  public func readBank<T: KatanaGoBank>(_ type: T.Type) async throws -> T {
    try await readBank(type, addressModifiers: T.katanaGoAddress)
  }

  public func readFxBank<T: KatanaGoFxBank>(_ type: T.Type, channel: KatanaGoFxChannel) async throws
    -> T
  {
    // let modifier: UInt32 = channel == .fx ? 0x20_00_10_00 : 0x20_00_00_00
    let modifier = T.katanaGoAddress | (channel == .fx ? 0x20_00_10_00 : 0x20_00_00_00)
    return try await readBank(type, addressModifiers: modifier)
  }

  private func readBank<T: WritableBank>(_ type: T.Type, addressModifiers: UInt32) async throws -> T
  {
    // let address = T.address | addressModifiers
    let address = addressModifiers
    let size = T.size

    let bytes = finalizeReadSysex(addressBytes: address.addressBytes, bytesToRead: UInt16(size))

    let data = try await withCheckedThrowingContinuation { continuation in
      // TODO: consider cancelling a previous read for this address if it was not completed
      // or adding an array of continuations.

      // Store the continuation for this address
      pendingReads[address] = continuation
      do {
        try writeRawBytes(bytes)
      } catch {
        pendingReads.removeValue(forKey: address)
        continuation.resume(throwing: error)
      }
    }

    return T.buildFromByteArray(data)
  }

  public func read() -> AsyncStream<KatanaGoDataBank> {
    AsyncStream { continuation in
      self.continuation = continuation
    }
  }

  private func finalizeReadSysex(addressBytes: [UInt8], data: [UInt8]) -> [UInt8] {
    let prefix: [UInt8] = [0xf0, 0x41, 0x10, 0x01, 0x05, 0x0d, 0x11]
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
    let prefix: [UInt8] = [0xf0, 0x41, 0x10, 0x01, 0x05, 0x0d, 0x12]
    let body = address.addressBytes + data
    let checksum = calculateChecksum(for: body)
    return prefix + body + [checksum, 0xf7]
  }

  private func finalizeSysex(addressBytes: [UInt8], data: [UInt8]) -> [UInt8] {
    let prefix: [UInt8] = [0xf0, 0x41, 0x10, 0x01, 0x05, 0x0d, 0x12]
    let body = addressBytes + data
    let checksum = calculateChecksum(for: body)
    return prefix + body + [checksum, 0xf7]
  }

  private func finalizeReadSysex(addressBytes: [UInt8], bytesToRead: UInt16) -> [UInt8] {
    // Use like this:
    // Read preset name example (16 bytes -> 0x10)
    // let bytes = finalizeReadSysex(addressBytes: [0x20, 0x00, 0x00, 0x00], bytesToRead: 0x10)
    let prefix: [UInt8] = [0xf0, 0x41, 0x10, 0x01, 0x05, 0x0d, 0x11]
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

extension BankID {
  fileprivate var eqOffset: UInt32 {
    switch self {
    case .id1: return 0x00_02_60_00
    case .id2: return 0x00_02_70_00
    default: return 0x00_00_00_00
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
