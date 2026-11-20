/// Helpers for Roland/BOSS 7-bit SysEx address and size encoding.
///
/// Roland SysEx addresses and RQ1 size fields are 4 bytes where each byte carries 7 bits (`0x00...0x7F`).
package enum RolandAddress {
  /// Encodes a linear 28-bit unsigned value into 4 7-bit Roland bytes (big-endian).
  package static func encode7BitBytes(_ value: UInt32) -> [UInt8] {
    [
      UInt8((value >> 21) & 0x7F),
      UInt8((value >> 14) & 0x7F),
      UInt8((value >> 7) & 0x7F),
      UInt8(value & 0x7F),
    ]
  }

  /// Decodes a packed 4-byte Roland address (`UInt32`) into a linear 28-bit integer.
  package static func toLinear(_ address: UInt32) -> Int {
    let b1 = (address >> 24) & 0x7F
    let b2 = (address >> 16) & 0x7F
    let b3 = (address >> 8) & 0x7F
    let b4 = address & 0x7F
    return (Int(b1) << 21) | (Int(b2) << 14) | (Int(b3) << 7) | Int(b4)
  }

  /// Converts a linear 28-bit integer back into a packed 4-byte Roland address (`UInt32`).
  package static func fromLinear(_ linear: Int) -> UInt32 {
    let b1 = UInt32((linear >> 21) & 0x7F)
    let b2 = UInt32((linear >> 14) & 0x7F)
    let b3 = UInt32((linear >> 7) & 0x7F)
    let b4 = UInt32(linear & 0x7F)
    return (b1 << 24) | (b2 << 16) | (b3 << 8) | b4
  }

  /// Adds a linear byte offset to a packed Roland address, carrying over at 7-bit boundaries (`0x7F -> 0x00`).
  package static func adding(_ offset: UInt32, to address: UInt32) -> UInt32 {
    fromLinear(toLinear(address) + Int(offset))
  }
}
