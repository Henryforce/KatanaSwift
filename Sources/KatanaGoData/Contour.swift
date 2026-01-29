import KatanaCore
import KatanaMacros

@KatanaBank
public struct ContourBank: Sendable, Hashable {
  @Parameter(at: 0x00)
  public var type: ContourType = .off

  @IntegerParameter(at: 0x01, range: 0...100)
  public var frequencyShift: UInt8 = 50

  public static let address: UInt32 = 0x20_02_10_00

  public static let size: UInt32 = 2
}

@KatanaUInt8RawBytes
public enum ContourType: UInt8, Sendable, Hashable, CaseIterable {
  case off = 0x00
  case one = 0x01
  case two = 0x02
  case three = 0x03
}
