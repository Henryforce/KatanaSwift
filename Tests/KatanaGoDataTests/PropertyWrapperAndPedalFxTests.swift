import KatanaCore
import Testing

@testable import KatanaGoData

struct PropertyWrapperAndPedalFxTests {

  @Test func testEqualityIgnoresDirtyFlag() {
    let defaultBank = AmpBank()
    let modifiedSameValue = AmpBank(gain: 50, type: .clean)

    #expect(defaultBank == modifiedSameValue)
    #expect(defaultBank.hashValue == modifiedSameValue.hashValue)
  }

  @Test func testReadModifyWriteOnlyEmitsChangedProperties() {
    var bytes = [UInt8](repeating: 0, count: Int(AmpBank.size))
    bytes[0x00] = 65  // gain
    bytes[0x01] = 80  // volume
    bytes[0x0C] = AmpType.crunch.rawValue

    var bank = AmpBank.buildFromByteArray(bytes)
    #expect(bank.gain == 65)
    #expect(bank.volume == 80)
    #expect(bank.type == .crunch)

    // Freshly decoded bank must have no pending writes
    #expect(bank.loadWriteData(baseAddress: AmpBank.katanaGoAddress).isEmpty)

    // Mutating one property should emit only that single write
    bank.treble = 72
    let writes = bank.loadWriteData(baseAddress: AmpBank.katanaGoAddress)
    #expect(writes.count == 1)
    #expect(writes.first?.address == 0x20_00_20_05)
    #expect(writes.first?.data == [72])
  }

  @Test func testReverbTimeOffsetFromMinRoundTrip() {
    // ReverbBank.time has range: 1...100, offsetFromMin: true
    // Wire value 0 == 1, 49 == 50, 99 == 100
    var bytes = [UInt8](repeating: 0, count: Int(ReverbBank.size))

    bytes[0x02] = 0
    #expect(ReverbBank.buildFromByteArray(bytes).time == 1)

    bytes[0x02] = 49
    #expect(ReverbBank.buildFromByteArray(bytes).time == 50)

    bytes[0x02] = 99
    #expect(ReverbBank.buildFromByteArray(bytes).time == 100)

    // Writing time = 100 should emit wire byte 99
    let updated = ReverbBank(time: 100)
    let writes = updated.loadWriteData(baseAddress: ReverbBank.katanaGoAddress)
    #expect(writes.count == 1)
    #expect(writes.first?.address == 0x20_01_40_02)
    #expect(writes.first?.data == [99])
  }

  @Test func testPedalFxBanksWriteAddressesAndShortBuffer() {
    let pedalFx = PedalFxBanks(
      wah: PedalFxWahBank(pedalPosition: 25),
      bend: PedalFxBendBank(pitch: 60),
      wah95: PedalFxWah95Bank(effectLevel: 80)
    )

    let writes = pedalFx.loadWriteData(baseAddress: PedalFxBanks.katanaGoAddress)
    #expect(writes.count == 3)

    let wahWrite = writes.first { $0.address == 0x20_02_50_01 }
    #expect(wahWrite?.data == [25])

    let bendWrite = writes.first { $0.address == 0x20_02_50_06 }
    #expect(bendWrite?.data == [60])

    let wah95Write = writes.first { $0.address == 0x20_02_50_0D }
    #expect(wah95Write?.data == [80])

    // Short buffer should not crash
    let empty = PedalFxBanks.buildFromByteArray([])
    #expect(empty == PedalFxBanks())
  }
}
