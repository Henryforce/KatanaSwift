import KatanaCore
import KatanaMacros

@KatanaBank
public struct EffectStatusBank: KatanaGoBank, Sendable, Hashable {
  @Parameter(at: 0x00)
  public var booster: Bool = false

  @Parameter(at: 0x01)
  public var mod: Bool = false

  @Parameter(at: 0x02)
  public var fx: Bool = false

  @Parameter(at: 0x03)
  public var delay1: Bool = false

  @Parameter(at: 0x04)
  public var delay2: Bool = false

  @Parameter(at: 0x05)
  public var reverb: Bool = false

  @Parameter(at: 0x06)
  public var bassComp: Bool = false

  public static let katanaGoAddress: UInt32 = 0x20_00_30_00

  public static let size: UInt32 = 7
}
