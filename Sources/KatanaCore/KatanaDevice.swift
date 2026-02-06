import Foundation

/// Options for reading data from the device.
public enum ReadDataOptions: Hashable, Sendable {
  /// Read data from the device only.
  case deviceOnly

  /// Read data from the device first, then from the cache if not available.
  case deviceFirstCacheSecond

  /// Read data from the cache only.
  case cacheOnly

  /// Read data from the cache first, then from the device if not available.
  case cacheFirstDeviceSecond
}

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
  func readData(at address: UInt32, length: UInt16, options: ReadDataOptions) async throws
    -> [UInt8]
}
