import KatanaCore
import KatanaGoData
import Testing

@testable import KatanaDeviceImpl

struct KatanaGoMIDIParserTests {

  @Test func testParsePresetName() throws {
    // Data from Preset2A.txt line 10
    // [16, 1, 5, 13, 18, 32, 0, 0, 0, 0, 0, 0, 0, 77, 79, 68, 69, 82, 78, 32, 66, 82, 79, 87, 78, 32, 32, 32, 32, 115]
    let message: [UInt8] = [
      16, 1, 5, 13, 18, 32, 0, 0, 0,  // Header + Address
      0, 0, 0, 0, 0, 0, 0,  // 7 zeroes
      77, 79, 68, 69, 82, 78, 32, 66, 82, 79, 87, 78, 32, 32, 32, 32,  // MODERN BROWN
      115,  // Checksum
    ]

    var dataBank = KatanaGoRawDataBank()
    let commands = KatanaGoMIDIParser.parse(message, into: &dataBank)
    #expect(commands.count == 1)
    if let firstCommand = commands.first, case .presetName(let name) = firstCommand {
      #expect(name == "MODERN BROWN")
    } else {
      Issue.record("Unexpected command, presetName was expected")
    }
  }

  @Test func testParsePreamp() throws {
    // Data from Preset2A.txt line 12
    // [16, 1, 5, 13, 18, 32, 0, 32, 0, 100, 100, 0, 70, 61, 49, 50, 11, 50, 16, 60, 0, 4, 0, 5]
    let message: [UInt8] = [
      16, 1, 5, 13, 18,  // Header
      32, 0, 32, 0,  // Address: 20 00 20 00
      100, 100, 0, 70, 61, 49, 50, 11, 50, 16, 60, 0, 4, 0,  // 14 bytes data
      5,  // Checksum
    ]

    var dataBank = KatanaGoRawDataBank()
    let commands = KatanaGoMIDIParser.parse(message, into: &dataBank)

    let expectedPreamp: [UInt8] = [100, 100, 0, 70, 61, 49, 50, 11, 50, 16, 60, 0, 4, 0]
    #expect(dataBank.ampBank == expectedPreamp)
    #expect(commands.count == 1)
    if let firstCommand = commands.first, case .ampBank(let ampBank) = firstCommand {
      #expect(ampBank.bass == 70)
      #expect(ampBank.gain == 100)
      #expect(ampBank.middle == 61)
      #expect(ampBank.treble == 49)
      #expect(ampBank.variation == false)
      #expect(ampBank.volume == 100)
      #expect(ampBank.type == .brown)
    } else {
      Issue.record("Unexpected command, ampBank was expected")
    }
  }

  @Test func testParseBooster() throws {
    // Data from Preset2A.txt line 14
    // [16, 1, 5, 13, 18, 32, 0, 64, 0, 9, 50, 60, 50, 0, 50, 40, 0, 29]
    let message: [UInt8] = [
      16, 1, 5, 13, 18,
      32, 0, 64, 0,  // Address: 20 00 40 00
      9, 50, 60, 50, 0, 50, 40, 0,
      29,  // Checksum
    ]

    var dataBank = KatanaGoRawDataBank()
    let commands = KatanaGoMIDIParser.parse(message, into: &dataBank)

    let expectedBooster: [UInt8] = [9, 50, 60, 50, 0, 50, 40, 0]
    #expect(dataBank.boosterBank == expectedBooster)
    #expect(commands.count == 1)
    if let firstCommand = commands.first, case .boostBank(let boostBank) = firstCommand {
      #expect(boostBank.bottom == 60)
      #expect(boostBank.directMix == 0)
      #expect(boostBank.drive == 50)
      #expect(boostBank.effectLevel == 40)
      #expect(boostBank.soloLevel == 50)
      #expect(boostBank.soloSwitchStatus == false)
      #expect(boostBank.tone == 50)
      #expect(boostBank.type == .tubescreamer)
    } else {
      Issue.record("Unexpected command, boostBank was expected")
    }
  }

  @Test func testDelayChannelAddressable() throws {
    var delayBank = DelayBank()
    delayBank.type = .analog
    delayBank.time = 500
    delayBank.feedback = 40
    delayBank.highCut = .freq4kHz
    delayBank.effectLevel = 60
    delayBank.directMix = 10
    delayBank.tapTimePercentage = 80
    delayBank.modulationRate = 30
    delayBank.modulationDepth = 20
    delayBank.filterStatus = true
    delayBank.filter = .freq17kHz
    delayBank.feedbackPhase = .inverted
    delayBank.delayPhase = .inverted
    delayBank.modulationSwitchStatus = true

    // Test Delay 1
    // address: 20 01 20 00
    let channel1Address: UInt32 = DelayBank.katanaGoAddress + DelayBankChannel.one.rawValue
    let writeData1 = delayBank.loadWriteData(baseAddress: channel1Address)

    var dataBank = KatanaGoRawDataBank()
    for write in writeData1 {
      let message = finalizeSysex(address: write.address, data: write.data)
      _ = KatanaGoMIDIParser.parse(message, into: &dataBank)
    }

    // Verify Delay 1 was updated
    let parsedDelay1 = DelayBank.buildFromByteArray(dataBank.delay1Bank)
    #expect(parsedDelay1 == delayBank)
    #expect(parsedDelay1.type == .analog)
    #expect(parsedDelay1.time == 500)

    // Test Delay 2
    // address: 20 01 30 00
    let channel2Address: UInt32 = DelayBank.katanaGoAddress + DelayBankChannel.two.rawValue
    let writeData2 = delayBank.loadWriteData(baseAddress: channel2Address)

    for write in writeData2 {
      let message = finalizeSysex(address: write.address, data: write.data)
      _ = KatanaGoMIDIParser.parse(message, into: &dataBank)
    }

    // Verify Delay 2 was updated
    let parsedDelay2 = DelayBank.buildFromByteArray(dataBank.delay2Bank)
    #expect(parsedDelay2 == delayBank)
    #expect(parsedDelay2.type == .analog)
    #expect(parsedDelay2.time == 500)
  }

  private func finalizeSysex(address: UInt32, data: [UInt8]) -> [UInt8] {
    let addressBytes = [
      UInt8((address >> 24) & 0xFF),
      UInt8((address >> 16) & 0xFF),
      UInt8((address >> 8) & 0xFF),
      UInt8(address & 0xFF),
    ]
    let prefix: [UInt8] = [16, 1, 5, 13, 18]  // Roland Header (5 bytes) + DT1 command
    let body = addressBytes + data
    var sum: Int = 0
    for byte in body {
      sum += Int(byte)
    }
    let checksum = UInt8((128 - (sum % 128)) % 128)
    return prefix + body + [checksum]
  }
}
