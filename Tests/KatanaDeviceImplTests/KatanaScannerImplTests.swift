import KatanaCore
import KatanaGo
import KatanaGoData
import SwiftMIDIIO
import Testing

@testable import KatanaDeviceImpl

struct KatanaGoScannerMIDITests {

  struct MockEndpoint: MIDIEndpointProtocol {
    var name: String
    var displayName: String
    var uniqueID: MIDIIdentifier = 0
  }

  actor MockKatanaGo: KatanaDevice {
    nonisolated var deviceType: KatanaDeviceType { .go }
    func connect() async throws {}
    func disconnect() async {}
    func connectionStatus() async -> ConnectionStatus { .disconnected }
    nonisolated func connectionStatusStream() -> AsyncStream<ConnectionStatus> {
      AsyncStream { $0.finish() }
    }
    func readData(at address: UInt32, length: UInt16, options: ReadDataOptions) async throws
      -> [UInt8]
    { return [] }
    func write(at address: UInt32, data: [UInt8]) async throws {}
    nonisolated func subscribeToData() -> AsyncStream<StreamData> { AsyncStream { $0.finish() } }
  }

  @Test func testScanFindsKatana() async throws {
    let mockManager = MockMIDIManager()
    mockManager.outputEndpoints = [
      MockEndpoint(name: "Other Device", displayName: "Other Device"),
      MockEndpoint(name: "KATANA:GO MIDI", displayName: "KATANA:GO MIDI"),
    ]

    let scanner = KatanaScannerImpl(
      midiManager: mockManager,
      deviceFactory: { _, _ in MockKatanaGo() }
    )

    var found: KatanaDevice?
    for await device in scanner.scan() {
      found = device
    }

    #expect(mockManager.started)
    #expect(found is MockKatanaGo)
  }

  @Test func testScanNoKatana() async throws {
    let mockManager = MockMIDIManager()
    mockManager.outputEndpoints = [
      MockEndpoint(name: "Other Device", displayName: "Other Device")
    ]

    let scanner = KatanaScannerImpl(midiManager: mockManager)

    var count = 0
    for await _ in scanner.scan() {
      count += 1
    }

    #expect(mockManager.started)
    #expect(count == 0)
  }
}
