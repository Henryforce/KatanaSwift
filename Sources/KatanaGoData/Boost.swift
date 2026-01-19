/// Parameters for the Booster effect.
public enum BoostParameter: Sendable, Hashable {
  case enable(Bool)
  case type(BoostType)
  case drive(UInt8)
  case bottom(UInt8)
  case tone(UInt8)
  case soloSwitchEnable(Bool)
  case soloLevel(UInt8)
  case effectLevel(UInt8)
  case directMix(UInt8)
}

/// The data bank representing the booster parameters.
public struct BoostBank: Sendable, Hashable {
  public let status: Bool
  public let type: BoostType
  public let drive: UInt8
  public let bottom: UInt8
  public let tone: UInt8
  public let soloSwitchStatus: Bool
  public let soloLevel: UInt8
  public let effectLevel: UInt8
  public let directMix: UInt8

  public init(
    status: Bool, type: BoostType, drive: UInt8, bottom: UInt8, tone: UInt8, soloSwitchStatus: Bool,
    soloLevel: UInt8, effectLevel: UInt8, directMix: UInt8
  ) {
    self.status = status
    self.type = type
    self.drive = drive
    self.bottom = bottom
    self.tone = tone
    self.soloSwitchStatus = soloSwitchStatus
    self.soloLevel = soloLevel
    self.effectLevel = effectLevel
    self.directMix = directMix
  }
}

// MARK - Types

/// Available booster types for the Katana GO.
public enum BoostType: UInt8, Sendable, Hashable, CaseIterable {
  case midBoost = 0x00
  case cleanBoost = 0x01
  case trebleBoost = 0x02
  case crunch = 0x03
  case naturalOD = 0x04
  case warmOD = 0x05
  case fatDS = 0x06
  case leadDS = 0x07
  case metalDS = 0x08
  case octFuzz = 0x09
  case bluesOD = 0x0A
  case od1 = 0x0B
  case tubescreamer = 0x0C
  case turboOD = 0x0D
  case dist = 0x0E
  case rat = 0x0F
  case guVDS = 0x10
  case dstPlus = 0x11
  case metalZone = 0x12
  case sixtiesFuzz = 0x13
  case muffFuzz = 0x14
  case custom = 0x15
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
