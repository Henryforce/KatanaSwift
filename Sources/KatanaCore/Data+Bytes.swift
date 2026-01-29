extension UInt8 {
  package var bytes: [UInt8] {
    return [self]
  }

  package static func decodeFromByteArray(_ array: [UInt8], offset: Int = 0) -> UInt8? {
    guard array.validateArrayAndOffset(offset) else {
      return nil
    }
    return array[offset]
  }
}

extension UInt16 {
  package var bytes: [UInt8] {
    return encodeToByteArray()
  }

  package func encodeToByteArray() -> [UInt8] {
    return [UInt8(self >> 12), UInt8(self >> 8), UInt8(self >> 4), UInt8(self & 0xF)]
  }

  package static func decodeFromByteArray(_ array: [UInt8], offset: Int = 0) -> UInt16? {
    guard array.validateArrayAndOffset(offset) else {
      return nil
    }
    return (UInt16(array[offset]) << 12) | (UInt16(array[offset + 1]) << 8)
      | (UInt16(array[offset + 2]) << 4) | UInt16(array[offset + 3])
  }
}

extension Bool {
  package var bytes: [UInt8] {
    return [self ? 1 : 0]
  }

  package static func decodeFromByteArray(_ array: [UInt8], offset: Int = 0) -> Bool? {
    guard array.validateArrayAndOffset(offset) else {
      return nil
    }
    return array[offset] == 1
  }
}

extension Array where Element == UInt8 {
  fileprivate func validateArrayAndOffset(_ offset: Int) -> Bool {
    return !isEmpty && offset >= 0 && offset < count
  }
}
