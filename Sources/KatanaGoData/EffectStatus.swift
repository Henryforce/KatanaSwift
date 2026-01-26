import KatanaCore
import KatanaMacros

@KatanaBank
public struct EffectStatusBank: Sendable, Hashable {
  @Parameter(at: 0x20_00_30_00)
  public var booster: Bool = false

  @Parameter(at: 0x20_00_30_01)
  public var mod: Bool = false

  @Parameter(at: 0x20_00_30_02)
  public var fx: Bool = false

  @Parameter(at: 0x20_00_30_03)
  public var delay1: Bool = false

  @Parameter(at: 0x20_00_30_04)
  public var delay2: Bool = false

  @Parameter(at: 0x20_00_30_05)
  public var reverb: Bool = false

  @Parameter(at: 0x20_00_30_06)
  public var bassComp: Bool = false
}
