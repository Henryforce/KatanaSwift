import Foundation
import KatanaGoAPI
import KatanaGoData
import MIDIKit

/// MIDI implementation of the KatanaGo protocol.
public actor KatanaGoMIDIKit: KatanaGo {
  private let endpoint: MIDIEndpointProtocol
  private let midiManager: MIDIManagerProtocol

  private var inputTag: String { "KatanaGo_In_\(endpoint.uniqueID)" }
  private var outputTag: String { "KatanaGo_Out_\(endpoint.uniqueID)" }

  private var continuation: AsyncStream<KatanaGoReadData>.Continuation?

  private var dataBank = DataBank(addressOffset: 0x20_00_00_00)

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
      throw KatanaGoError.connectionFailed(
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
        // Yield common MIDI command data.
        // For Boss devices, we often look for sysex.
        // For now, we wrap the whole sysex payload.
        continuation?.yield(.midiCommand(command: 0xF0, data: sysEx.data))

        // Uncomment to print messages.
        print("SysEx: \(sysEx.data)")

        let status = KatanaGoMIDIParser.parse(sysEx.data, into: &dataBank)
        switch status {
        case .invalidMessageLength:
          print("Invalid message length")
        case .invalidMessageCommand:
          print("Invalid message command")
        case .start:
          print("Start")
        case .processed:
          print("Processed")
        case .end:
          print("End")

          let katanaState = dataBank.state
          print("Katana State: \(katanaState)")
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

  public func write(_ command: KatanaGoWriteData) async throws {
    try writeRawBytes(command.bytes)
  }

  public func writeBank(_ bank: WritableBank) async throws {
    for writeData in bank.loadWriteData() {
      let address = writeData.address + 0x20_00_00_00
      let data = writeData.data

      let bytes = finalizeSysex(address: address, data: data)
      try writeRawBytes(bytes)
    }
  }

  public func read() -> AsyncStream<KatanaGoReadData> {
    AsyncStream { continuation in
      self.continuation = continuation
    }
  }

  private func writeRawBytes(_ rawBytes: [UInt8]) throws {
    guard let connection = midiManager.loadManagedOutputConnections()[outputTag] else {
      throw KatanaGoError.connectionFailed("Could not find output connection for \(outputTag)")
    }
    let event = try MIDIEvent.sysEx7(rawBytes: rawBytes)
    try connection.send(event: event)
  }

  private func finalizeSysex(address: UInt32, data: [UInt8]) -> [UInt8] {
    let prefix: [UInt8] = [0xf0, 0x41, 0x10, 0x01, 0x05, 0x0d, 0x12]
    let addressBytes = [
      UInt8(address >> 24), UInt8(address >> 16), UInt8(address >> 8), UInt8(address),
    ]
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
