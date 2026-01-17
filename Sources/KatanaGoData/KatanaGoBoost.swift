/// Parameters for the Booster effect.
public enum BoostParameter: Sendable {
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

/// Available booster types for the Katana GO.
public enum BoostType: UInt8, Sendable, CaseIterable {
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
public enum BassBoostType: UInt8, Sendable, CaseIterable {
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
