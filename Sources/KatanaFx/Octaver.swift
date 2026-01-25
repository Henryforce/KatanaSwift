import KatanaCore
import KatanaMacros

// MARK: - Octaver

/// The data bank representing the octaver parameters.
@KatanaFxBank
public struct OctaverBank: Sendable, Hashable {
  @FxParameter(id: .octaverRange)
  public var range: OctaverRange = .range1

  @FxIntegerParameter(id: .octaverLevel, range: 0...100)
  public var level: UInt8 = 50

  @FxIntegerParameter(id: .octaverDirectLevel, range: 0...100)
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
@KatanaFxBank
public struct HeavyOctaveBank: Sendable, Hashable {
  @FxIntegerParameter(id: .heavyOctaveOctaveMinus1, range: 0...100)
  public var octaveMinus1: UInt8 = 50

  @FxIntegerParameter(id: .heavyOctaveOctaveMinus2, range: 0...100)
  public var octaveMinus2: UInt8 = 50

  @FxIntegerParameter(id: .heavyOctaveDirectMix, range: 0...100)
  public var directMix: UInt8 = 0
}
