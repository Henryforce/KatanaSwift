import KatanaCore
import KatanaMacros

// MARK: - Harmonist

/// The data bank representing the harmonist parameters.
@KatanaBank
public struct HarmonistBank: Sendable, Hashable {
  @Parameter(at: 0x00_01_01_12)
  public var voice: HarmonistVoice = .oneVoice

  @Parameter(at: 0x00_01_01_13)
  public var h1Harmony: HarmonistHarmony = .unison

  @IntegerParameter(at: 0x00_01_01_14, range: 0...300)
  public var h1PreDelay: UInt16 = 0

  @IntegerParameter(at: 0x00_01_01_18, range: 0...100)
  public var h1Level: UInt8 = 100

  @Parameter(at: 0x00_01_01_19)
  public var h2Harmony: HarmonistHarmony = .unison

  @IntegerParameter(at: 0x00_01_01_1A, range: 0...300)
  public var h2PreDelay: UInt16 = 0

  @IntegerParameter(at: 0x00_01_01_1E, range: 0...100)
  public var h2Level: UInt8 = 100

  @IntegerParameter(at: 0x00_01_01_1F, range: 0...100)
  public var h1Feedback: UInt8 = 0

  @IntegerParameter(at: 0x00_01_01_20, range: 0...100)
  public var directLevel: UInt8 = 0
}

@KatanaUInt8RawBytes
public enum HarmonistVoice: UInt8, Sendable, Hashable, CaseIterable {
  case oneVoice = 0x00
  case twoVoice = 0x01
}

@KatanaUInt8RawBytes
public enum HarmonistHarmony: UInt8, Sendable, Hashable, CaseIterable {
  case minus2oct = 0x00
  case minus14th = 0x01
  case minus13th = 0x02
  case minus12th = 0x03
  case minus11th = 0x04
  case minus10th = 0x05
  case minus9th = 0x06
  case minus8th = 0x07
  case minus7th = 0x08
  case minus6th = 0x09
  case minus5th = 0x0A
  case minus4th = 0x0B
  case minus3rd = 0x0C
  case minus2nd = 0x0D
  case unison = 0x0E
  case plus2nd = 0x0F
  case plus3rd = 0x10
  case plus4th = 0x11
  case plus5th = 0x12
  case plus6th = 0x13
  case plus7th = 0x14
  case plus8th = 0x15
  case plus9th = 0x16
  case plus10th = 0x17
  case plus11th = 0x18
  case plus12th = 0x19
  case plus13th = 0x1A
  case plus14th = 0x1B
  case plus2oct = 0x1C
  case user = 0x1D
}
