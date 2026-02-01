import Foundation
import KatanaCore
import KatanaMacros

@KatanaBank
public struct SignalChainBank: KatanaGoBank, Sendable, Hashable {
  @Parameter(at: 0x00)
  public var chain: Chain = .threeOne

  @Parameter(at: 0x01)
  public var resonance: CabinetResonance = .vintage

  public static let katanaGoAddress: UInt32 = 0x20_00_10_00

  public static let size: UInt32 = 2
}

@KatanaUInt8RawBytes
public enum Chain: UInt8, Sendable, Hashable, CaseIterable {
  case one = 0x00
  case twoOne = 0x01
  case threeOne = 0x02
  case fourOne = 0x03
  case twoTwo = 0x04
  case threeTwo = 0x05
  case fourTwo = 0x06
  case bassOne = 0x07
  case bassTwo = 0x08
}

@KatanaUInt8RawBytes
public enum CabinetResonance: UInt8, Sendable, Hashable, CaseIterable {
  case vintage = 0x00
  case modern = 0x01
  case deep = 0x02
}
