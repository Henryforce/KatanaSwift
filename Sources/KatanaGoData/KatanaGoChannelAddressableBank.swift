import KatanaCore

public protocol KatanaGoChannelAddressableBank: KatanaGoBank {
  associatedtype BankChannel: RawRepresentable where BankChannel.RawValue == UInt32

  static var channelType: BankChannel.Type { get }
}
