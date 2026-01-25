import KatanaCore
import KatanaMacros

// MARK: - ACSim

/// The data bank representing the acoustic simulation parameters.
@KatanaBank
public struct ACSimBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00_01_00_66, range: 0...100)
  public var high: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_67, range: 0...100)
  public var body: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_68, range: 0...100)
  public var low: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_69, range: 0...100)
  public var level: UInt8 = 100
}
