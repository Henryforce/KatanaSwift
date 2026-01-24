import KatanaCore
import KatanaMacros

/// The data bank representing the univibe parameters.
@KatanaBank
public struct UniVibeBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00_01_00_19, range: 0...100)
  public var rate: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_1A, range: 0...100)
  public var depth: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_1B, range: 0...100)
  public var level: UInt8 = 100
}
