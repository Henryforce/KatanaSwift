import KatanaGoData

extension DataBank {
  func buildNoiseGateBank() -> NoiseGateBank {
    return NoiseGateBank(
      status: self.nsBank[0x00] == 1,
      threshold: self.nsBank[0x01],
      release: self.nsBank[0x02]
    )
  }
}
