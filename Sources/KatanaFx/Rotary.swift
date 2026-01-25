import KatanaCore
import KatanaMacros

// MARK: - Rotary

/// The data bank representing the rotary parameters.
@KatanaFxBank
public struct RotaryBank: Sendable, Hashable {
  @FxIntegerParameter(id: .rotaryRate, range: 0...100)
  public var rate: UInt8 = 50

  @FxIntegerParameter(id: .rotaryDepth, range: 0...100)
  public var depth: UInt8 = 50

  @FxIntegerParameter(id: .rotaryLevel, range: 0...100)
  public var level: UInt8 = 100
}
