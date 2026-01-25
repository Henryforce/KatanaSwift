import KatanaCore
import KatanaMacros

// MARK: - Vibrato

/// The data bank representing the vibrato parameters.
@KatanaFxBank
public struct VibratoBank: Sendable, Hashable {
  @FxIntegerParameter(id: .vibratoRate, range: 0...100)
  public var rate: UInt8 = 50

  @FxIntegerParameter(id: .vibratoDepth, range: 0...100)
  public var depth: UInt8 = 50

  @FxIntegerParameter(id: .vibratoLevel, range: 0...100)
  public var level: UInt8 = 100
}
