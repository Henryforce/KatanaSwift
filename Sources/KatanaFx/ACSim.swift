import KatanaCore
import KatanaMacros

// MARK: - ACSim

/// The data bank representing the acoustic simulation parameters.
@KatanaFxBank
public struct ACSimBank: Sendable, Hashable {
  @FxIntegerParameter(id: .acSimHigh, range: 0...100)
  public var high: UInt8 = 50

  @FxIntegerParameter(id: .acSimBody, range: 0...100)
  public var body: UInt8 = 50

  @FxIntegerParameter(id: .acSimLow, range: 0...100)
  public var low: UInt8 = 50

  @FxIntegerParameter(id: .acSimLevel, range: 0...100)
  public var level: UInt8 = 100
}
