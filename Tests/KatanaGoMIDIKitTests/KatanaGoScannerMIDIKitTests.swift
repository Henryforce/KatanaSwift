import XCTest
import MIDIKit
@testable import KatanaGoMIDIKit
import KatanaGoAPI
import KatanaGoData

final class KatanaGoScannerMIDIKitTests: XCTestCase {
    
    struct MockEndpoint: MIDIEndpointProxy {
        var name: String
        var displayName: String
    }
    
    final class MockMIDIManager: MIDIManagerProtocol, @unchecked Sendable {
        var startCalled = false
        var mockOutputs: [any MIDIEndpointProxy] = []
        
        func start() throws {
            startCalled = true
        }
        
        var outputEndpoints: [any MIDIEndpointProxy] {
            mockOutputs
        }
    }


    actor MockKatanaGo: KatanaGo {
        func connect() async throws {}
        func disconnect() async {}
        func connectionStatus() async -> ConnectionStatus { .disconnected }
        func write(_ command: KatanaGoWriteData) async throws {}
        func read() -> AsyncStream<KatanaGoReadData> { AsyncStream { $0.finish() } }
    }


    func testScanFindsKatana() async {
        let mockManager = MockMIDIManager()
        mockManager.mockOutputs = [
            MockEndpoint(name: "Other Device", displayName: "Other Device"),
            MockEndpoint(name: "KATANA:GO MIDI", displayName: "KATANA:GO MIDI")
        ]
        
        let scanner = KatanaGoScannerMIDIKit(
            midiManager: mockManager,
            retryInterval: 10_000,
            katanaGoFactory: { _, _ in MockKatanaGo() }
        )
        
        let scanStream = scanner.scan()
        
        let collectionTask = Task {
            var found: KatanaGo?
            for await device in scanStream {
                found = device
            }
            return found
        }
        
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        let foundDevice = await collectionTask.value
        XCTAssertTrue(mockManager.startCalled)
        XCTAssertNotNil(foundDevice)
        XCTAssertTrue(foundDevice is MockKatanaGo)
    }

    
    func testScanNoKatana() async {
        let mockManager = MockMIDIManager()
        mockManager.mockOutputs = [
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
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        let count = await collectionTask.value
        XCTAssertTrue(mockManager.startCalled)
        XCTAssertEqual(count, 0)
    }


}
