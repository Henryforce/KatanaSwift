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

  /// Loads the write data for the bank.
  func loadWriteData(baseAddress: UInt32) -> [WriteData]

  /// Builds a bank from a byte array.
  static func buildFromByteArray(_ array: [UInt8]) -> Self
}
