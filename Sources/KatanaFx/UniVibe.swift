import KatanaCore
import KatanaMacros

/// The data bank representing the univibe parameters.
@KatanaFxBank
public struct UniVibeBank: Sendable, Hashable {
  @FxIntegerParameter(id: .univibeRate, range: 0...100)
  public var rate: UInt8 = 50

  @FxIntegerParameter(id: .univibeDepth, range: 0...100)
  public var depth: UInt8 = 50

  @FxIntegerParameter(id: .univibeLevel, range: 0...100)
  public var level: UInt8 = 100
}
