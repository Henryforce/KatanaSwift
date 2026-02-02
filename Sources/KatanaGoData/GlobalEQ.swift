import KatanaCore
import KatanaEQ
import KatanaMacros

@KatanaBank
public struct GlobalEQSwitchBank: KatanaGoBank, Sendable, Hashable {
  @Parameter(at: 0x00)
  public var onOff: Bool = false

  public static let katanaGoAddress: UInt32 = 0x10_00_10_00

  public static let size: UInt32 = 1
}

@KatanaBank
public struct GlobalEQBank: KatanaGoBank, Sendable, Hashable {
  @Parameter(at: 0x00)
  public var lowCut: EQLowCut = .flat

  @IntegerParameter(at: 0x01, range: 0...40)
  public var lowGain: UInt8 = 20

  @Parameter(at: 0x02)
  public var lowMidFreq: EQFrequency = .freq500Hz

  @Parameter(at: 0x03)
  public var lowMidQ: EQQ = .q1

  @IntegerParameter(at: 0x04, range: 0...40)
  public var lowMidGain: UInt8 = 20

  @Parameter(at: 0x05)
  public var highMidFreq: EQFrequency = .freq4kHz

  @Parameter(at: 0x06)
  public var highMidQ: EQQ = .q1

  @IntegerParameter(at: 0x07, range: 0...40)
  public var highMidGain: UInt8 = 20

  @IntegerParameter(at: 0x08, range: 0...40)
  public var highGain: UInt8 = 20

  @Parameter(at: 0x09)
  public var highCut: EQHighCut = .flat

  @IntegerParameter(at: 0x0A, range: 0...40)
  public var level: UInt8 = 20

  public static let katanaGoAddress: UInt32 = 0x10_00_20_00

  public static let size: UInt32 = 11
}
