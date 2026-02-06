import KatanaCore
import KatanaFx
import KatanaGo
import KatanaGoData
import MIDIKit
import Testing

@testable import KatanaDeviceImpl

struct KatanaGoMIDIKitTests {

  @Test func testConnectionStatus() async throws {
    let midiManager = MockMIDIManager()
    let endpoint = MockMIDIEndpoint(name: "Katana", displayName: "Katana")
    let katana = KatanaGoMIDIKit(deviceType: .go, endpoint: endpoint, midiManager: midiManager)

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

    let katana = KatanaGoMIDIKit(deviceType: .go, endpoint: endpoint, midiManager: midiManager)

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

    let katana = KatanaGoMIDIKit(deviceType: .go, endpoint: endpoint, midiManager: midiManager)

    await #expect(throws: KatanaError.self) {
      try await katana.connect()
    }
  }

  @Test func testDisconnect() async throws {
    let midiManager = MockMIDIManager()
    let endpoint = MockMIDIEndpoint(name: "Katana", displayName: "Katana")
    let katana = KatanaGoMIDIKit(deviceType: .go, endpoint: endpoint, midiManager: midiManager)

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

  @Test func testReadBank() async throws {
    let (katana, midiManager, endpoint) = try await setupConnectedKatana()

    // Start reading in a separate Task
    let readTask = Task {
      try await katana.readBank(CompBank.self)
    }

    // Give it a moment to send the request and register the continuation
    try await Task.sleep(nanoseconds: 100_000_000)

    // Verify RQ1 request was sent
    let outputConnection =
      midiManager.managedOutputConnections["KatanaGo_Out_\(endpoint.uniqueID)"]
      as! MockMIDIOutputConnection
    // Last event should be the RQ1
    guard let lastEvent = outputConnection.sentEvents.last,
      case .sysEx7(let sysEx) = lastEvent
    else {
      Issue.record("Expected SysEx7 event for RQ1")
      return
    }

    // RQ1 should have address 0x20010032 and size 5
    // Header (F0, 41, 10, 01, 05, 0d, 11) + Address (20, 01, 00, 32) + Size (00, 00, 00, 05)
    let body = sysEx.data  // Should contain 10, 01, 05, 0d, 11, ...
    #expect(body.count >= 13)
    #expect(body[4] == 0x11)  // RQ1 command
    #expect(Array(body[5...8]) == [0x20, 0x01, 0x00, 0x32])  // Address
    #expect(Array(body[9...12]) == [0x00, 0x00, 0x00, 0x05])  // Size

    // Now simulate response (DT1)
    // Preamble (10, 01, 05, 0d, 12) + Address (20, 01, 00, 32) + Data (5 bytes) + Checksum
    let responseBody: [UInt8] = [
      0x10, 0x01, 0x05, 0x0d, 0x12, 0x20, 0x01, 0x00, 0x32, 0x01, 0x10, 0x20, 0x30, 0x40, 0x00,
    ]
    let responseEvent = try MIDIEvent.sysEx7(manufacturer: .oneByte(0x41), data: responseBody)
    midiManager.simulate(event: responseEvent)

    let bank = try await readTask.value
    #expect(bank.type == .hiBand)  // 0x01
    #expect(bank.sustain == 16)  // 0x10
    #expect(bank.attack == 32)  // 0x20
    #expect(bank.tone == 48)  // 0x30
    #expect(bank.level == 64)  // 0x40
  }

  @Test func testReadFxBank() async throws {
    let (katana, midiManager, _) = try await setupConnectedKatana()

    // Read CompBank on FX channel
    let readTask = Task {
      try await katana.readFxBank(CompBank.self, channel: .fx)
    }

    try await Task.sleep(nanoseconds: 100_000_000)

    // Simulate response with offset address 0x20011032
    let responseBody: [UInt8] = [
      0x10, 0x01, 0x05, 0x0d, 0x12, 0x20, 0x01, 0x10, 0x32, 0x02, 0x05, 0x05, 0x05, 0x05, 0x00,
    ]
    let responseEvent = try MIDIEvent.sysEx7(manufacturer: .oneByte(0x41), data: responseBody)
    midiManager.simulate(event: responseEvent)

    let bank = try await readTask.value
    #expect(bank.type == .light)  // 0x02
  }

  @Test func testWriteFxBank() async throws {
    let (katana, midiManager, endpoint) = try await setupConnectedKatana()

    var dc30 = DC30Bank()
    dc30.type = .echo
    dc30.inputVolume = 75
    dc30.echoRepeatTime = 450

    try await katana.writeFxBank(dc30, channel: .fx)

    let outputConnection =
      midiManager.managedOutputConnections["KatanaGo_Out_\(endpoint.uniqueID)"]
      as! MockMIDIOutputConnection

    let bodies = outputConnection.sentEvents.compactMap { event -> [UInt8]? in
      if case .sysEx7(let sysEx) = event {
        return sysEx.data
      }
      return nil
    }

    // DC30Bank base address is 0x20010147.
    // FX channel modifier 0x20001000 makes it 0x20011147.

    // Find the write for 'type' (offset 0)
    let typeWrite = bodies.first { body in
      body.count >= 10 && Array(body[5...8]) == [0x20, 0x01, 0x11, 0x47]
    }
    #expect(typeWrite != nil)
    #expect(typeWrite?[9] == 0x01)  // DC30Type.echo

    // Find the write for 'inputVolume' (offset 1)
    let volumeWrite = bodies.first { body in
      body.count >= 10 && Array(body[5...8]) == [0x20, 0x01, 0x11, 0x48]
    }
    #expect(volumeWrite != nil)
    #expect(volumeWrite?[9] == 75)

    // Find the write for 'echoRepeatTime' (offset 3, UInt16)
    let echoWrite = bodies.first { body in
      body.count >= 13 && Array(body[5...8]) == [0x20, 0x01, 0x11, 0x4A]
    }
    #expect(echoWrite != nil)
    // 450 decimal is encoded as [0, 1, 28, 2] in this implementation
    #expect(Array(echoWrite![9...12]) == [0, 1, 28, 2])
  }

  @Test func testDataCaching() async throws {
    let (katana, midiManager, _) = try await setupConnectedKatana()

    // 1. Test caching via write
    let address: UInt32 = 0x2000_2000
    let data: [UInt8] = [0x01, 0x02, 0x03, 0x04, 0x05]
    try await katana.write(at: address, data: data)

    let cached = await katana.cachedData(at: address, length: 5)
    #expect(cached == data)

    // 2. Test caching via incoming SysEx (DT1)
    // Address 0x2000207F (near boundary)
    let boundaryAddress: UInt32 = 0x2000_207F
    let boundaryData: [UInt8] = [0x0A, 0x0B]
    // Preamble (10, 01, 05, 0d, 12) + Address (20, 00, 20, 7F) + Data (0A, 0B) + Checksum
    let responseBody: [UInt8] = [
      0x10, 0x01, 0x05, 0x0d, 0x12, 0x20, 0x00, 0x20, 0x7F, 0x0A, 0x0B, 0x00,
    ]
    let responseEvent = try MIDIEvent.sysEx7(manufacturer: .oneByte(0x41), data: responseBody)
    midiManager.simulate(event: responseEvent)

    // Give it a moment to process the event
    try await Task.sleep(nanoseconds: 10_000_000)

    let cachedBoundary = await katana.cachedData(at: boundaryAddress, length: 2)
    #expect(cachedBoundary == boundaryData)

    // Verify boundary crossing:
    // First byte (0x0A) should be at (20, 00, 20) offset 7F
    let firstByte = await katana.cachedData(at: 0x2000_207F, length: 1)
    #expect(firstByte == [0x0A])
    // Second byte (0x0B) should be at (20, 00, 21) offset 00
    let secondByte = await katana.cachedData(at: 0x2000_2100, length: 1)
    #expect(secondByte == [0x0B])
  }

  @Test func testLongDataCrossingBoundary() async throws {
    let (katana, _, _) = try await setupConnectedKatana()

    // 150 bytes starting at 0x20002000
    // This should fill all 128 bytes of bank (20, 00, 20) and 22 bytes of bank (20, 00, 21)
    let address: UInt32 = 0x2000_2000
    let data = (0..<150).map { UInt8($0 % 128) }

    try await katana.write(at: address, data: data)

    let cached = await katana.cachedData(at: address, length: 150)
    #expect(cached == data)

    // Verify specifically the crossover point
    // Byte at index 127 (last byte of first bank)
    let lastByteFirstBank = await katana.cachedData(at: 0x2000_207F, length: 1)
    #expect(lastByteFirstBank == [data[127]])

    // Byte at index 128 (first byte of second bank)
    let firstByteSecondBank = await katana.cachedData(at: 0x2000_2100, length: 1)
    #expect(firstByteSecondBank == [data[128]])

    // Verify we can read a chunk spanning the boundary
    let crossChunk = await katana.cachedData(at: 0x2000_207E, length: 4)
    #expect(crossChunk == Array(data[126...129]))
  }

  @Test func testComplexDataCaching() async throws {
    let (katana, midiManager, _) = try await setupConnectedKatana()

    let address: UInt32 = 0x2001_0000
    let data: [UInt8] = [
      4, 43, 46, 3, 75, 33, 48, 3, 65, 80, 31, 40, 82, 50, 0, 60, 0, 0, 70, 40, 55, 0, 0, 100, 0,
      70,
      60, 100, 70, 85, 65, 50, 80, 45, 50, 85, 60, 50, 0, 50, 100, 100, 45, 50, 60, 0, 50, 50, 50,
      0,
      0, 50, 50, 50, 50, 0, 0, 30, 11, 10, 30, 1, 1, 50, 35, 35, 0, 50, 1, 35, 50, 50, 60, 0, 50,
      20,
      20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 0, 20, 13, 1, 20, 23, 1, 20, 20, 14, 20, 0, 50, 50,
      50,
      50, 50, 50, 50, 50, 1, 50, 50, 16, 50, 50, 50, 0, 40, 30, 40, 50, 50, 25, 0, 0, 62, 100, 50,
      0,
      100, 0, 1, 24, 50, 0, 0, 0, 0, 70, 1, 24, 50, 0, 0, 0, 0, 70, 0, 100, 1, 12, 0, 0, 0, 0, 70,
      7,
      0, 0, 0, 0, 80, 0, 100, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24,
      24,
      24, 24, 24, 24, 24, 24, 1, 0, 2, 50, 80, 100, 50, 100, 1, 50, 45, 50, 50, 80, 0, 50, 50, 0, 1,
      9, 0, 50, 100, 50, 0, 50, 50, 3, 50, 8, 0, 50, 50, 50, 50, 50, 70, 0, 50, 50, 50, 100, 50, 0,
      100, 1, 1, 50, 35, 35, 0, 50, 0, 40, 30, 40, 49, 69,
    ]

    // Simulate incoming DT1 message
    // Preamble (10, 01, 05, 0d, 12) + Address (20, 01, 00, 00) + Data + Checksum
    var responseBody: [UInt8] = [0x10, 0x01, 0x05, 0x0D, 0x12, 0x20, 0x01, 0x00, 0x00]
    responseBody.append(contentsOf: data)
    responseBody.append(0x00)  // Mock checksum

    let responseEvent = try MIDIEvent.sysEx7(manufacturer: .oneByte(0x41), data: responseBody)
    midiManager.simulate(event: responseEvent)

    // Give it a moment to process the event
    try await Task.sleep(nanoseconds: 50_000_000)

    let cached = await katana.cachedData(at: address, length: data.count)
    #expect(cached == data)

    // Verify boundary crossing:
    // First byte at 0x20010000
    let firstByte = await katana.cachedData(at: 0x2001_0000, length: 1)
    #expect(firstByte == [data[0]])

    // 128th byte at 0x2001007F
    let byte127 = await katana.cachedData(at: 0x2001_007F, length: 1)
    #expect(byte127 == [data[127]])

    // 129th byte at 0x20010100
    let byte128 = await katana.cachedData(at: 0x2001_0100, length: 1)
    #expect(byte128 == [data[128]])

    // Final byte
    let lastByte = await katana.cachedData(at: 0x2001_0172, length: 1)  // 0x20010000 + 242 in Roland spacing
    #expect(lastByte == [data.last!])
  }

  private func setupConnectedKatana() async throws -> (
    KatanaGoMIDIKit, MockMIDIManager, MockMIDIEndpoint
  ) {
    let midiManager = MockMIDIManager()
    let endpoint = MockMIDIEndpoint(name: "Katana", displayName: "Katana")
    let inputEndpoint = MockMIDIEndpoint(name: "Katana", displayName: "Katana", uniqueID: 54321)
    midiManager.inputEndpoints = [inputEndpoint]

    let katana = KatanaGoMIDIKit(deviceType: .go, endpoint: endpoint, midiManager: midiManager)
    try await katana.connect()
    return (katana, midiManager, endpoint)
  }
}

extension MockMIDIManager {
  func simulate(event: MIDIEvent) {
    for connection in addedInputConnections {
      if case .events(_, let handler) = connection.receiver {
        handler([event], 0, nil)
      }
    }
  }
}
