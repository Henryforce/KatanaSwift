import KatanaCore
import KatanaEQ
import KatanaMacros

/// The data bank representing the MOD/FX parametric equalizer parameters.
@KatanaFxBank
public struct ModFxParametricEQBank: Sendable, Hashable {
  @FxParameter(id: .modFxParametricEQLowCut)
  public var lowCut: EQLowCut = .flat

  @FxIntegerParameter(id: .modFxParametricEQLowGain, range: 0...40)
  public var lowGain: UInt8 = 20

  @FxParameter(id: .modFxParametricEQLowMidFreq)
  public var lowMidFreq: EQFrequency = .freq200Hz

  @FxParameter(id: .modFxParametricEQLowMidQ)
  public var lowMidQ: EQQ = .q1

  @FxIntegerParameter(id: .modFxParametricEQLowMidGain, range: 0...40)
  public var lowMidGain: UInt8 = 20

  @FxParameter(id: .modFxParametricEQHighMidFreq)
  public var highMidFreq: EQFrequency = .freq2kHz

  @FxParameter(id: .modFxParametricEQHighMidQ)
  public var highMidQ: EQQ = .q1

  @FxIntegerParameter(id: .modFxParametricEQHighMidGain, range: 0...40)
  public var highMidGain: UInt8 = 20

  @FxIntegerParameter(id: .modFxParametricEQHighGain, range: 0...40)
  public var highGain: UInt8 = 20

  @FxParameter(id: .modFxParametricEQHighCut)
  public var highCut: EQHighCut = .flat

  @FxIntegerParameter(id: .modFxParametricEQLevel, range: 0...40)
  public var level: UInt8 = 20
}
