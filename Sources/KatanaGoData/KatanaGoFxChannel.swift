/// Channel offset for MOD vs FX effect sections on the Katana GO.
public enum KatanaGoFxChannel: UInt32, Sendable, Hashable {
  case mod = 0x0000
  case fx = 0x1000
}
