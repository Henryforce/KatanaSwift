import KatanaCore
import KatanaMacros

@KatanaBank
public struct SignalChainPedalFxBank: KatanaGoBank, Sendable, Hashable {
  @Parameter(at: 0x00)
  public var position: Bool = false  // TODO: This could be a different type

  @Parameter(at: 0x01)
  public var status: Bool = false

  @Parameter(at: 0x02)
  public var type: PedalFxType = .wah

  public static let katanaGoAddress: UInt32 = 0x20_02_40_00

  public static let size: UInt32 = 3
}

public struct PedalFxBanks: KatanaGoBank, Sendable, Hashable {
  public var wah = PedalFxWahBank()

  public var bend = PedalFxBendBank()

  public var wah95 = PedalFxWah95Bank()

  public static let katanaGoAddress: UInt32 = 0x20_02_50_00

  public static let size: UInt32 =
    PedalFxWahBank.size + PedalFxBendBank.size + PedalFxWah95Bank.size

  public init(
    wah: PedalFxWahBank? = nil, bend: PedalFxBendBank? = nil, wah95: PedalFxWah95Bank? = nil
  ) {
    if let wah { self.wah = wah }
    if let bend { self.bend = bend }
    if let wah95 { self.wah95 = wah95 }
  }

  public func loadWriteData(baseAddress: UInt32) -> [WriteData] {
    var writeData = [WriteData]()
    writeData.append(contentsOf: wah.loadWriteData(baseAddress: baseAddress))
    writeData.append(contentsOf: bend.loadWriteData(baseAddress: baseAddress))
    writeData.append(contentsOf: wah95.loadWriteData(baseAddress: baseAddress))
    return writeData
  }

  public static func buildFromByteArray(_ array: [UInt8]) -> Self {
    let wahArrayOffset = Int(PedalFxWahBank.katanaGoAddress - Self.katanaGoAddress)
    let wahArray = Array(array[wahArrayOffset..<wahArrayOffset + Int(PedalFxWahBank.size)])

    let bendArrayOffset = Int(PedalFxBendBank.katanaGoAddress - Self.katanaGoAddress)
    let bendArray = Array(array[bendArrayOffset..<bendArrayOffset + Int(PedalFxBendBank.size)])

    let wah95ArrayOffset = Int(PedalFxWah95Bank.katanaGoAddress - Self.katanaGoAddress)
    let wah95Array = Array(array[wah95ArrayOffset..<wah95ArrayOffset + Int(PedalFxWah95Bank.size)])

    return Self(
      wah: PedalFxWahBank.buildFromByteArray(wahArray),
      bend: PedalFxBendBank.buildFromByteArray(bendArray),
      wah95: PedalFxWah95Bank.buildFromByteArray(wah95Array)
    )
  }
}

@KatanaBank
public struct PedalFxWahBank: KatanaGoBank, Sendable, Hashable {
  @Parameter(at: 0x00)
  public var wahType: PedalFxWahType = .cryWah

  @IntegerParameter(at: 0x01, range: 0...100)
  public var pedalPosition: UInt8 = 50

  @IntegerParameter(at: 0x02, range: 0...100)
  public var pedalMin: UInt8 = 50

  @IntegerParameter(at: 0x03, range: 0...100)
  public var pedalMax: UInt8 = 50

  @IntegerParameter(at: 0x04, range: 0...100)
  public var effectLevel: UInt8 = 50

  @IntegerParameter(at: 0x05, range: 0...100)
  public var directMix: UInt8 = 50

  public static let katanaGoAddress: UInt32 = 0x20_02_50_00

  public static let size: UInt32 = 6
}

@KatanaBank
public struct PedalFxBendBank: KatanaGoBank, Sendable, Hashable {
  @IntegerParameter(at: 0x00, range: 0...100)
  public var pitch: UInt8 = 50

  @IntegerParameter(at: 0x01, range: 0...100)
  public var position: UInt8 = 50

  @IntegerParameter(at: 0x02, range: 0...100)
  public var effectLevel: UInt8 = 50

  @IntegerParameter(at: 0x03, range: 0...100)
  public var directMix: UInt8 = 50

  public static let katanaGoAddress: UInt32 = 0x20_02_50_06

  public static let size: UInt32 = 4
}

@KatanaBank
public struct PedalFxWah95Bank: KatanaGoBank, Sendable, Hashable {
  @IntegerParameter(at: 0x00, range: 0...100)
  public var pedalPosition: UInt8 = 50

  @IntegerParameter(at: 0x01, range: 0...100)
  public var pedalMin: UInt8 = 50

  @IntegerParameter(at: 0x02, range: 0...100)
  public var pedalMax: UInt8 = 50

  @IntegerParameter(at: 0x03, range: 0...100)
  public var effectLevel: UInt8 = 50

  @IntegerParameter(at: 0x04, range: 0...100)
  public var directMix: UInt8 = 50

  public static let katanaGoAddress: UInt32 = 0x20_02_50_0A

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
