import KatanaCore
import KatanaMacros

// MARK: - ACSim

/// The data bank representing the acoustic simulation parameters.
@KatanaBank
public struct ACSimBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00_00_00_00, range: 0...100)
  public var high: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_01, range: 0...100)
  public var body: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_02, range: 0...100)
  public var low: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_03, range: 0...100)
  public var level: UInt8 = 100

  public static let size: UInt32 = 4
}
