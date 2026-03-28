import Foundation

/// A struct representing a write operation.
public struct WriteData: Sendable, Hashable {
  /// The address to write to.
  public let address: UInt32
  /// The data to write.
  public let data: [UInt8]

  /// Initializes a new instance of the WriteData struct.
  /// - Parameters:
  ///   - address: The address to write to.
  ///   - data: The data to write.
  public init(address: UInt32, data: [UInt8]) {
    self.address = address
    self.data = data
  }
}

/// A bank of parameters that can be written to a Katana device.
public protocol WritableBank {
  /// The size of the bank in bytes.
  static var size: UInt32 { get }

  /// Generates the necessary write operations to update this bank on the device.
  /// - Parameter baseAddress: The starting memory address for this bank.
  /// - Returns: An array of `WriteData` objects representing the split-up memory writes.
  func loadWriteData(baseAddress: UInt32) -> [WriteData]

  /// Construct a new bank instance by decoding data received from the device.
  /// - Parameter array: The raw bytes received from the device's memory.
  /// - Returns: A hydrated bank instance.
  static func buildFromByteArray(_ array: [UInt8]) -> Self
}
