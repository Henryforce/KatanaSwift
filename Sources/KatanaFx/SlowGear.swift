import KatanaCore
import KatanaMacros

// MARK: - SlowGear

public enum SlowGearParameter: Sendable, Hashable {
  case sens(UInt8)
  case riseTime(UInt8)
  case level(UInt8)
}

/// The data bank representing the slow gear parameters.
@KatanaBank
public struct SlowGearBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00_01_00_2A, range: 0...100)
  public var sens: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_2B, range: 0...100)
  public var riseTime: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_2C, range: 0...100)
  public var level: UInt8 = 100
}
