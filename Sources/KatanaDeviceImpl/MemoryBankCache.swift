/// A dynamic cache for MIDI memory banks that mimics the 4-byte address structure of Katana devices.
/// It stores data in a hierarchical manner based on the first 3 bytes of the address, with the
/// 4th byte serving as an offset within a sparse `MemoryBank`.
struct MemoryBankCache {
  /// Hierarchical storage: [Byte1: [Byte2: [Byte3: MemoryBank]]]
  private var hierarchy: [UInt8: [UInt8: [UInt8: MemoryBank]]] = [:]

  /// Updates the cache with data starting at the specified address.
  /// This method iterates through the data byte-by-byte and correctly handles
  /// Roland-style address increments (7-bit carry-over) when crossing bank boundaries.
  mutating func update(address: UInt32, data: [UInt8]) {
    var currentAddress = address
    for value in data {
      // Decompose address into 4 bytes for indexing
      let byte1 = UInt8((currentAddress >> 24) & 0xFF)
      let byte2 = UInt8((currentAddress >> 16) & 0xFF)
      let byte3 = UInt8((currentAddress >> 8) & 0xFF)
      let byte4 = UInt8(currentAddress & 0xFF)

      // Get or create the sparse memory bank for the first 3 bytes
      let bank = getOrCreateBank(byte1: byte1, byte2: byte2, byte3: byte3)
      // Store the value at the 4th byte offset
      bank.set(offset: byte4, value: value)

      // Move to next address, handling 7-bit overflow
      currentAddress = nextRolandAddress(currentAddress)
    }
  }

  /// Retrieves a contiguous block of data from the cache.
  /// - Returns: The data starting from the given address up to the point where data is no longer
  ///   available in the cache or until the requested length is reached.
  func get(address: UInt32, length: Int) -> [UInt8] {
    var currentAddress = address
    var result: [UInt8] = []
    result.reserveCapacity(length)

    for _ in 0..<length {
      let byte1 = UInt8((currentAddress >> 24) & 0xFF)
      let byte2 = UInt8((currentAddress >> 16) & 0xFF)
      let byte3 = UInt8((currentAddress >> 8) & 0xFF)
      let byte4 = UInt8(currentAddress & 0xFF)

      // Navigate the hierarchy to find the requested byte
      guard let bank = hierarchy[byte1]?[byte2]?[byte3],
        let value = bank.get(offset: byte4)
      else {
        // If any byte in the requested range is missing, return the current result.
        return result
      }
      result.append(value)

      // Move to next address, handling 7-bit overflow
      currentAddress = nextRolandAddress(currentAddress)
    }
    return result
  }

  /// Increments a MIDI address following the Roland/Boss SysEx convention where
  /// each byte is limited to 7 bits (0x00 - 0x7F).
  private func nextRolandAddress(_ address: UInt32) -> UInt32 {
    var byte1 = UInt8((address >> 24) & 0xFF)
    var byte2 = UInt8((address >> 16) & 0xFF)
    var byte3 = UInt8((address >> 8) & 0xFF)
    var byte4 = UInt8(address & 0xFF)

    byte4 += 1
    if byte4 > 127 {
      byte4 = 0
      byte3 += 1
      if byte3 > 127 {
        byte3 = 0
        byte2 += 1
        if byte2 > 127 {
          byte2 = 0
          byte1 += 1
          // byte1 max is also 127 in SysEx
        }
      }
    }

    return (UInt32(byte1) << 24) | (UInt32(byte2) << 16) | (UInt32(byte3) << 8) | UInt32(byte4)
  }

  /// Navigates the 3-byte address hierarchy to find or create the `MemoryBank`
  /// associated with the given prefix.
  private mutating func getOrCreateBank(byte1: UInt8, byte2: UInt8, byte3: UInt8) -> MemoryBank {
    // Ensure the first level branch exists for byte1
    let branch1 = hierarchy[byte1] ?? [:]
    hierarchy[byte1] = branch1

    // Ensure the second level branch exists for byte2
    var branch2 = branch1[byte2] ?? [:]

    // Return the existing bank if it's already in the hierarchy
    if let existingBank = branch2[byte3] {
      return existingBank
    }

    // Otherwise, create a new bank and wire it back into the hierarchy
    let newBank = MemoryBank()
    branch2[byte3] = newBank
    hierarchy[byte1]?[byte2] = branch2

    return newBank
  }
}

/// A sparse storage for a single MIDI memory bank (offset 0-127).
private final class MemoryBank {
  /// Map of byte offset to value
  private var storage: [UInt8: UInt8] = [:]

  /// Stores a byte at the specified offset.
  func set(offset: UInt8, value: UInt8) {
    storage[offset] = value
  }

  /// Retrieves a byte from the specified offset if it exists.
  func get(offset: UInt8) -> UInt8? {
    return storage[offset]
  }
}
