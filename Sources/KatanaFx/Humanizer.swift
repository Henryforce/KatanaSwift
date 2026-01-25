import KatanaCore
import KatanaMacros

// MARK: - Humanizer

/// The data bank representing the humanizer parameters.
@KatanaFxBank
public struct HumanizerBank: Sendable, Hashable {
  @FxParameter(id: .humanizerMode)
  public var mode: HumanizerMode = .picking

  @FxParameter(id: .humanizerVowel1)
  public var vowel1: HumanizerWovel = .a

  @FxParameter(id: .humanizerVowel2)
  public var vowel2: HumanizerWovel = .e

  @FxIntegerParameter(id: .humanizerSens, range: 0...100)
  public var sens: UInt8 = 50

  @FxIntegerParameter(id: .humanizerRate, range: 0...100)
  public var rate: UInt8 = 50

  @FxIntegerParameter(id: .humanizerDepth, range: 0...100)
  public var depth: UInt8 = 50

  @FxIntegerParameter(id: .humanizerManual, range: 0...100)
  public var manual: UInt8 = 50

  @FxIntegerParameter(id: .humanizerLevel, range: 0...100)
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
