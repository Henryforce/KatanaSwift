import KatanaCore
import KatanaMacros

@KatanaBank
public struct TunerBank: KatanaGoBank, Sendable, Hashable {
  @Parameter(at: 0x00)
  public var onOff: Bool = false

  public static let katanaGoAddress: UInt32 = 0x10_00_00_00

  public static let size: UInt32 = 1
}
