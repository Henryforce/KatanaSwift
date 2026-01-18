extension UInt16 {
  func encode11Bit() -> [UInt8] {
    let hh = UInt8((self >> 7) & 0x7F)
    let ll = UInt8(self & 0x7F)
    return [hh, ll]
  }
}
