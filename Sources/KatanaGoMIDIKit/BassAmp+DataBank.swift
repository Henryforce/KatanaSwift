import KatanaFx
import KatanaGoData

extension DataBank {
  func buildBassAmpBank() -> BassAmpBank {
    let rawDataBank = self.ampBank
    return BassAmpBank(
      type: BassAmpType(rawValue: rawDataBank[0x0C]) ?? .vintage,
      gain: rawDataBank[0x00],
      volume: rawDataBank[0x01],
      shape: rawDataBank[0x02] == 1,
      bass: rawDataBank[0x03],
      middle: rawDataBank[0x04],
      treble: rawDataBank[0x05],
      lowMidGain: rawDataBank[0x06],
      lowMidFreq: rawDataBank[0x07],
      highMidGain: rawDataBank[0x08],
      highMidFreq: rawDataBank[0x09],
      presence: rawDataBank[0x0A],
      variation: rawDataBank[0x0D] == 1
    )
  }
}
