/// A bank of parameters for the Katana Go.
public protocol KatanaGoBank: WritableBank {
  /// The base address of the Katana Go bank.
  static var katanaGoAddress: UInt32 { get }
}

/// A bank of parameters for the MOD/FX section.
public protocol KatanaGoFxBank: KatanaGoBank {}
