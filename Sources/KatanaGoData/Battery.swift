import KatanaCore
import KatanaMacros

@KatanaBank
public struct BatteryBank: KatanaGoBank, Sendable, Hashable {
  @IntegerParameter(at: 0x00, range: 0...100)
  public var level: UInt8 = 0

  public static let katanaGoAddress: UInt32 = 0x7F_00_05_02

  public static let size: UInt32 = 1
}
