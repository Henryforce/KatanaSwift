import KatanaGoData

extension DataBank {
  func buildAmpBank() -> AmpBank {
    let rawDataBank = self.preampBank
    return AmpBank(
      type: AmpType(rawValue: rawDataBank[0x0C]) ?? .clean,
      gain: rawDataBank[0x00],
      volume: rawDataBank[0x01],
      bass: rawDataBank[0x03],
      middle: rawDataBank[0x04],
      treble: rawDataBank[0x05],
      presence: rawDataBank[0x0A],
      variation: rawDataBank[0x0D] == 1
    )
  }
}
