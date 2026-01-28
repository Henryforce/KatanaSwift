import KatanaCore
import KatanaMacros

@KatanaBank
public struct ModeBank: Sendable, Hashable {
  @Parameter(at: 0x7F_01_00_04)
  public var mode: KatanaGoMode = .guitar
}

@KatanaUInt8RawBytes
public enum KatanaGoMode: UInt8, Sendable, Hashable, CaseIterable {
  case guitar = 0
  case bass = 1
}
