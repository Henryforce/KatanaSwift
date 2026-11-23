extension UInt8 {
  package var bytes: [UInt8] {
    return [self]
  }

  package static func decodeFromByteArray(_ array: [UInt8], offset: Int = 0) throws -> UInt8 {
    guard array.validateArrayAndOffset(offset) else {
      throw KatanaError.decodingFailed
    }
    return array[offset]
  }
}

extension UInt16 {
  package var bytes: [UInt8] {
    return encodeToByteArray()
  }

  package func encodeToByteArray() -> [UInt8] {
    return [
      UInt8((self >> 12) & 0xF),
      UInt8((self >> 8) & 0xF),
      UInt8((self >> 4) & 0xF),
      UInt8(self & 0xF),
    ]
  }

  package static func decodeFromByteArray(_ array: [UInt8], offset: Int = 0) throws -> UInt16 {
    guard offset >= 0, offset + 3 < array.count else {
      throw KatanaError.decodingFailed
    }
    return (UInt16(array[offset] & 0xF) << 12)
      | (UInt16(array[offset + 1] & 0xF) << 8)
      | (UInt16(array[offset + 2] & 0xF) << 4)
      | UInt16(array[offset + 3] & 0xF)
  }
}

extension Bool {
  package var bytes: [UInt8] {
    return [self ? 1 : 0]
  }

  package static func decodeFromByteArray(_ array: [UInt8], offset: Int = 0) throws -> Bool {
    guard array.validateArrayAndOffset(offset) else {
      throw KatanaError.decodingFailed
    }
    return array[offset] == 1
  }
}

extension Array where Element == UInt8 {
  fileprivate func validateArrayAndOffset(_ offset: Int) -> Bool {
    return !isEmpty && offset >= 0 && offset < count
  }
}
