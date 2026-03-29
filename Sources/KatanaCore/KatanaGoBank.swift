/// A bank of parameters for the Katana Go.
public protocol KatanaGoBank: WritableBank {
  /// The base address of the Katana Go bank.
  static var katanaGoAddress: UInt32 { get }
}

/// A bank representing the MOD or FX section of the device, which also includes EQ settings.
public protocol KatanaGoFxBank: KatanaGoBank {}
