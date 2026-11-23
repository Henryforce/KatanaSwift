import KatanaCore
import KatanaMacros

public enum KatanaGoFxChannel: UInt8, KatanaByteCodable, Sendable, Hashable {
  case mod = 0x00
  case fx = 0x01
}
