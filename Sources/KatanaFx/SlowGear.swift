import KatanaCore
import KatanaMacros

// MARK: - SlowGear

/// The data bank representing the slow gear parameters.
@KatanaBank
public struct SlowGearBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00_00_00_00, range: 0...100)
  public var sens: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_01, range: 0...100)
  public var riseTime: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_02, range: 0...100)
  public var level: UInt8 = 100

  public static let size: UInt32 = 3
}
