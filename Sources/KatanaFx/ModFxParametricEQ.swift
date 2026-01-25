import KatanaCore
import KatanaMacros

// MARK: - ModFxParametricEQ

public enum ModFxParametricEQParameter: Sendable, Hashable {
  case lowCut(EQLowCut)
  /// Range is from -20 to 20 mapped to 0..40.
  case lowGain(UInt8)
  case lowMidFreq(EQFrequency)
  case lowMidQ(EQQ)
  /// Range is from -20 to 20 mapped to 0..40.
  case lowMidGain(UInt8)
  case highMidFreq(EQFrequency)
  case highMidQ(EQQ)
  /// Range is from -20 to 20 mapped to 0..40.
  case highMidGain(UInt8)
  /// Range is from -20 to 20 mapped to 0..40.
  case highGain(UInt8)
  case highCut(EQHighCut)
  /// Range is from -20 to 20 mapped to 0..40.
  case level(UInt8)
}

/// The data bank representing the MOD/FX parametric equalizer parameters.
@KatanaBank
public struct ModFxParametricEQBank: Sendable, Hashable {
  @Parameter(at: 0x00_01_00_56)
  public var lowCut: EQLowCut = .flat

  @IntegerParameter(at: 0x00_01_00_57, range: 0...40)
  public var lowGain: UInt8 = 20

  @Parameter(at: 0x00_01_00_58)
  public var lowMidFreq: EQFrequency = .freq200Hz

  @Parameter(at: 0x00_01_00_59)
  public var lowMidQ: EQQ = .q1

  @IntegerParameter(at: 0x00_01_00_5A, range: 0...40)
  public var lowMidGain: UInt8 = 20

  @Parameter(at: 0x00_01_00_5B)
  public var highMidFreq: EQFrequency = .freq2kHz

  @Parameter(at: 0x00_01_00_5C)
  public var highMidQ: EQQ = .q1

  @IntegerParameter(at: 0x00_01_00_5D, range: 0...40)
  public var highMidGain: UInt8 = 20

  @IntegerParameter(at: 0x00_01_00_5E, range: 0...40)
  public var highGain: UInt8 = 20

  @Parameter(at: 0x00_01_00_5F)
  public var highCut: EQHighCut = .flat

  @IntegerParameter(at: 0x00_01_00_60, range: 0...40)
  public var level: UInt8 = 20
}
