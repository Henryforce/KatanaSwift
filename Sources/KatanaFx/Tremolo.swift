import KatanaCore
import KatanaMacros

// MARK: - Tremolo

public enum TremoloParameter: Sendable, Hashable {
  case waveShape(UInt8)
  case rate(UInt8)
  case depth(UInt8)
  case level(UInt8)
}

/// The data bank representing the tremolo parameters.
@KatanaBank
public struct TremoloBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00_01_00_1C, range: 0...100)
  public var waveShape: UInt8 = 0

  @IntegerParameter(at: 0x00_01_00_1D, range: 0...100)
  public var rate: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_1E, range: 0...100)
  public var depth: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_1F, range: 0...100)
  public var level: UInt8 = 100
}
