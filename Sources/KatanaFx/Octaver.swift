import KatanaCore
import KatanaMacros

// MARK: - Octaver

/// The data bank representing the octaver parameters.
@KatanaFxBank
public struct OctaverBank: Sendable, Hashable {
  @Parameter(at: 0x00_00_00_00)
  public var range: OctaverRange = .range1

  @IntegerParameter(at: 0x00_00_00_01, range: 0...100)
  public var level: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_02, range: 0...100)
  public var directLevel: UInt8 = 0

  public static let size: UInt32 = 3
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
@KatanaFxBank
public struct HeavyOctaveBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00_00_00_00, range: 0...100)
  public var octaveMinus1: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_01, range: 0...100)
  public var octaveMinus2: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_02, range: 0...100)
  public var directMix: UInt8 = 0

  public static let size: UInt32 = 3
}
