import Foundation

// TODO: think about moving some methods as extensions and instead have simple methods
// that perform write and read with raw bytes.

/// Represents a connected Katana GO device.
public protocol KatanaDevice: Actor {
  /// Represents the streamed data received from the device.
  typealias StreamData = (address: UInt32, data: [UInt8])

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

  /// Subscribe to data from the device.
  /// - Returns: An AsyncStream of bytes read from the device.
  func subscribeToData() -> AsyncStream<StreamData>

  /// Read data from the device at a specific address.
  /// - Parameters:
  ///   - address: The starting address to read from.
  ///   - length: The number of bytes to read.
  /// - Returns: An array of bytes read from the device.
  func readData(at address: UInt32, length: UInt16) async throws -> [UInt8]
}
