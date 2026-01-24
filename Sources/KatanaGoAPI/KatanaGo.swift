import Foundation
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

  /// Write a command to the device.
  /// - Parameter command: The command data to send to the device.
  func write(_ command: KatanaGoWriteData) async throws

  /// Write a bank of parameters to the device.
  /// - Parameter bank: The bank of parameters to send to the device.
  func writeBank(_ bank: WritableBank) async throws

  /// Provides a stream of data received from the device.
  /// - Returns: An AsyncStream of KatanaGoReadData.
  func read() -> AsyncStream<KatanaGoReadData>
}
