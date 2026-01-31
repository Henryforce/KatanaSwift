import Foundation
import KatanaCore
import KatanaGoData

// TODO: move to KatanaCore
public protocol WritableChannelBank: WritableBank {
  associatedtype BankChannel: RawRepresentable where BankChannel.RawValue == UInt8

  static var channelType: BankChannel.Type { get }
}

// public protocol KatanaGoFxBank: WritableBank, WritableChannelBank {

// }

// public extension KatanaGoFxBank {
//   nonisolated(unsafe)
//   public static var channelType: KatanaGoFxChannel.Type = { KatanaGoFxChannel.self }
// }

/// Represents a connected Katana GO device.
public protocol KatanaGo: Actor {
  /// Checks the current connection status.
  /// - Returns: The current connection status.
  func connectionStatus() async -> ConnectionStatus

  /// Connect to the device.
  func connect() async throws

  /// Disconnect from the device.
  func disconnect() async

  /// Write a bank of parameters to the device.
  /// - Parameter bank: The bank of parameters to send to the device.
  func writeBank<T: WritableBank>(_ bank: T) async throws

  /// Write a bank of parameters to the device.
  /// - Parameter bank: The bank of parameters to send to the device.
  /// - Parameter channel: The channel to send the bank to.
  func writeFxBank<T: KatanaGoFxBank>(_ bank: T, channel: KatanaGoFxChannel) async throws

  /// Enable or disable the FX bank.
  /// - Parameter enabled: The bank of parameters to send to the device.
  func enableFx(_ enabled: Bool, channel: KatanaGoFxChannel) async throws

  /// Select the FX type.
  /// - Parameter type: The FX type to select.
  /// - Parameter channel: The channel to send the bank to.
  func selectFxType(_ type: ModFxType, channel: KatanaGoFxChannel) async throws

  /// Provides a stream of data received from the device.
  /// - Returns: An AsyncStream of KatanaGoDataBank.
  func read() -> AsyncStream<KatanaGoDataBank>
}
