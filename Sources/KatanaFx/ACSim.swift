import KatanaCore
import KatanaMacros

// MARK: - ACSim

public enum ACSimParameter: Sendable, Hashable {
  /// Range is from -50 to 50 mapped to 0..100.
  case high(UInt8)
  case body(UInt8)
  /// Range is from -50 to 50 mapped to 0..100.
  case low(UInt8)
  case level(UInt8)
}

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
