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
    let (katana, midiManager, _) = try await setupConnectedKatana()

    let bankStream = await katana.subscribeToKatanaGoBanks()

    // 1. Send partial MOD data Part 1 (address 0x20010000, size 128)
    // In Roland/Boss, 128 bytes fills up 0x20010000 to 0x2001007F.
    var part1Data = [UInt8](repeating: 0, count: 128)
    part1Data[0] = 0x01  // Chorus type
    let part1Body: [UInt8] =
      [0x10, 0x01, 0x05, 0x0D, 0x12, 0x20, 0x01, 0x00, 0x00] + part1Data + [0x00]
    let part1Event = try MIDIEvent.sysEx7(manufacturer: .oneByte(0x41), data: part1Body)

    // 2. Send partial MOD data Part 2 (address 0x20010100, size 117)
    // This completes the 245 bytes (128 + 117).
    let part2Data = [UInt8](repeating: 0, count: 117)
    let part2Body: [UInt8] =
      [0x10, 0x01, 0x05, 0x0D, 0x12, 0x20, 0x01, 0x01, 0x00] + part2Data + [0x00]
    let part2Event = try MIDIEvent.sysEx7(manufacturer: .oneByte(0x41), data: part2Body)

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

    // Simulate Part 1 - Should not trigger bank yet as cache is incomplete
    midiManager.simulate(event: part1Event)

    // Briefly wait to ensure it's processed
    try await Task.sleep(nanoseconds: 50_000_000)

    // Simulate Part 2 - Now cache has all 245 bytes, should trigger bank
    midiManager.simulate(event: part2Event)

    let receivedBanks = try await timeout(after: 2_000_000_000) {
      await expectation.value
    }

    #expect(receivedBanks.count >= 1)
    if case .modSingleEffect(let effect) = receivedBanks[0], case .chorus = effect {
      // Success
    } else {
      Issue.record("Expected chorus bank, got \(receivedBanks[0])")
    }
  }

  @Test func testSubscribeModFxFullRead() async throws {
    let (katana, midiManager, endpoint) = try await setupConnectedKatana()

    let bankStream = await katana.subscribeToKatanaGoBanks()

    // Send full MOD data (245 bytes)
    var fullData = [UInt8](repeating: 0, count: 245)
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
