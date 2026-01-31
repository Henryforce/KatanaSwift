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
    print("-----------------")
    for event in events {
      if case .sysEx7(let sysEx) = event {
        // Uncomment to print messages.
        print("SysEx: \(sysEx.data)")

        let banks = KatanaGoMIDIParser.parse(sysEx.data, into: &dataBank)
        for bank in banks {
          print("Bank: \(bank)")
          continuation?.yield(bank)
        }
      }
    }
  }

  public func disconnect() async {
    midiManager.remove(.inputConnection, .withTag(inputTag))
    midiManager.remove(.outputConnection, .withTag(outputTag))
    continuation?.finish()
    continuation = nil
  }

  public func writeBank<T: WritableBank>(_ bank: T) async throws {
    try await writeBank(bank, addressModifiers: 0)
  }

  public func writeFxBank<T: KatanaGoFxBank>(_ bank: T, channel: KatanaGoFxChannel) async throws {
    // let address: UInt32 = T.address + (channel == .fx ? 0x00_00_10_00 : 0x00)
    let address: UInt32 = channel == .fx ? 0x20_00_10_00 : 0x20_00_00_00
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

  public func writeEQBank(_ bank: EQSelectionBank, id: BankID) async throws {
    let idModifier = id.eqOffset
    try await writeBank(bank, addressModifiers: 0x20_00_00_00 | idModifier)
  }

  private func writeBank(_ bank: WritableBank, addressModifiers: UInt32) async throws {
    for writeData in bank.loadWriteData() {
      let address = writeData.address | addressModifiers
      let data = writeData.data

      let bytes = finalizeSysex(address: address, data: data)
      print("Writing bytes: \(bytes)")
      try writeRawBytes(bytes)
    }
  }

  // TODO: add method to write KatanaGoDataBank enum cases.
  // Note that preset write is different than read. Preset write is on address 0x7f000104 and
  // is of two bytes size (first byte is 00 and second one has the preset's raw value).

  public func readBank<T: WritableBank>(_ type: T.Type) async throws -> T {
    // TODO: implement.
    return T.buildFromByteArray([])
  }

  public func readFxBank<T: KatanaGoFxBank>(_ type: T.Type, channel: KatanaGoFxChannel) async throws
    -> T
  {
    // TODO: implement.
    return T.buildFromByteArray([])
  }

  public func read() -> AsyncStream<KatanaGoDataBank> {
    AsyncStream { continuation in
      self.continuation = continuation
    }
  }

  // Example of how to build a bank from raw data:
  // public func deleteMe() {
  //   let rawData: [UInt8] = [0, 0, 0, 0, 0, 1, 0]
  //   let bank = EffectStatusBank.buildFromByteArray(rawData)
  //   print(bank)
  // }

  // Use like this:
  // Read preset name
  // let bytes = finalizeReadSysex(addressBytes: [0x20, 0x00, 0x00, 0x00], data: [0x00, 0x00, 0x00, 10])

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
    let addressBytes = [
      UInt8((address >> 24) & 0xFF), UInt8((address >> 16) & 0xFF), UInt8((address >> 8) & 0xFF),
      UInt8(address & 0xFF),
    ]
    let body = addressBytes + data
    let checksum = calculateChecksum(for: body)
    return prefix + body + [checksum, 0xf7]
  }

  private func finalizeSysex(addressBytes: [UInt8], data: [UInt8]) -> [UInt8] {
    let prefix: [UInt8] = [0xf0, 0x41, 0x10, 0x01, 0x05, 0x0d, 0x12]
    let body = addressBytes + data
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
  var eqOffset: UInt32 {
    switch self {
    case .id1:
      return 0x00_02_60_00
    case .id2:
      return 0x00_02_70_00
    default:
      return 0x00_00_00_00
    }
  }
}
