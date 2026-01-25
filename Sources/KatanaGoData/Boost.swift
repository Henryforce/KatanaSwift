import KatanaCore
import KatanaMacros

/// The data bank representing the booster parameters.
@KatanaBank
public struct BoostBank: Sendable, Hashable {
  @Parameter(at: 0x00_00_30_00)
  public var status: Bool = false

  @Parameter(at: 0x00_00_40_00)
  public var type: BoostType = .midBoost

  @IntegerParameter(at: 0x00_00_40_01, range: 0...100)
  public var drive: UInt8 = 50

  @IntegerParameter(at: 0x00_00_40_02, range: 0...100)
  public var bottom: UInt8 = 50

  @IntegerParameter(at: 0x00_00_40_03, range: 0...100)
  public var tone: UInt8 = 50

  @Parameter(at: 0x00_00_40_04)
  public var soloSwitchStatus: Bool = false

  @IntegerParameter(at: 0x00_00_40_05, range: 0...100)
  public var soloLevel: UInt8 = 50

  @IntegerParameter(at: 0x00_00_40_06, range: 0...100)
  public var effectLevel: UInt8 = 50

  @IntegerParameter(at: 0x00_00_40_07, range: 0...100)
  public var directMix: UInt8 = 0
}

// MARK - Types

/// Available booster types for the Katana GO.
@KatanaUInt8RawBytes
public enum BoostType: UInt8, Sendable, Hashable, CaseIterable {
  case cleanBoost = 0x00
  case trebleBoost = 0x01
  case midBoost = 0x02
  case crunch = 0x03
  case bluesOD = 0x04
  case overdrive = 0x05
  case naturalOD = 0x06
  case warmOD = 0x07
  case turboOD = 0x08
  case tubescreamer = 0x09
  case dist = 0x0A
  case fatDS = 0x0B
  case dstPlus = 0x0C
  case guVDS = 0x0D
  case rat = 0x0E
  case metalZone = 0x0F
  case metalDS = 0x10
  case sixtiesFuzz = 0x11
  case muffFuzz = 0x12
  case octFuzz = 0x13
  case hm2 = 0x14
  case metalCore = 0x15
  case centaOD = 0x16
}

/// Available booster types for the Katana GO in Bass Mode.
public enum BassBoostType: UInt8, Sendable, Hashable, CaseIterable {
  case bluesOD = 0x00
  case natural = 0x01
  case guVDS = 0x02
  case metalZone = 0x03
  case muffFuzz = 0x04
  case booster = 0x05
  case bassOD = 0x06
  case bassDS = 0x08
  case bassMT = 0x09
  case bassFuzz = 0x0A
  case bassDrv = 0x0B
  case hiBandDrv = 0x0C
  case bassDI = 0x0D
}
