/// A type that can be encoded to and decoded from raw Roland/BOSS SysEx bytes.
public protocol KatanaByteCodable: Sendable {
  /// The raw SysEx byte representation of this value.
  var bytes: [UInt8] { get }

  /// Decodes a value from a SysEx byte array at the given offset.
  /// - Throws: `KatanaError.decodingFailed` if the buffer is too short or contains an invalid value.
  static func decodeFromByteArray(_ array: [UInt8], offset: Int) throws -> Self
}

extension KatanaByteCodable where Self: RawRepresentable, RawValue == UInt8 {
  public var bytes: [UInt8] {
    [rawValue]
  }

  public static func decodeFromByteArray(_ array: [UInt8], offset: Int = 0) throws -> Self {
    guard offset >= 0, offset < array.count, let value = Self(rawValue: array[offset]) else {
      throw KatanaError.decodingFailed
    }
    return value
  }
}
