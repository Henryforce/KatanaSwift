import KatanaCore
import KatanaMacros

// MARK: - SlowGear

/// The data bank representing the slow gear parameters.
@KatanaFxBank
public struct SlowGearBank: Sendable, Hashable {
  @FxIntegerParameter(id: .slowGearSens, range: 0...100)
  public var sens: UInt8 = 50

  @FxIntegerParameter(id: .slowGearRiseTime, range: 0...100)
  public var riseTime: UInt8 = 50

  @FxIntegerParameter(id: .slowGearLevel, range: 0...100)
  public var level: UInt8 = 100
}
