import Foundation
import KatanaGoAPI
import KatanaGoData
import MIDIKit

/// MIDI implementation of the KatanaGo protocol.
public actor KatanaGoMIDIKit: KatanaGo {
  private let endpoint: MIDIOutputEndpoint
  private let midiManager: MIDIManager

  private var inputTag: String { "KatanaGo_In_\(endpoint.uniqueID)" }
  private var outputTag: String { "KatanaGo_Out_\(endpoint.uniqueID)" }

  private var continuation: AsyncStream<KatanaGoReadData>.Continuation?

  public init(endpoint: MIDIOutputEndpoint, midiManager: MIDIManager) {
    self.endpoint = endpoint
    self.midiManager = midiManager
  }

  public func connectionStatus() async -> ConnectionStatus {
    let isInputConnected = midiManager.managedInputConnections[inputTag] != nil
    let isOutputConnected = midiManager.managedOutputConnections[outputTag] != nil
    return (isInputConnected && isOutputConnected) ? .connected : .disconnected
  }

  public func connect() async throws {
    // 1. Find matching input endpoint (the device's destination port)
    // In MIDIKit, MIDIInputEndpoint represents a system destination (where we send TO).
    // MIDIOutputEndpoint represents a system source (where we receive FROM).
    guard
      let destinationEndpoint = midiManager.endpoints.inputs.first(where: {
        $0.displayName == endpoint.displayName || $0.name == endpoint.name
      })
    else {
      throw KatanaGoError.connectionFailed(
        "Could not find matching MIDI input endpoint (destination) for \(endpoint.displayName)")
    }

    // 2. Setup output connection (to send TO the device)
    // We connect our output to the device's input endpoint.
    try midiManager.addOutputConnection(
      to: .inputs([destinationEndpoint]),
      tag: outputTag
    )

    // 3. Setup input connection (to receive FROM the device)
    // We connect our input to the device's output endpoint (which is the 'endpoint' property).
    try midiManager.addInputConnection(
      to: .outputs([endpoint]),
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
      if case .sysEx7(let sysEx) = event {
        // Yield common MIDI command data.
        // For Boss devices, we often look for sysex.
        // For now, we wrap the whole sysex payload.
        continuation?.yield(.midiCommand(command: 0xF0, data: sysEx.data))
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
    switch command {
    case .changePreset(let preset):
      try writeRawBytes(preset.bytes)
    default:
      // TODO: Implement MIDI write logic
      break
    }
  }

  public func read() -> AsyncStream<KatanaGoReadData> {
    AsyncStream { continuation in
      self.continuation = continuation
    }
  }

  private func writeRawBytes(_ rawBytes: [UInt8]) throws {
    guard let connection = midiManager.managedOutputConnections[outputTag] else {
      throw KatanaGoError.connectionFailed("Could not find output connection for \(outputTag)")
    }
    let event = try MIDIEvent.sysEx7(rawBytes: rawBytes)
    try connection.send(event: event)
  }
}
