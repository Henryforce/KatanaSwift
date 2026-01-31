import KatanaCore
import KatanaGoAPI
import KatanaGoData
import MIDIKit
import Testing

@testable import KatanaGoMIDIKit

struct KatanaGoMIDIKitTests {

  @Test func testConnectionStatus() async throws {
    let midiManager = MockMIDIManager()
    let endpoint = MockMIDIEndpoint(name: "Katana", displayName: "Katana")
    let katana = KatanaGoMIDIKit(endpoint: endpoint, midiManager: midiManager)

    // Initially disconnected
    let status = await katana.connectionStatus()
    #expect(status == .disconnected)

    // Mock connected state
    // In connectionStatus, it checks if tags exist in managedInputConnections and managedOutputConnections
    // let inputTag = "KatanaGo_In_\(endpoint.uniqueID)"
    // let outputTag = "KatanaGo_Out_\(endpoint.uniqueID)"
  }

  @Test func testConnectSuccess() async throws {
    let midiManager = MockMIDIManager()
    let endpoint = MockMIDIEndpoint(name: "Katana", displayName: "Katana")

    // Mock input endpoint that matches
    let inputEndpoint = MockMIDIEndpoint(name: "Katana", displayName: "Katana", uniqueID: 54321)
    midiManager.inputEndpoints = [inputEndpoint]

    let katana = KatanaGoMIDIKit(endpoint: endpoint, midiManager: midiManager)

    try await katana.connect()

    // Verify connections added
    #expect(midiManager.addedOutputConnections.count == 1)
    #expect(midiManager.addedOutputConnections[0].tag == "KatanaGo_Out_\(endpoint.uniqueID)")
    #expect(midiManager.addedOutputConnections[0].inputs.first?.uniqueID == inputEndpoint.uniqueID)

    #expect(midiManager.addedInputConnections.count == 1)
    #expect(midiManager.addedInputConnections[0].tag == "KatanaGo_In_\(endpoint.uniqueID)")
    #expect(midiManager.addedInputConnections[0].outputs.first?.uniqueID == endpoint.uniqueID)

    // Verify startup data written
    let outputConnection =
      midiManager.managedOutputConnections["KatanaGo_Out_\(endpoint.uniqueID)"]
      as? MockMIDIOutputConnection
    #expect(outputConnection != nil)
    #expect(outputConnection?.sentEvents.count == KatanaGoStartupData.data.count)
  }

  @Test func testConnectFailureEndpointNotFound() async throws {
    let midiManager = MockMIDIManager()
    let endpoint = MockMIDIEndpoint(name: "Katana", displayName: "Katana")

    // No matching input endpoints
    midiManager.inputEndpoints = []

    let katana = KatanaGoMIDIKit(endpoint: endpoint, midiManager: midiManager)

    await #expect(throws: KatanaError.self) {
      try await katana.connect()
    }
  }

  @Test func testDisconnect() async throws {
    let midiManager = MockMIDIManager()
    let endpoint = MockMIDIEndpoint(name: "Katana", displayName: "Katana")
    let katana = KatanaGoMIDIKit(endpoint: endpoint, midiManager: midiManager)

    await katana.disconnect()

    #expect(midiManager.removedSelections.count == 2)
    // Verify removals by tag
    let inputTag = "KatanaGo_In_\(endpoint.uniqueID)"
    let outputTag = "KatanaGo_Out_\(endpoint.uniqueID)"

    let hasInputRemoved = midiManager.removedSelections.contains {
      $0.type == .inputConnection && String(describing: $0.selection).contains(inputTag)
    }
    let hasOutputRemoved = midiManager.removedSelections.contains {
      $0.type == .outputConnection && String(describing: $0.selection).contains(outputTag)
    }

    #expect(hasInputRemoved)
    #expect(hasOutputRemoved)
  }
}
