import KatanaCore
import KatanaMacros

@KatanaUInt8RawBytes
public enum KatanaGoFxChannel: UInt8, Sendable, Hashable {
  case mod = 0x00
  case fx = 0x01
}
