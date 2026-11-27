import KatanaCore

/// A bank of parameters addressable across multiple channels on the Katana GO.
public protocol KatanaGoChannelAddressableBank: KatanaGoBank {
  associatedtype BankChannel: RawRepresentable & Sendable where BankChannel.RawValue == UInt32
}
