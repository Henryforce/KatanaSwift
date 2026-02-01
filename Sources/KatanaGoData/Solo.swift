import KatanaCore
import KatanaEQ
import KatanaFx
import KatanaMacros

@KatanaBank
public struct SoloSwitchLevelBank: KatanaGoBank, Sendable, Hashable {
  @Parameter(at: 0x00)
  public var status: Bool = false

  @IntegerParameter(at: 0x01, range: 0...100)
  public var level: UInt8 = 50

  public static let katanaGoAddress: UInt32 = 0x20_01_50_00

  public static let size: UInt32 = 2
}

/// The data bank representing the solo parameters.
@KatanaBank
public struct SoloBank: KatanaGoBank, Sendable, Hashable {
  @Parameter(at: 0x00)
  public var eqPosition: EQPosition = .ampIn

  @Parameter(at: 0x01)
  public var eqStatus: Bool = false

  @Parameter(at: 0x02)
  public var eqLowCut: EQLowCut = .flat

  @IntegerParameter(at: 0x03, range: 0...24)
  public var eqLowGain: UInt8 = 12

  @Parameter(at: 0x04)
  public var eqMidFreq: EQFrequency = .freq200Hz

  @Parameter(at: 0x05)
  public var eqMidQ: EQQ = .q1

  @IntegerParameter(at: 0x06, range: 0...24)
  public var eqMidGain: UInt8 = 12

  @IntegerParameter(at: 0x07, range: 0...24)
  public var eqHighGain: UInt8 = 12

  @Parameter(at: 0x08)
  public var eqHighCut: EQHighCut = .flat

  @IntegerParameter(at: 0x09, range: 0...24)
  public var eqLevel: UInt8 = 12

  public static let katanaGoAddress: UInt32 = 0x20_01_60_00

  public static let size: UInt32 = 10
}
