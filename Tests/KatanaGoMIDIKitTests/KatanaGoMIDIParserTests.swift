import Foundation
import Testing

@testable import KatanaGoMIDIKit

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

    var dataBank = DataBank()
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

    var dataBank = DataBank()
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

    var dataBank = DataBank()
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
}
