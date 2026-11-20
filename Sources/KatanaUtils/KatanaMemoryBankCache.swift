/// A dynamic cache for MIDI memory banks that mimics the 4-byte 7-bit address structure of Katana devices.
public struct KatanaMemoryBankCache: Sendable, Hashable {
  /// Sparse byte storage keyed by normalized 4-byte 7-bit Roland address (`0x7F7F_7F7F` mask).
  private var storage: [UInt32: UInt8] = [:]

  public init() {}

  /// Updates the cache with data starting at the specified address.
  /// Handles Roland-style 7-bit address carry-over (`0x7F -> 0x00`) when crossing bank boundaries.
  public mutating func update(address: UInt32, data: [UInt8]) {
    var currentAddress: UInt32? = address & 0x7F7F_7F7F
    for value in data {
      guard let addr = currentAddress else { break }
      storage[addr] = value
      currentAddress = nextRolandAddress(addr)
    }
  }

  /// Retrieves a contiguous block of `length` bytes from the cache starting at `address`.
  /// - Returns: The requested bytes if all `length` bytes are present in the cache, or `nil` if any byte is missing.
  public func get(address: UInt32, length: Int) -> [UInt8]? {
    guard length >= 0 else { return nil }
    if length == 0 { return [] }

    var currentAddress: UInt32? = address & 0x7F7F_7F7F
    var result: [UInt8] = []
    result.reserveCapacity(length)

    for _ in 0..<length {
      guard let addr = currentAddress, let value = storage[addr] else {
        return nil
      }
      result.append(value)
      currentAddress = nextRolandAddress(addr)
    }
    return result
  }

  /// Increments a MIDI address following the Roland/Boss SysEx convention where
  /// each byte is limited to 7 bits (`0x00...0x7F`). Returns `nil` on 28-bit overflow.
  private func nextRolandAddress(_ address: UInt32) -> UInt32? {
    var byte1 = UInt8((address >> 24) & 0x7F)
    var byte2 = UInt8((address >> 16) & 0x7F)
    var byte3 = UInt8((address >> 8) & 0x7F)
    var byte4 = UInt8(address & 0x7F)

    byte4 += 1
    if byte4 > 0x7F {
      byte4 = 0
      byte3 += 1
      if byte3 > 0x7F {
        byte3 = 0
        byte2 += 1
        if byte2 > 0x7F {
          byte2 = 0
          byte1 += 1
          if byte1 > 0x7F {
            return nil
          }
        }
      }
    }

    return (UInt32(byte1) << 24) | (UInt32(byte2) << 16) | (UInt32(byte3) << 8) | UInt32(byte4)
  }
}
