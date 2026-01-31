import KatanaCore
import KatanaFx
import Testing

@testable import KatanaGoData

struct PitchShifterTests {

  @Test func testPitchShifterBankDefaults() {
    let bank = PitchShifterBank()

    #expect(bank.voice == .oneVoice)
    #expect(bank.ps1Mode == .fast)
    #expect(bank.ps1Pitch == 50)
  }

  @Test func testLoadWriteDataWithAddressRipple() {
    var bank = PitchShifterBank()

    // Base address from PitchShifterVoice: 0x20_01_00_7F
    // This is a great test case because adding 1 (offset of ps1Mode)
    // should ripple into the next byte.
    let baseAddress: UInt32 = 0x20_01_00_7F

    // Initially empty
    #expect(bank.loadWriteData(baseAddress: baseAddress).isEmpty)

    // Update voice (offset 0)
    bank.voice = .twoVoice
    // Update ps1Mode (offset 1)
    bank.ps1Mode = .slow

    let writeData = bank.loadWriteData(baseAddress: baseAddress)

    #expect(writeData.count == 2)

    // Voice address: 0x20_01_00_7F + 0 = 0x20_01_00_7F
    let voiceData = writeData.first { $0.address == 0x20_01_00_7F }
    #expect(voiceData?.data == [0x01])

    // ps1Mode address: 0x7F + 1 = 0x80
    // Standard addition: 0x20_01_00_7F + 1 = 0x20_01_00_80
    // Macro ripple logic:
    // 1. address = 0x20_01_00_80
    // 2. if (address & 0x80) != 0 -> Yes (0x80 is set)
    // 3. address += 0x80 -> 0x20_01_00_80 + 0x80 = 0x20_01_01_00
    // 4. if (address & 0x8000) != 0 -> No (bit 15 is 0)
    // 5. if (address & 0x800000) != 0 -> No
    // Result: 0x20_01_01_00
    let ps1ModeData = writeData.first { $0.address == 0x20_01_01_00 }
    #expect(ps1ModeData?.data == [0x02])  // .slow is 0x02
  }

  @Test func testLoadWriteDataFurtherRipple() {
    var bank = PitchShifterBank()
    // Test ripple at offset 0x11 (ps1Feedback)
    // base 0x20_01_00_7F + offset 0x11
    // Standard sum: 0x20_01_00_90
    // Ripple calculation:
    // 1. 0x20_01_00_90 & 0x80 is 0x80 (non-zero)
    // 2. address += 0x80 -> 0x20_01_00_90 + 0x80 = 0x20_01_01_10
    // 3. 0x110 & 0x8000 is 0 -> No more ripple
    // Result: 0x20_01_01_10
    let baseAddress: UInt32 = 0x20_01_00_7F

    bank.ps1Feedback = 45
    let writeData = bank.loadWriteData(baseAddress: baseAddress)

    #expect(writeData.first?.address == 0x20_01_01_10)
    #expect(writeData.first?.data == [45])
  }
}
