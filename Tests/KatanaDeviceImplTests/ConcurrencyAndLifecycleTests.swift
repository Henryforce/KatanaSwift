import KatanaCore
import KatanaGo
import KatanaGoData
import SwiftMIDIIO
import Testing

@testable import KatanaDeviceImpl

struct ConcurrencyAndLifecycleTests {

  @Test func testConcurrentReadsToSameAddressBothResolve() async throws {
    let (katana, midiManager, _) = try await setupConnectedKatana()

    let read1 = Task {
      try await katana.readData(at: 0x20_00_20_00, length: 2, options: .deviceOnly)
    }
    let read2 = Task {
      try await katana.readData(at: 0x20_00_20_00, length: 2, options: .deviceOnly)
    }

    try await Task.sleep(nanoseconds: 50_000_000)

    let responseBody: [UInt8] = [
      0x10, 0x01, 0x05, 0x0D, 0x12, 0x20, 0x00, 0x20, 0x00, 0x2A, 0x3B, 0x00,
    ]
    let responseEvent = try MIDIEvent.sysEx7(manufacturer: .oneByte(0x41), data: responseBody)
    midiManager.simulate(event: responseEvent)

    let (result1, result2) = try await (read1.value, read2.value)
    #expect(result1 == [0x2A, 0x3B])
    #expect(result2 == [0x2A, 0x3B])
  }

  @Test func testReadTimeoutThrowsTimeoutError() async throws {
    let (katana, _, _) = try await setupConnectedKatana(readTimeoutNanoseconds: 50_000_000)

    await #expect(throws: KatanaError.timeout) {
      _ = try await katana.readData(at: 0x20_00_20_00, length: 2, options: .deviceOnly)
    }
  }

  @Test func testReadTaskCancellationThrowsCancellationError() async throws {
    let (katana, _, _) = try await setupConnectedKatana(readTimeoutNanoseconds: 5_000_000_000)

    let readTask = Task {
      try await katana.readData(at: 0x20_00_20_00, length: 2, options: .deviceOnly)
    }

    try await Task.sleep(nanoseconds: 50_000_000)
    readTask.cancel()

    await #expect(throws: CancellationError.self) {
      _ = try await readTask.value
    }
  }

  @Test func testDisconnectFailsPendingReadsAndFinishesSubscribers() async throws {
    let (katana, _, _) = try await setupConnectedKatana(readTimeoutNanoseconds: 5_000_000_000)

    let bankStream = katana.subscribeToKatanaGoBanks()
    let readTask = Task {
      try await katana.readData(at: 0x20_00_20_00, length: 2, options: .deviceOnly)
    }

    let streamFinishedTask = Task {
      for await _ in bankStream {}
      return true
    }

    try await Task.sleep(nanoseconds: 50_000_000)
    await katana.disconnect()

    await #expect(throws: KatanaError.notConnected) {
      _ = try await readTask.value
    }
    let finished = await streamFinishedTask.value
    #expect(finished == true)
  }

  @Test func testMultipleSubscribersReceiveEvents() async throws {
    let (katana, midiManager, _) = try await setupConnectedKatana()

    let stream1 = katana.subscribeToData()
    let stream2 = katana.subscribeToData()

    let task1 = Task {
      var iterator = stream1.makeAsyncIterator()
      return await iterator.next()
    }
    let task2 = Task {
      var iterator = stream2.makeAsyncIterator()
      return await iterator.next()
    }

    try await Task.sleep(nanoseconds: 50_000_000)

    let responseBody: [UInt8] = [
      0x10, 0x01, 0x05, 0x0D, 0x12, 0x20, 0x00, 0x20, 0x00, 0x11, 0x22, 0x00,
    ]
    let responseEvent = try MIDIEvent.sysEx7(manufacturer: .oneByte(0x41), data: responseBody)
    midiManager.simulate(event: responseEvent)

    let item1 = await task1.value
    let item2 = await task2.value
    #expect(item1?.address == 0x20_00_20_00)
    #expect(item1?.data == [0x11, 0x22])
    #expect(item2?.address == 0x20_00_20_00)
    #expect(item2?.data == [0x11, 0x22])
  }

  @Test func testConnectionStatusStreamEmitsTransitionsAndDeviceTypeIsSynchronous() async throws {
    let midiManager = MockMIDIManager()
    let endpoint = MockMIDIEndpoint(name: "Katana", displayName: "Katana")
    let inputEndpoint = MockMIDIEndpoint(name: "Katana", displayName: "Katana", uniqueID: 54321)
    midiManager.inputEndpoints = [inputEndpoint]

    let katana = KatanaDeviceImpl(deviceType: .go, endpoint: endpoint, midiManager: midiManager)
    #expect(katana.deviceType == .go)

    let stream = katana.connectionStatusStream()
    let collectTask = Task {
      var statuses: [ConnectionStatus] = []
      for await status in stream {
        statuses.append(status)
        if statuses.count >= 5 { break }
      }
      return statuses
    }

    try await Task.sleep(nanoseconds: 50_000_000)
    try await katana.connect()
    await katana.disconnect()

    let statuses = await collectTask.value
    #expect(statuses == [.disconnected, .connecting, .connected, .disconnecting, .disconnected])
  }

  @Test func testIgnoresNonKatanaGoSysEx() async throws {
    let (katana, midiManager, _) = try await setupConnectedKatana()

    // Wrong manufacturer (0x43 Yamaha) and wrong model ID ([0x00, 0x00, 0x00])
    let wrongManufacturer = try MIDIEvent.sysEx7(
      manufacturer: .oneByte(0x43),
      data: [0x10, 0x01, 0x05, 0x0D, 0x12, 0x20, 0x00, 0x20, 0x00, 0x77, 0x00]
    )
    let wrongModel = try MIDIEvent.sysEx7(
      manufacturer: .oneByte(0x41),
      data: [0x10, 0x00, 0x00, 0x00, 0x12, 0x20, 0x00, 0x20, 0x00, 0x77, 0x00]
    )

    midiManager.simulate(event: wrongManufacturer)
    midiManager.simulate(event: wrongModel)

    try await Task.sleep(nanoseconds: 30_000_000)
    #expect(await katana.cachedData(at: 0x20_00_20_00, length: 1) == nil)
  }

  @Test func testConnectFailureRollsBackPartialConnections() async throws {
    let midiManager = FailingInputMIDIManager()
    let endpoint = MockMIDIEndpoint(name: "Katana", displayName: "Katana")
    let inputEndpoint = MockMIDIEndpoint(name: "Katana", displayName: "Katana", uniqueID: 54321)
    midiManager.inputEndpoints = [inputEndpoint]

    let katana = KatanaDeviceImpl(deviceType: .go, endpoint: endpoint, midiManager: midiManager)

    await #expect(throws: KatanaError.self) {
      try await katana.connect()
    }

    #expect(midiManager.managedOutputConnections.isEmpty)
    #expect(await katana.connectionStatus() == .disconnected)
  }

  private func setupConnectedKatana(readTimeoutNanoseconds: UInt64 = 5_000_000_000) async throws
    -> (KatanaDeviceImpl, MockMIDIManager, MockMIDIEndpoint)
  {
    let midiManager = MockMIDIManager()
    let endpoint = MockMIDIEndpoint(name: "Katana", displayName: "Katana")
    let inputEndpoint = MockMIDIEndpoint(name: "Katana", displayName: "Katana", uniqueID: 54321)
    midiManager.inputEndpoints = [inputEndpoint]

    let katana = KatanaDeviceImpl(
      deviceType: .go,
      endpoint: endpoint,
      midiManager: midiManager,
      readTimeoutNanoseconds: readTimeoutNanoseconds
    )
    try await katana.connect()
    return (katana, midiManager, endpoint)
  }
}

private final class FailingInputMIDIManager: MIDIManagerProtocol, @unchecked Sendable {
  var outputEndpoints: [MIDIEndpointProtocol] = []
  var inputEndpoints: [MIDIEndpointProtocol] = []
  var managedOutputConnections: [String: MIDIOutputConnectionProtocol] = [:]
  var managedInputConnections: [String: MIDIInputConnectionProtocol] = [:]

  func start() throws {}
  func loadManagedOutputConnections() -> [String: MIDIOutputConnectionProtocol] {
    managedOutputConnections
  }
  func loadManagedInputConnections() -> [String: MIDIInputConnectionProtocol] {
    managedInputConnections
  }
  func addOutputConnection(to inputs: [MIDIEndpointProtocol], tag: String) throws {
    managedOutputConnections[tag] = MockMIDIOutputConnection()
  }
  func addInputConnection(
    to outputs: [MIDIEndpointProtocol], tag: String, receiver: MIDIReceiver
  ) throws {
    throw KatanaError.connectionFailed("Simulated input failure")
  }
  func remove(_ type: MIDIManager.ManagedType, _ selection: MIDIManager.TagSelection) {
    if case .withTag(let tag) = selection {
      managedInputConnections.removeValue(forKey: tag)
      managedOutputConnections.removeValue(forKey: tag)
    }
  }
}
