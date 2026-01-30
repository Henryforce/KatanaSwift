import KatanaCore
import KatanaMacros

// MARK: - Vibrato

/// The data bank representing the vibrato parameters.
@KatanaFxBank
public struct VibratoBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00_00_00_00, range: 0...100)
  public var rate: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_01, range: 0...100)
  public var depth: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_02, range: 0...100)
  public var level: UInt8 = 100

  public static let size: UInt32 = 3
}
