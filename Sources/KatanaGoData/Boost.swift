import KatanaBank
import KatanaMacros

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
public struct BoostBank: WritableBank, Sendable, Hashable {
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

  package var writeData = [WriteData]()

  init(
    status: Bool, type: BoostType, drive: UInt8, bottom: UInt8, tone: UInt8,
    soloSwitchStatus: Bool, soloLevel: UInt8, effectLevel: UInt8, directMix: UInt8
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

  public init(
    status: Bool? = nil, type: BoostType? = nil, drive: UInt8? = nil, bottom: UInt8? = nil,
    tone: UInt8? = nil, soloSwitchStatus: Bool? = nil, soloLevel: UInt8? = nil,
    effectLevel: UInt8? = nil, directMix: UInt8? = nil
  ) {
    if let status {
      self.status = status
      self.writeData.append(WriteData(address: self.$status.address, data: status.bytes))
    }
    if let type {
      self.type = type
      self.writeData.append(WriteData(address: self.$type.address, data: type.rawValue.bytes))
    }
    if let drive {
      self.drive = drive
      self.writeData.append(WriteData(address: self.$drive.address, data: drive.bytes))
    }
    if let bottom {
      self.bottom = bottom
      self.writeData.append(WriteData(address: self.$bottom.address, data: bottom.bytes))
    }
    if let tone {
      self.tone = tone
      self.writeData.append(WriteData(address: self.$tone.address, data: tone.bytes))
    }
    if let soloSwitchStatus {
      self.soloSwitchStatus = soloSwitchStatus
      self.writeData.append(
        WriteData(address: self.$soloSwitchStatus.address, data: soloSwitchStatus.bytes))
    }
    if let soloLevel {
      self.soloLevel = soloLevel
      self.writeData.append(WriteData(address: self.$soloLevel.address, data: soloLevel.bytes))
    }
    if let effectLevel {
      self.effectLevel = effectLevel
      self.writeData.append(WriteData(address: self.$effectLevel.address, data: effectLevel.bytes))
    }
    if let directMix {
      self.directMix = directMix
      self.writeData.append(WriteData(address: self.$directMix.address, data: directMix.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$status.address, data: status.bytes),
        WriteData(address: self.$type.address, data: type.rawValue.bytes),
        WriteData(address: self.$drive.address, data: drive.bytes),
        WriteData(address: self.$bottom.address, data: bottom.bytes),
        WriteData(address: self.$tone.address, data: tone.bytes),
        WriteData(address: self.$soloSwitchStatus.address, data: soloSwitchStatus.bytes),
        WriteData(address: self.$soloLevel.address, data: soloLevel.bytes),
        WriteData(address: self.$effectLevel.address, data: effectLevel.bytes),
        WriteData(address: self.$directMix.address, data: directMix.bytes),
      ]
    }
    return self.writeData
  }
}

// MARK - Types

/// Available booster types for the Katana GO.
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
