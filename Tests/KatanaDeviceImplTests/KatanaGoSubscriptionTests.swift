import KatanaCore
import KatanaFx
import KatanaGo
import KatanaGoData
import MIDIKit
import Testing

@testable import KatanaDeviceImpl

struct KatanaGoSubscriptionTests {

  @Test func testSubscribeNormalBanks() async throws {
    let (katana, midiManager, _) = try await setupConnectedKatana()

    let bankStream = await katana.subscribeToKatanaGoBanks()

    // Simulate AmpBank update (address 0x20002000, size 14)
    let responseBody: [UInt8] = [
      0x10, 0x01, 0x05, 0x0d, 0x12, 0x20, 0x00, 0x20, 0x00,
      0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00,
      0x00,  // Checksum
    ]
    let responseEvent = try MIDIEvent.sysEx7(manufacturer: .oneByte(0x41), data: responseBody)

    let expectation = Task {
      var banks: [KatanaGoDataBank] = []
      for await bank in bankStream {
        banks.append(bank)
        if banks.count >= 1 { break }
      }
      return banks
    }

    // Give some time for the internal subscription tasks to start
    try await Task.sleep(nanoseconds: 50_000_000)

    midiManager.simulate(event: responseEvent)

    let receivedBanks = try await timeout(after: 2_000_000_000) {
      await expectation.value
    }

    #expect(receivedBanks.count == 1)
    if case .ampBank(let bank) = receivedBanks[0] {
      #expect(bank.gain == 2)
    } else {
      Issue.record("Expected ampBank, got \(receivedBanks[0])")
    }
  }

  @Test func testSubscribeModFxPartialRead() async throws {
    let (katana, midiManager, endpoint) = try await setupConnectedKatana()

    let bankStream = await katana.subscribeToKatanaGoBanks()

    // 1. Send partial MOD data (address 0x20010000, size 5)
    let partialBody: [UInt8] = [
      0x10, 0x01, 0x05, 0x0d, 0x12, 0x20, 0x01, 0x00, 0x00,
      0x01, 0x02, 0x03, 0x04, 0x05,
      0x00,  // Checksum
    ]
    let partialEvent = try MIDIEvent.sysEx7(manufacturer: .oneByte(0x41), data: partialBody)

    let expectation = Task {
      var banks: [KatanaGoDataBank] = []
      for await bank in bankStream {
        banks.append(bank)
        if banks.count >= 1 { break }
      }
      return banks
    }

    // Give some time for the internal subscription tasks to start
    try await Task.sleep(nanoseconds: 50_000_000)

    midiManager.simulate(event: partialEvent)

    // 2. The code should now perform a manual read of 244 bytes at 0x20010000.
    // Give it a moment to send the request
    try await Task.sleep(nanoseconds: 100_000_000)

    let outputConnection =
      midiManager.managedOutputConnections["KatanaGo_Out_\(endpoint.uniqueID)"]
      as! MockMIDIOutputConnection

    // Find the RQ1 for 0x20010000 with size 244
    let rq1 = outputConnection.sentEvents.compactMap { event -> [UInt8]? in
      if case .sysEx7(let sysEx) = event { return sysEx.data }
      return nil
    }.first { body in
      body.count >= 13 && body[4] == 0x11 && Array(body[5...8]) == [0x20, 0x01, 0x00, 0x00]
        && Array(body[9...12]) == [0x00, 0x00, 0x0F, 0x04]
    }

    #expect(rq1 != nil, "Expected RQ1 for base address 0x20010000 with size 244")

    // 3. Simulate response to that manual read
    var fullData = [UInt8](repeating: 0, count: 244)
    fullData[0] = 0x01  // Chorus type or something

    let responseBody: [UInt8] =
      [0x10, 0x01, 0x05, 0x0D, 0x12, 0x20, 0x01, 0x00, 0x00] + fullData + [0x00]
    let responseEvent = try MIDIEvent.sysEx7(manufacturer: .oneByte(0x41), data: responseBody)

    midiManager.simulate(event: responseEvent)

    let receivedBanks = try await timeout(after: 2_000_000_000) {
      await expectation.value
    }

    #expect(receivedBanks.count >= 1)
  }

  @Test func testSubscribeModFxFullRead() async throws {
    let (katana, midiManager, endpoint) = try await setupConnectedKatana()

    let bankStream = await katana.subscribeToKatanaGoBanks()

    // Send full MOD data (244 bytes)
    var fullData = [UInt8](repeating: 0, count: 244)
    fullData[0] = 0x05  // Some value

    let responseBody: [UInt8] =
      [0x10, 0x01, 0x05, 0x0D, 0x12, 0x20, 0x01, 0x00, 0x00] + fullData + [0x00]
    let responseEvent = try MIDIEvent.sysEx7(manufacturer: .oneByte(0x41), data: responseBody)

    let expectation = Task {
      var banks: [KatanaGoDataBank] = []
      for await bank in bankStream {
        banks.append(bank)
        if banks.count >= 1 { break }
      }
      return banks
    }

    // Give some time for the internal subscription tasks to start
    try await Task.sleep(nanoseconds: 50_000_000)

    let outputConnection =
      midiManager.managedOutputConnections["KatanaGo_Out_\(endpoint.uniqueID)"]
      as! MockMIDIOutputConnection
    let initialWriteCount = outputConnection.sentEvents.count

    midiManager.simulate(event: responseEvent)

    let receivedBanks = try await timeout(after: 2_000_000_000) {
      await expectation.value
    }

    // Verify NO additional RQ1 was sent
    #expect(outputConnection.sentEvents.count == initialWriteCount)
    #expect(receivedBanks.count >= 1)
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

  private func timeout<T: Sendable>(
    after nanoseconds: UInt64, body: @escaping @Sendable () async -> T
  ) async throws -> T {
    return try await withThrowingTaskGroup(of: T.self) { group in
      group.addTask {
        await body()
      }
      group.addTask {
        try await Task.sleep(nanoseconds: nanoseconds)
        throw KatanaError.connectionFailed("Timeout")
      }
      let result = try await group.next()!
      group.cancelAll()
      return result
    }
  }
}
