import KatanaCore
import KatanaEQ
import KatanaFx
import KatanaMacros

@KatanaBank
public struct SoloSwitchLevelBank: Sendable, Hashable {
  @Parameter(at: 0x20_01_50_00)
  public var status: Bool = false

  @IntegerParameter(at: 0x20_01_50_01, range: 0...100)
  public var level: UInt8 = 50
}

/// The data bank representing the solo parameters.
@KatanaBank
public struct SoloBank: Sendable, Hashable {
  @Parameter(at: 0x20_01_60_00)
  public var eqPosition: EQPosition = .ampIn

  @Parameter(at: 0x20_01_60_01)
  public var eqStatus: Bool = false

  @Parameter(at: 0x20_01_60_02)
  public var eqLowCut: EQLowCut = .flat

  @IntegerParameter(at: 0x20_01_60_03, range: 0...24)
  public var eqLowGain: UInt8 = 12

  @Parameter(at: 0x20_01_60_04)
  public var eqMidFreq: EQFrequency = .freq200Hz

  @Parameter(at: 0x20_01_60_05)
  public var eqMidQ: EQQ = .q1

  @IntegerParameter(at: 0x20_01_60_06, range: 0...24)
  public var eqMidGain: UInt8 = 12

  @IntegerParameter(at: 0x20_01_60_07, range: 0...24)
  public var eqHighGain: UInt8 = 12

  @Parameter(at: 0x20_01_60_08)
  public var eqHighCut: EQHighCut = .flat

  @IntegerParameter(at: 0x20_01_60_09, range: 0...24)
  public var eqLevel: UInt8 = 12
}
