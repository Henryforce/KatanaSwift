import KatanaBank
import KatanaMacros

/// Represents the Solo parameters.
public enum SoloParameter: Sendable, Hashable {
  case enable(Bool)
  /// The solo level ranging from 0 to 100.
  case level(UInt8)
  case eqPosition(EQPosition)
  case eqOffOn(Bool)
  case eqLowCut(EQLowCut)
  /// Range is from -12dB to 12dB mapped to 0..12..24.
  case eqLowGain(UInt8)
  case eqMidFreq(EQFrequency)
  case eqMidQ(EQQ)
  /// Range is from -12dB to 12dB mapped to 0..12..24.
  case eqMidGain(UInt8)
  /// Range is from -12dB to 12dB mapped to 0..12..24.
  case eqHighGain(UInt8)
  case eqHighCut(EQHighCut)
  /// Range is from -12dB to 12dB mapped to 0..12..24.
  case eqLevel(UInt8)
}

/// The data bank representing the solo parameters.
public struct SoloBank: WritableBank, Sendable, Hashable {
  @Parameter(at: 0x00_01_50_00)
  public var status: Bool = false

  @IntegerParameter(at: 0x00_01_50_01, range: 0...100)
  public var level: UInt8 = 50

  @Parameter(at: 0x00_01_60_00)
  public var eqPosition: EQPosition = .ampIn

  @Parameter(at: 0x00_01_60_01)
  public var eqStatus: Bool = false

  @Parameter(at: 0x00_01_60_02)
  public var eqLowCut: EQLowCut = .flat

  @IntegerParameter(at: 0x00_01_60_03, range: 0...24)
  public var eqLowGain: UInt8 = 12

  @Parameter(at: 0x00_01_60_04)
  public var eqMidFreq: EQFrequency = .freq200Hz

  @Parameter(at: 0x00_01_60_05)
  public var eqMidQ: EQQ = .q1

  @IntegerParameter(at: 0x00_01_60_06, range: 0...24)
  public var eqMidGain: UInt8 = 12

  @IntegerParameter(at: 0x00_01_60_07, range: 0...24)
  public var eqHighGain: UInt8 = 12

  @Parameter(at: 0x00_01_60_08)
  public var eqHighCut: EQHighCut = .flat

  @IntegerParameter(at: 0x00_01_60_09, range: 0...24)
  public var eqLevel: UInt8 = 12

  package var writeData = [WriteData]()

  init(
    status: Bool, level: UInt8, eqPosition: EQPosition, eqStatus: Bool, eqLowCut: EQLowCut,
    eqLowGain: UInt8, eqMidFreq: EQFrequency, eqMidQ: EQQ, eqMidGain: UInt8, eqHighGain: UInt8,
    eqHighCut: EQHighCut, eqLevel: UInt8
  ) {
    self.status = status
    self.level = level
    self.eqPosition = eqPosition
    self.eqStatus = eqStatus
    self.eqLowCut = eqLowCut
    self.eqLowGain = eqLowGain
    self.eqMidFreq = eqMidFreq
    self.eqMidQ = eqMidQ
    self.eqMidGain = eqMidGain
    self.eqHighGain = eqHighGain
    self.eqHighCut = eqHighCut
    self.eqLevel = eqLevel
  }

  public init(
    status: Bool? = nil, level: UInt8? = nil, eqPosition: EQPosition? = nil,
    eqStatus: Bool? = nil, eqLowCut: EQLowCut? = nil, eqLowGain: UInt8? = nil,
    eqMidFreq: EQFrequency? = nil, eqMidQ: EQQ? = nil, eqMidGain: UInt8? = nil,
    eqHighGain: UInt8? = nil, eqHighCut: EQHighCut? = nil, eqLevel: UInt8? = nil
  ) {
    if let status {
      self.status = status
      self.writeData.append(WriteData(address: self.$status.address, data: status.bytes))
    }
    if let level {
      self.level = level
      self.writeData.append(WriteData(address: self.$level.address, data: level.bytes))
    }
    if let eqPosition {
      self.eqPosition = eqPosition
      self.writeData.append(
        WriteData(address: self.$eqPosition.address, data: eqPosition.rawValue.bytes))
    }
    if let eqStatus {
      self.eqStatus = eqStatus
      self.writeData.append(WriteData(address: self.$eqStatus.address, data: eqStatus.bytes))
    }
    if let eqLowCut {
      self.eqLowCut = eqLowCut
      self.writeData.append(
        WriteData(address: self.$eqLowCut.address, data: eqLowCut.rawValue.bytes))
    }
    if let eqLowGain {
      self.eqLowGain = eqLowGain
      self.writeData.append(WriteData(address: self.$eqLowGain.address, data: eqLowGain.bytes))
    }
    if let eqMidFreq {
      self.eqMidFreq = eqMidFreq
      self.writeData.append(
        WriteData(address: self.$eqMidFreq.address, data: eqMidFreq.rawValue.bytes))
    }
    if let eqMidQ {
      self.eqMidQ = eqMidQ
      self.writeData.append(WriteData(address: self.$eqMidQ.address, data: eqMidQ.rawValue.bytes))
    }
    if let eqMidGain {
      self.eqMidGain = eqMidGain
      self.writeData.append(WriteData(address: self.$eqMidGain.address, data: eqMidGain.bytes))
    }
    if let eqHighGain {
      self.eqHighGain = eqHighGain
      self.writeData.append(WriteData(address: self.$eqHighGain.address, data: eqHighGain.bytes))
    }
    if let eqHighCut {
      self.eqHighCut = eqHighCut
      self.writeData.append(
        WriteData(address: self.$eqHighCut.address, data: eqHighCut.rawValue.bytes))
    }
    if let eqLevel {
      self.eqLevel = eqLevel
      self.writeData.append(WriteData(address: self.$eqLevel.address, data: eqLevel.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$status.address, data: status.bytes),
        WriteData(address: self.$level.address, data: level.bytes),
        WriteData(address: self.$eqPosition.address, data: eqPosition.rawValue.bytes),
        WriteData(address: self.$eqStatus.address, data: eqStatus.bytes),
        WriteData(address: self.$eqLowCut.address, data: eqLowCut.rawValue.bytes),
        WriteData(address: self.$eqLowGain.address, data: eqLowGain.bytes),
        WriteData(address: self.$eqMidFreq.address, data: eqMidFreq.rawValue.bytes),
        WriteData(address: self.$eqMidQ.address, data: eqMidQ.rawValue.bytes),
        WriteData(address: self.$eqMidGain.address, data: eqMidGain.bytes),
        WriteData(address: self.$eqHighGain.address, data: eqHighGain.bytes),
        WriteData(address: self.$eqHighCut.address, data: eqHighCut.rawValue.bytes),
        WriteData(address: self.$eqLevel.address, data: eqLevel.bytes),
      ]
    }
    return self.writeData
  }
}
