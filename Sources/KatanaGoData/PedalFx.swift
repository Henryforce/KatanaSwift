import KatanaCore
import KatanaMacros

public struct PedalFxBank: Sendable, Hashable {
  @Parameter(at: 0x20_02_40_01)
  public var status: Bool = false

  @Parameter(at: 0x20_02_40_02)
  public var type: PedalFxType = .wah

  public var wah: PedalFxWahBank

  public var bend: PedalFxBendBank

  public var wah95: PedalFxWah95Bank

  public init(
    status: Bool, type: PedalFxType, wah: PedalFxWahBank, bend: PedalFxBendBank,
    wah95: PedalFxWah95Bank
  ) {
    self.status = status
    self.type = type
    self.wah = wah
    self.bend = bend
    self.wah95 = wah95
  }
}

@KatanaBank
public struct PedalFxWahBank: Sendable, Hashable {
  @Parameter(at: 0x20_02_50_00)
  public var wahType: PedalFxWahType = .cryWah

  @IntegerParameter(at: 0x20_02_50_01, range: 0...100)
  public var pedalPosition: UInt8 = 50

  @IntegerParameter(at: 0x20_02_50_02, range: 0...100)
  public var pedalMin: UInt8 = 50

  @IntegerParameter(at: 0x20_02_50_03, range: 0...100)
  public var pedalMax: UInt8 = 50

  @IntegerParameter(at: 0x20_02_50_04, range: 0...100)
  public var effectLevel: UInt8 = 50

  @IntegerParameter(at: 0x20_02_50_05, range: 0...100)
  public var directMix: UInt8 = 50

  public static let address: UInt32 = 0x20_02_50_00

  public static let size: UInt32 = 6
}

@KatanaBank
public struct PedalFxBendBank: Sendable, Hashable {
  @IntegerParameter(at: 0x20_02_50_06, range: 0...100)
  public var pitch: UInt8 = 50

  @IntegerParameter(at: 0x20_02_50_07, range: 0...100)
  public var position: UInt8 = 50

  @IntegerParameter(at: 0x20_02_50_08, range: 0...100)
  public var effectLevel: UInt8 = 50

  @IntegerParameter(at: 0x20_02_50_09, range: 0...100)
  public var directMix: UInt8 = 50

  public static let address: UInt32 = 0x20_02_50_06

  public static let size: UInt32 = 4
}

@KatanaBank
public struct PedalFxWah95Bank: Sendable, Hashable {
  @IntegerParameter(at: 0x20_02_50_0A, range: 0...100)
  public var pedalPosition: UInt8 = 50

  @IntegerParameter(at: 0x20_02_50_0B, range: 0...100)
  public var pedalMin: UInt8 = 50

  @IntegerParameter(at: 0x20_02_50_0C, range: 0...100)
  public var pedalMax: UInt8 = 50

  @IntegerParameter(at: 0x20_02_50_0D, range: 0...100)
  public var effectLevel: UInt8 = 50

  @IntegerParameter(at: 0x20_02_50_0E, range: 0...100)
  public var directMix: UInt8 = 50

  public static let address: UInt32 = 0x20_02_50_0A

  public static let size: UInt32 = 5
}

// MARK - Pedal FX Options

@KatanaUInt8RawBytes
public enum PedalFxType: UInt8, Sendable, Hashable, CaseIterable {
  case wah = 0x00
  case wah95 = 0x01
  case pbend = 0x02
}

@KatanaUInt8RawBytes
public enum PedalFxWahType: UInt8, Sendable, Hashable, CaseIterable {
  case cryWah = 0x00
  case voWah = 0x01
  case fatWah = 0x02
  case lightWah = 0x03
  case sevenStringWah = 0x04
  case resoWah = 0x05
}
