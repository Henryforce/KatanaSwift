import KatanaCore
import KatanaGo
import KatanaGoData
import SwiftMIDIIO
import Testing

@testable import KatanaDeviceImpl

struct ByteAndRQ1EncodingTests {

  @Test func testUInt16RoundTripAndEdgeValues() {
    let values: [UInt16] = [0, 1, 15, 16, 127, 128, 255, 256, 450, 1000, 2000, 4096, 65535]

    for value in values {
      let encoded = value.bytes
      #expect(encoded.count == 4)
      #expect(encoded.allSatisfy { $0 <= 0x0F })
      #expect(UInt16.decodeFromByteArray(encoded) == value)
    }

    #expect(UInt16(450).bytes == [0, 1, 12, 2])
    #expect(UInt16(2000).bytes == [0, 7, 13, 0])
    #expect(UInt16(4096).bytes == [1, 0, 0, 0])
  }

  @Test func testUInt16DecodeRejectsShortBuffers() {
    #expect(UInt16.decodeFromByteArray([]) == nil)
    #expect(UInt16.decodeFromByteArray([0x01, 0x02, 0x03]) == nil)
    #expect(UInt16.decodeFromByteArray([0x00, 0x01, 0x02, 0x03], offset: 1) == nil)
    #expect(UInt16.decodeFromByteArray([0x00, 0x01, 0x02, 0x03], offset: -1) == nil)
    #expect(UInt16.decodeFromByteArray([0x00, 0x01, 0x02, 0x03, 0x04], offset: 1) == 0x1234)
  }

  @Test func testRolandAddress7BitEncodingAndArithmetic() {
    #expect(RolandAddress.encode7BitBytes(5) == [0x00, 0x00, 0x00, 0x05])
    #expect(RolandAddress.encode7BitBytes(16) == [0x00, 0x00, 0x00, 0x10])
    #expect(RolandAddress.encode7BitBytes(17) == [0x00, 0x00, 0x00, 0x11])
    #expect(RolandAddress.encode7BitBytes(127) == [0x00, 0x00, 0x00, 0x7F])
    #expect(RolandAddress.encode7BitBytes(128) == [0x00, 0x00, 0x01, 0x00])
    #expect(RolandAddress.encode7BitBytes(245) == [0x00, 0x00, 0x01, 0x75])

    // 7-bit carry-over: 0x20_01_00_7F + 1 == 0x20_01_01_00
    #expect(RolandAddress.adding(1, to: 0x20_01_00_7F) == 0x20_01_01_00)
    #expect(RolandAddress.adding(0x11, to: 0x20_01_00_7F) == 0x20_01_01_10)
  }

  @Test func testRQ1ReadLengthUses7BitEncodingForLargeBanks() async throws {
    let midiManager = MockMIDIManager()
    let endpoint = MockMIDIEndpoint(name: "Katana", displayName: "Katana")
    let inputEndpoint = MockMIDIEndpoint(name: "Katana", displayName: "Katana", uniqueID: 54321)
    midiManager.inputEndpoints = [inputEndpoint]

    let katana = KatanaDeviceImpl(deviceType: .go, endpoint: endpoint, midiManager: midiManager)
    try await katana.connect()

    // DelayBank has size 17 (0x11 in 7-bit), which previously encoded as [0, 0, 1, 1] (129 bytes)
    let readTask = Task {
      try await katana.readData(at: 0x20_01_20_00, length: 17, options: .deviceOnly)
    }

    try await Task.sleep(nanoseconds: 100_000_000)

    let outputConnection =
      midiManager.managedOutputConnections["KatanaGo_Out_\(endpoint.uniqueID)"]
      as! MockMIDIOutputConnection
    guard let lastEvent = outputConnection.sentEvents.last,
      case .sysEx7(let sysEx) = lastEvent
    else {
      Issue.record("Expected SysEx7 event for RQ1")
      return
    }

    let body = sysEx.data
    #expect(body.count >= 13)
    #expect(body[4] == 0x11)
    #expect(Array(body[5...8]) == [0x20, 0x01, 0x20, 0x00])
    #expect(Array(body[9...12]) == [0x00, 0x00, 0x00, 0x11])

    // Complete the pending read with a dummy 17-byte response
    let responseBody: [UInt8] =
      [0x10, 0x01, 0x05, 0x0D, 0x12, 0x20, 0x01, 0x20, 0x00]
      + [UInt8](repeating: 0, count: 17)
      + [0x00]
    let responseEvent = try MIDIEvent.sysEx7(manufacturer: .oneByte(0x41), data: responseBody)
    midiManager.simulate(event: responseEvent)

    let data = try await readTask.value
    #expect(data.count == 17)
  }

  @Test func testRQ1ReadLength245Bytes() async throws {
    let midiManager = MockMIDIManager()
    let endpoint = MockMIDIEndpoint(name: "Katana", displayName: "Katana")
    let inputEndpoint = MockMIDIEndpoint(name: "Katana", displayName: "Katana", uniqueID: 54321)
    midiManager.inputEndpoints = [inputEndpoint]

    let katana = KatanaDeviceImpl(deviceType: .go, endpoint: endpoint, midiManager: midiManager)
    try await katana.connect()

    let readTask = Task {
      try await katana.readData(at: 0x20_01_00_00, length: 245, options: .deviceOnly)
    }

    try await Task.sleep(nanoseconds: 100_000_000)

    let outputConnection =
      midiManager.managedOutputConnections["KatanaGo_Out_\(endpoint.uniqueID)"]
      as! MockMIDIOutputConnection
    guard let lastEvent = outputConnection.sentEvents.last,
      case .sysEx7(let sysEx) = lastEvent
    else {
      Issue.record("Expected SysEx7 event for RQ1")
      return
    }

    let body = sysEx.data
    #expect(body.count >= 13)
    #expect(Array(body[9...12]) == [0x00, 0x00, 0x01, 0x75])

    let responseBody: [UInt8] =
      [0x10, 0x01, 0x05, 0x0D, 0x12, 0x20, 0x01, 0x00, 0x00]
      + [UInt8](repeating: 0, count: 245)
      + [0x00]
    let responseEvent = try MIDIEvent.sysEx7(manufacturer: .oneByte(0x41), data: responseBody)
    midiManager.simulate(event: responseEvent)

    let data = try await readTask.value
    #expect(data.count == 245)
  }
}
