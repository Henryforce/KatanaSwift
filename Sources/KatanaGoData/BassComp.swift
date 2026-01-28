import KatanaCore
import KatanaFx
import KatanaMacros

/// The data bank representing the booster parameters.
@KatanaBank
public struct BassCompLimBank: Sendable, Hashable {
  @Parameter(at: 0x20_00_50_00)
  public var mode: BassCompLimMode = .comp

  @Parameter(at: 0x20_00_50_01)
  public var compType: BassCompType = .bossComp

  @IntegerParameter(at: 0x20_00_50_02, range: 0...100)
  public var sustain: UInt8 = 50

  @IntegerParameter(at: 0x20_00_50_03, range: 0...100)
  public var compAttack: UInt8 = 50

  @IntegerParameter(at: 0x20_00_50_04, range: 0...100)
  public var tone: UInt8 = 50

  @IntegerParameter(at: 0x20_00_50_05, range: 0...100)
  public var compEffect: UInt8 = 50

  @Parameter(at: 0x20_00_50_06)
  public var limiterType: BassLimType = .bossLimiter

  @IntegerParameter(at: 0x20_00_50_07, range: 0...100)
  public var limiterAttack: UInt8 = 50

  @IntegerParameter(at: 0x20_00_50_08, range: 0...100)
  public var threshold: UInt8 = 50

  @Parameter(at: 0x20_00_50_09)
  public var ratio: LimiterRatio = .fiveToOne

  @IntegerParameter(at: 0x20_00_50_0A, range: 0...100)
  public var release: UInt8 = 50

  @IntegerParameter(at: 0x20_00_50_0B, range: 0...100)
  public var limiterEffect: UInt8 = 50

  public static let address: UInt32 = 0x20_00_50_00

  public static let size: UInt32 = 12
}

@KatanaUInt8RawBytes
public enum BassCompLimMode: UInt8, Sendable, Hashable, CaseIterable {
  case comp = 0x00
  case lim = 0x01
}

@KatanaUInt8RawBytes
public enum BassCompType: UInt8, Sendable, Hashable, CaseIterable {
  case bossComp = 0x00
  case hiBand = 0x01
  case light = 0x02
  case dComp = 0x03
  case orange = 0x04
  case fat = 0x05
  case mild = 0x06
}

@KatanaUInt8RawBytes
public enum BassLimType: UInt8, Sendable, Hashable, CaseIterable {
  case bossLimiter = 0x00
  case rack160D = 0x01
  case vtgRackU = 0x02
}
