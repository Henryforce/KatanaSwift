import KatanaCore
import Testing

@testable import KatanaGoData

struct AmpTests {

  @Test func testAmpBankDefaults() {
    let bank = AmpBank()

    #expect(bank.type == .clean)
    #expect(bank.gain == 50)
    #expect(bank.volume == 50)
    #expect(bank.bass == 50)
    #expect(bank.middle == 50)
    #expect(bank.treble == 50)
    #expect(bank.presence == 50)
    #expect(bank.variation == false)
  }

  @Test func testAmpBankPropertyUpdates() {
    var bank = AmpBank()

    bank.gain = 75
    #expect(bank.gain == 75)

    // Test clamping
    bank.volume = 150
    #expect(bank.volume == 100)

    bank.bass = 0
    #expect(bank.bass == 0)

    bank.middle = 255  // Should clamp to 100
    #expect(bank.middle == 100)

    bank.type = .lead
    #expect(bank.type == .lead)

    bank.variation = true
    #expect(bank.variation == true)
  }

  @Test func testAmpBankAddresses() {
    let bank = AmpBank()

    #expect(bank.$gain.address == 0x00)
    #expect(bank.$volume.address == 0x01)
    #expect(bank.$bass.address == 0x03)
    #expect(bank.$middle.address == 0x04)
    #expect(bank.$treble.address == 0x05)
    #expect(bank.$presence.address == 0x0A)
    #expect(bank.$type.address == 0x0C)
    #expect(bank.$variation.address == 0x0D)
  }

  @Test func testLoadWriteData() {
    var bank = AmpBank()
    let baseAddress = AmpBank.katanaGoAddress

    // Initially empty because nothing was updated
    #expect(bank.loadWriteData(baseAddress: baseAddress).isEmpty)

    // Update some parameters
    bank.gain = 70
    bank.type = .brown
    bank.variation = true

    let writeData = bank.loadWriteData(baseAddress: baseAddress)

    #expect(writeData.count == 3)

    let gainData = writeData.first { $0.address == 0x20_00_20_00 }
    #expect(gainData?.data == [70])

    let typeData = writeData.first { $0.address == 0x20_00_20_0C }
    #expect(typeData?.data == [0x04])  // .brown is 0x04

    let variationData = writeData.first { $0.address == 0x20_00_20_0D }
    #expect(variationData?.data == [1])  // true is 1
  }
}
