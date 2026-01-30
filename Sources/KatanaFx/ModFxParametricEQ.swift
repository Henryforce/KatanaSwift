import KatanaCore
import KatanaEQ
import KatanaMacros

/// The data bank representing the MOD/FX parametric equalizer parameters.
@KatanaFxBank
public struct ModFxParametricEQBank: Sendable, Hashable {
  @Parameter(at: 0x00_00_00_00)
  public var lowCut: EQLowCut = .flat

  @IntegerParameter(at: 0x00_00_00_01, range: 0...40)
  public var lowGain: UInt8 = 20

  @Parameter(at: 0x00_00_00_02)
  public var lowMidFreq: EQFrequency = .freq200Hz

  @Parameter(at: 0x00_00_00_03)
  public var lowMidQ: EQQ = .q1

  @IntegerParameter(at: 0x00_00_00_04, range: 0...40)
  public var lowMidGain: UInt8 = 20

  @Parameter(at: 0x00_00_00_05)
  public var highMidFreq: EQFrequency = .freq2kHz

  @Parameter(at: 0x00_00_00_06)
  public var highMidQ: EQQ = .q1

  @IntegerParameter(at: 0x00_00_00_07, range: 0...40)
  public var highMidGain: UInt8 = 20

  @IntegerParameter(at: 0x00_00_00_08, range: 0...40)
  public var highGain: UInt8 = 20

  @Parameter(at: 0x00_00_00_09)
  public var highCut: EQHighCut = .flat

  @IntegerParameter(at: 0x00_00_00_0A, range: 0...40)
  public var level: UInt8 = 20

  public static let size: UInt32 = 11
}
