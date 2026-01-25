import KatanaCore
import KatanaMacros

// MARK: - Octaver

public enum OctaverParameter: Sendable, Hashable {
  case range(OctaverRange)
  case level(UInt8)
  case directLevel(UInt8)
}

/// The data bank representing the octaver parameters.
@KatanaBank
public struct OctaverBank: Sendable, Hashable {
  @Parameter(at: 0x00_01_00_79)
  public var range: OctaverRange = .range1

  @IntegerParameter(at: 0x00_01_00_7A, range: 0...100)
  public var level: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_7B, range: 0...100)
  public var directLevel: UInt8 = 0
}

@KatanaUInt8RawBytes
public enum OctaverRange: UInt8, Sendable, Hashable, CaseIterable {
  case range1 = 0x00
  case range2 = 0x01
  case range3 = 0x02
  case range4 = 0x03
}

// MARK: - HeavyOctave

public enum HeavyOctaveParameter: Sendable, Hashable {
  case octaveMinus1(UInt8)
  case octaveMinus2(UInt8)
  case directMix(UInt8)
}

/// The data bank representing the heavy octave parameters.
@KatanaBank
public struct HeavyOctaveBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00_01_00_7C, range: 0...100)
  public var octaveMinus1: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_7D, range: 0...100)
  public var octaveMinus2: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_7E, range: 0...100)
  public var directMix: UInt8 = 0
}
