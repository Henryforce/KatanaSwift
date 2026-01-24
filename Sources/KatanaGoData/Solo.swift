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
public struct SoloBank: Sendable, Hashable {
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

  public init(
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
}
