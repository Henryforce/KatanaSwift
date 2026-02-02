import KatanaCore
import KatanaMacros

@KatanaBank
public struct StageFeelBank: KatanaGoBank, Sendable, Hashable {
  @Parameter(at: 0x00)
  public var select: StageFeelSelect = .off

  public static let katanaGoAddress: UInt32 = 0x10_00_30_00

  public static let size: UInt32 = 1
}

@KatanaBank
public struct StageFeelCustomBank: KatanaGoBank, Sendable, Hashable {
  @IntegerParameter(at: 0x00, range: 0...100)
  public var customGuitarPosition: UInt8 = 50

  @IntegerParameter(at: 0x01, range: 0...100)
  public var audioPosition: UInt8 = 50

  @Parameter(at: 0x02)
  public var ambienceType: AmbienceType = .room

  @IntegerParameter(at: 0x03, range: 0...100)
  public var ambienceLevel: UInt8 = 50

  public static let katanaGoAddress: UInt32 = 0x10_00_60_00

  public static let size: UInt32 = 4
}

@KatanaUInt8RawBytes
public enum StageFeelSelect: UInt8, Sendable, Hashable, CaseIterable {
  case off = 0x00
  case studio = 0x01
  case stage = 0x02
  case custom = 0x03
}

@KatanaUInt8RawBytes
public enum AmbienceType: UInt8, Sendable, Hashable, CaseIterable {
  case room = 0x00
  case smallHall = 0x01
  case largeHall = 0x02
}
