import Foundation
import KatanaCore
import KatanaGoData

// TODO: think about moving some methods as extensions and instead have simple methods
// that perform write and read with raw bytes.

/// Represents a connected Katana GO device.
public protocol KatanaDevice: Actor {
  /// Checks the current connection status.
  /// - Returns: The current connection status.
  func connectionStatus() async -> ConnectionStatus

  /// Connect to the device.
  func connect() async throws

  /// Disconnect from the device.
  func disconnect() async

  /// Read the device type from the device.
  func readDeviceType() async -> KatanaDeviceType

  /// Write raw bytes to the device.
  /// - Parameters:
  ///   - address: The starting address to write to.
  ///   - data: The bytes to write to the device.
  func write(at address: UInt32, data: [UInt8]) async throws

  /// Write a bank of parameters to the device.
  /// - Parameter bank: The bank of parameters to send to the device.
  func writeBank<T: KatanaGoBank>(_ bank: T) async throws

  /// Read data from the device at a specific address.
  /// - Parameters:
  ///   - address: The starting address to read from.
  ///   - length: The number of bytes to read.
  /// - Returns: An array of bytes read from the device.
  func readData(at address: UInt32, length: UInt16) async throws -> [UInt8]

  /// Read a bank of parameters from the device.
  /// - Parameter type: The type of bank to read.
  func readBank<T: KatanaGoBank>(_ type: T.Type) async throws -> T

  // TODO: move these methods outside.

  /// Write a bank of parameters to the device.
  /// - Parameter bank: The bank of parameters to send to the device.
  /// - Parameter channel: The channel to send the bank to.
  func writeFxBank<T: KatanaGoFxBank>(_ bank: T, channel: KatanaGoFxChannel) async throws

  /// Write a bank of parameters to the device.
  /// - Parameter bank: The bank of parameters to send to the device.
  /// - Parameter channel: The channel to send the bank to.
  func writeChannelAddressableBank<T: KatanaGoChannelAddressableBank>(
    _ bank: T, channel: T.BankChannel) async throws

  /// Enable or disable the FX bank.
  /// - Parameter enabled: The bank of parameters to send to the device.
  func enableFx(_ enabled: Bool, channel: KatanaGoFxChannel) async throws

  /// Select the FX type.
  /// - Parameter type: The FX type to select.
  /// - Parameter channel: The channel to send the bank to.
  func selectFxType(_ type: ModFxType, channel: KatanaGoFxChannel) async throws

  /// Read a bank of parameters from the device.
  /// - Parameter type: The type of bank to read.
  /// - Parameter channel: The channel to read the bank from.
  func readFxBank<T: KatanaGoFxBank>(_ type: T.Type, channel: KatanaGoFxChannel) async throws -> T

  /// Provides a stream of data received from the device.
  /// - Returns: An AsyncStream of KatanaGoDataBank.
  func read() -> AsyncStream<KatanaGoDataBank>
}
