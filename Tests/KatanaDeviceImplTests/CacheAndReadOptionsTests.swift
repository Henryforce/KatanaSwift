import KatanaCore
import KatanaGo
import KatanaGoData
import KatanaUtils
import SwiftMIDIIO
import Testing

@testable import KatanaDeviceImpl

struct CacheAndReadOptionsTests {

  // MARK: - KatanaMemoryBankCache Tests

  @Test func testCacheMissAndPartialHitReturnNil() {
    var cache = KatanaMemoryBankCache()
    #expect(cache.get(address: 0x20_00_20_00, length: 4) == nil)
    #expect(cache.get(address: 0x20_00_20_00, length: 0) == [])
    #expect(cache.get(address: 0x20_00_20_00, length: -1) == nil)

    cache.update(address: 0x20_00_20_00, data: [0x01, 0x02, 0x03])
    #expect(cache.get(address: 0x20_00_20_00, length: 3) == [0x01, 0x02, 0x03])
    // Requesting 4 bytes when only 3 are cached must return nil (not a truncated prefix)
    #expect(cache.get(address: 0x20_00_20_00, length: 4) == nil)
    // Gap at offset +3, data at +4
    cache.update(address: 0x20_00_20_04, data: [0x05])
    #expect(cache.get(address: 0x20_00_20_00, length: 5) == nil)
  }

  @Test func testCacheValueSemantics() {
    var cache1 = KatanaMemoryBankCache()
    cache1.update(address: 0x20_00_20_00, data: [0x0A, 0x0B])

    var cache2 = cache1
    cache2.update(address: 0x20_00_20_00, data: [0x11, 0x22])

    #expect(cache1.get(address: 0x20_00_20_00, length: 2) == [0x0A, 0x0B])
    #expect(cache2.get(address: 0x20_00_20_00, length: 2) == [0x11, 0x22])
  }

  @Test func testCache7BitBoundaryCrossingAndOverflow() {
    var cache = KatanaMemoryBankCache()
    cache.update(address: 0x20_00_20_7E, data: [0x01, 0x02, 0x03, 0x04])

    #expect(cache.get(address: 0x20_00_20_7E, length: 2) == [0x01, 0x02])
    #expect(cache.get(address: 0x20_00_21_00, length: 2) == [0x03, 0x04])
    #expect(cache.get(address: 0x20_00_20_7E, length: 4) == [0x01, 0x02, 0x03, 0x04])

    // Top of 28-bit address space should not trap on overflow
    cache.update(address: 0x7F_7F_7F_7F, data: [0x55, 0x66])
    #expect(cache.get(address: 0x7F_7F_7F_7F, length: 1) == [0x55])
    #expect(cache.get(address: 0x7F_7F_7F_7F, length: 2) == nil)
  }

  // MARK: - ReadDataOptions Tests

  @Test func testCacheOnlyThrowsWhenMissingOrPartial() async throws {
    let (katana, _, _) = try await setupConnectedKatana()

    await #expect(throws: KatanaError.self) {
      _ = try await katana.readData(at: 0x20_00_20_00, length: 4, options: .cacheOnly)
    }

    // Write only 2 bytes, then ask for 4 bytes from cacheOnly -> must still throw
    try await katana.write(at: 0x20_00_20_00, data: [0x01, 0x02])
    await #expect(throws: KatanaError.self) {
      _ = try await katana.readData(at: 0x20_00_20_00, length: 4, options: .cacheOnly)
    }

    let exact = try await katana.readData(at: 0x20_00_20_00, length: 2, options: .cacheOnly)
    #expect(exact == [0x01, 0x02])
  }

  @Test func testCacheFirstDeviceSecondFallsBackToDeviceOnMiss() async throws {
    let (katana, midiManager, endpoint) = try await setupConnectedKatana()

    // Seed only 1 byte at 0x20_00_20_00, then request 3 bytes -> cache miss, must query device
    try await katana.write(at: 0x20_00_20_00, data: [0x01])

    let outputConnection =
      midiManager.managedOutputConnections["KatanaGo_Out_\(endpoint.uniqueID)"]
      as! MockMIDIOutputConnection
    let initialSentCount = outputConnection.sentEvents.count

    let readTask = Task {
      try await katana.readData(at: 0x20_00_20_00, length: 3, options: .cacheFirstDeviceSecond)
    }

    try await Task.sleep(nanoseconds: 100_000_000)

    // Verify RQ1 was sent
    #expect(outputConnection.sentEvents.count == initialSentCount + 1)

    let responseBody: [UInt8] = [
      0x10, 0x01, 0x05, 0x0D, 0x12, 0x20, 0x00, 0x20, 0x00, 0x0A, 0x0B, 0x0C, 0x00,
    ]
    let responseEvent = try MIDIEvent.sysEx7(manufacturer: .oneByte(0x41), data: responseBody)
    midiManager.simulate(event: responseEvent)

    let result = try await readTask.value
    #expect(result == [0x0A, 0x0B, 0x0C])

    // Subsequent cacheFirstDeviceSecond should hit cache without sending RQ1
    let sentBeforeCacheHit = outputConnection.sentEvents.count
    let cachedResult = try await katana.readData(
      at: 0x20_00_20_00, length: 3, options: .cacheFirstDeviceSecond)
    #expect(cachedResult == [0x0A, 0x0B, 0x0C])
    #expect(outputConnection.sentEvents.count == sentBeforeCacheHit)
  }

  @Test func testDeviceFirstCacheSecondFallsBackToCacheOnSendFailure() async throws {
    let (katana, midiManager, endpoint) = try await setupConnectedKatana()

    // Populate cache while connected
    try await katana.write(at: 0x20_00_20_00, data: [0x07, 0x08, 0x09])

    // Drop output connection so writeRawBytes throws when attempting device read
    midiManager.managedOutputConnections.removeValue(forKey: "KatanaGo_Out_\(endpoint.uniqueID)")

    let result = try await katana.readData(
      at: 0x20_00_20_00, length: 3, options: .deviceFirstCacheSecond)
    #expect(result == [0x07, 0x08, 0x09])
  }

  @Test func testFailedWriteDoesNotPolluteCache() async throws {
    let midiManager = MockMIDIManager()
    let endpoint = MockMIDIEndpoint(name: "Katana", displayName: "Katana")
    let katana = KatanaDeviceImpl(deviceType: .go, endpoint: endpoint, midiManager: midiManager)

    // Not connected -> writeRawBytes throws
    await #expect(throws: KatanaError.self) {
      try await katana.write(at: 0x20_00_20_00, data: [0x01, 0x02])
    }

    let cached = await katana.cachedData(at: 0x20_00_20_00, length: 2)
    #expect(cached == nil)
  }

  private func setupConnectedKatana() async throws -> (
    KatanaDeviceImpl, MockMIDIManager, MockMIDIEndpoint
  ) {
    let midiManager = MockMIDIManager()
    let endpoint = MockMIDIEndpoint(name: "Katana", displayName: "Katana")
    let inputEndpoint = MockMIDIEndpoint(name: "Katana", displayName: "Katana", uniqueID: 54321)
    midiManager.inputEndpoints = [inputEndpoint]

    let katana = KatanaDeviceImpl(deviceType: .go, endpoint: endpoint, midiManager: midiManager)
    try await katana.connect()
    return (katana, midiManager, endpoint)
  }
}
