import KatanaCore
import KatanaMacros

/// The bank ID for the bank index.
public enum BankID: Sendable, Hashable {
  case id1
  case id2
  case id3
  case id4
}

@KatanaUInt8RawBytes
public enum KatanaGoFxChannel: UInt8, Sendable, Hashable {
  case mod = 0x00
  case fx = 0x01
}
