import KatanaCore
import KatanaMacros

// MARK: - Vibrato

public enum VibratoParameter: Sendable, Hashable {
  case rate(UInt8)
  case depth(UInt8)
  case level(UInt8)
}

/// The data bank representing the vibrato parameters.
@KatanaBank
public struct VibratoBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00_01_00_20, range: 0...100)
  public var rate: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_21, range: 0...100)
  public var depth: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_22, range: 0...100)
  public var level: UInt8 = 100
}
