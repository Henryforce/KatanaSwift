import KatanaCore
import KatanaMacros

// MARK: - Humanizer

/// The data bank representing the humanizer parameters.
@KatanaBank
public struct HumanizerBank: Sendable, Hashable {
  @Parameter(at: 0x00_01_01_39)
  public var mode: HumanizerMode = .picking

  @Parameter(at: 0x00_01_01_3A)
  public var vowel1: HumanizerWovel = .a

  @Parameter(at: 0x00_01_01_3B)
  public var vowel2: HumanizerWovel = .e

  @IntegerParameter(at: 0x00_01_01_3C, range: 0...100)
  public var sens: UInt8 = 50

  @IntegerParameter(at: 0x00_01_01_3D, range: 0...100)
  public var rate: UInt8 = 50

  @IntegerParameter(at: 0x00_01_01_3E, range: 0...100)
  public var depth: UInt8 = 50

  @IntegerParameter(at: 0x00_01_01_3F, range: 0...100)
  public var manual: UInt8 = 50

  @IntegerParameter(at: 0x00_01_01_40, range: 0...100)
  public var level: UInt8 = 100
}

@KatanaUInt8RawBytes
public enum HumanizerMode: UInt8, Sendable, Hashable, CaseIterable {
  case picking = 0x00
  case auto = 0x01
}

@KatanaUInt8RawBytes
public enum HumanizerWovel: UInt8, Sendable, Hashable, CaseIterable {
  case a = 0x00
  case e = 0x01
  case i = 0x02
  case o = 0x03
  case u = 0x04
}
