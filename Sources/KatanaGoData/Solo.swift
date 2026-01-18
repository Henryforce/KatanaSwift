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
