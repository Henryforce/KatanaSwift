import Foundation
import KatanaCore
import KatanaGoData

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

  /// Enable or disable the FX bank.
  /// - Parameter enabled: The bank of parameters to send to the device.
  func enableFx(_ enabled: Bool, id: BankID) async throws

  /// Select the FX type.
  /// - Parameter type: The FX type to select.
  /// - Parameter id: The bank ID.
  func selectFxType(_ type: ModFxType, id: BankID) async throws

  /// Provides a stream of data received from the device.
  /// - Returns: An AsyncStream of KatanaGoDataBank.
  func read() -> AsyncStream<KatanaGoDataBank>
}
