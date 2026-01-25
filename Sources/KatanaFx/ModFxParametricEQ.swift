import KatanaCore
import KatanaMacros

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
