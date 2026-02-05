import KatanaCore
import KatanaGo
import KatanaGoData
import MIDIKit
import XCTest

@testable import KatanaDeviceImpl

final class KatanaGoScannerMIDIKitTests: XCTestCase {

  struct MockEndpoint: MIDIEndpointProtocol {
    var name: String
    var displayName: String?
    var uniqueID: MIDIIdentifier = 0
  }

  actor MockKatanaGo: KatanaDevice {
    func connect() async throws {}
    func disconnect() async {}
    func connectionStatus() async -> ConnectionStatus { .disconnected }
    func readDeviceType() async -> KatanaDeviceType { .go }
    func readData(at address: UInt32, length: UInt16) async throws -> [UInt8] { return [] }
    func write(at address: UInt32, data: [UInt8]) async throws {}
    func writeBank<T: WritableBank>(_ bank: T) async throws {}
    func readBank<T: WritableBank>(_ type: T.Type) async throws -> T {
      return T.buildFromByteArray([])
    }
    func subscribeToData() -> AsyncStream<StreamData> { AsyncStream { $0.finish() } }
  }

  func testScanFindsKatana() async throws {
    let mockManager = MockMIDIManager()
    mockManager.outputEndpoints = [
      MockEndpoint(name: "Other Device", displayName: "Other Device"),
      MockEndpoint(name: "KATANA:GO MIDI", displayName: "KATANA:GO MIDI"),
    ]

    let scanner = KatanaGoScannerMIDIKit(
      midiManager: mockManager,
      retryInterval: 10_000,
      katanaGoFactory: { _, _ in MockKatanaGo() }
    )

    let scanStream = scanner.scan()

    let collectionTask = Task {
      var found: KatanaDevice?
      for await device in scanStream {
        found = device
      }
      return found
    }

    try await Task.sleep(nanoseconds: 100_000_000)

    let foundDevice = await collectionTask.value
    XCTAssertTrue(mockManager.started)
    XCTAssertNotNil(foundDevice)
    XCTAssertTrue(foundDevice is MockKatanaGo)
  }

  func testScanNoKatana() async throws {
    let mockManager = MockMIDIManager()
    mockManager.outputEndpoints = [
      MockEndpoint(name: "Other Device", displayName: "Other Device")
    ]

    let scanner = KatanaGoScannerMIDIKit(midiManager: mockManager, retryInterval: 10_000)

    let scanStream = scanner.scan()

    let collectionTask = Task {
      var count = 0
      for await _ in scanStream {
        count += 1
      }
      return count
    }

    // Wait for it to finish naturally (6 loops * 10k ns = 60k ns)
    try await Task.sleep(nanoseconds: 100_000_000)

    let count = await collectionTask.value
    XCTAssertTrue(mockManager.started)
    XCTAssertEqual(count, 0)
  }

}
