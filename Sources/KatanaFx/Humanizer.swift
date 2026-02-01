import KatanaCore
import KatanaMacros

// MARK: - Humanizer

/// The data bank representing the humanizer parameters.
@KatanaBank
public struct HumanizerBank: Sendable, Hashable {
  @Parameter(at: 0x00_00_00_00)
  public var mode: HumanizerMode = .picking

  @Parameter(at: 0x00_00_00_01)
  public var vowel1: HumanizerWovel = .a

  @Parameter(at: 0x00_00_00_02)
  public var vowel2: HumanizerWovel = .e

  @IntegerParameter(at: 0x00_00_00_03, range: 0...100)
  public var sens: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_04, range: 0...100)
  public var rate: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_05, range: 0...100)
  public var depth: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_06, range: 0...100)
  public var manual: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_07, range: 0...100)
  public var level: UInt8 = 100

  public static let size: UInt32 = 8
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
