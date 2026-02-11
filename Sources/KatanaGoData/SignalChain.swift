import Foundation
import KatanaCore
import KatanaMacros

@KatanaBank
public struct SignalChainBank: KatanaGoBank, Sendable, Hashable {
  @Parameter(at: 0x00)
  public var chain: Chain = .threeOne

  @Parameter(at: 0x01)
  public var resonance: CabinetResonance = .vintage

  @Parameter(at: 0x03)
  public var patchKey: PatchKey = .c

  public static let katanaGoAddress: UInt32 = 0x20_00_10_00

  public static let size: UInt32 = 4
}

// TODO: verify values
@KatanaUInt8RawBytes
public enum PatchKey: UInt8, Sendable, Hashable, CaseIterable {
  case c = 0x00
  case db = 0x01
  case d = 0x02
  case eb = 0x03
  case e = 0x04
  case f = 0x05
  case gb = 0x06
  case g = 0x07
  case ab = 0x08
  case a = 0x09
  case bb = 0x0A
  case b = 0x0B
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
  // For some reason, it appears there are 3 undefined values so these cases are added
  // to prevent a crash in case any of these happen to be set.
  case undefined1 = 0x03
  case undefined2 = 0x04
  case undefined3 = 0x05
}
