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

  /// Establishes a connection to the physical device.
  /// - Throws: `KatanaError.connectionFailed` if the device cannot be reached.
  func connect() async throws

  /// Closes the connection to the device.
  func disconnect() async

  /// Read the hardware device type.
  /// - Returns: The `KatanaDeviceType` (e.g., `.go`).
  func readDeviceType() async -> KatanaDeviceType

  /// Write raw bytes to the device's memory at a specific address.
  /// - Parameters:
  ///   - address: The target memory address (MIDI/Roland style).
  ///   - data: The raw bytes to write.
  /// - Throws: `KatanaError` if the write operation fails.
  func write(at address: UInt32, data: [UInt8]) async throws

  /// Subscribe to all incoming memory data from the device.
  /// - Returns: An `AsyncStream` that yields address-data pairs.
  func subscribeToData() -> AsyncStream<StreamData>

  /// Read a block of data from the device's memory.
  /// - Parameters:
  ///   - address: The starting memory address.
  ///   - length: The number of bytes to retrieve.
  ///   - options: Strategy for using the internal cache vs. hardware read.
  /// - Returns: The retrieved byte array.
  /// - Throws: `KatanaError` if the read fails or is missing from cache.
  func readData(at address: UInt32, length: UInt16, options: ReadDataOptions) async throws
    -> [UInt8]
}
