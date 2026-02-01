import KatanaCore
import KatanaMacros

@KatanaBank
public struct ModeBank: KatanaGoBank, Sendable, Hashable {
  @Parameter(at: 0x00)
  public var mode: KatanaGoMode = .guitar

  public static let katanaGoAddress: UInt32 = 0x7F_01_00_04

  public static let size: UInt32 = 1
}

@KatanaUInt8RawBytes
public enum KatanaGoMode: UInt8, Sendable, Hashable, CaseIterable {
  case guitar = 0
  case bass = 1
}
