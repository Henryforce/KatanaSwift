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
  public let status: Bool
  public let level: UInt8
  public let eqPosition: EQPosition
  public let eqStatus: Bool
  public let eqLowCut: EQLowCut
  public let eqLowGain: UInt8
  public let eqMidFreq: EQFrequency
  public let eqMidQ: EQQ
  public let eqMidGain: UInt8
  public let eqHighGain: UInt8
  public let eqHighCut: EQHighCut
  public let eqLevel: UInt8

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
