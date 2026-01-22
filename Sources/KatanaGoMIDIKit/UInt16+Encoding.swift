extension UInt16 {
  func encodeToByteArray() -> [UInt8] {
    return [UInt8(self >> 12), UInt8(self >> 8), UInt8(self >> 4), UInt8(self & 0xF)]
  }

  static func decodeFromByteArray(_ array: [UInt8]) -> UInt16 {
    return (UInt16(array[0]) << 12) | (UInt16(array[1]) << 8) | (UInt16(array[2]) << 4)
      | UInt16(array[3])
  }
}
