import KatanaFx
import KatanaGoData

extension DataBank {
  func buildBassCompBank() -> BassCompLimBank {
    let rawDataBank = self.bassCompBank
    return BassCompLimBank(
      mode: BassCompLimMode(rawValue: rawDataBank[0x00]) ?? .comp,
      compType: BassCompType(rawValue: rawDataBank[0x01]) ?? .bossComp,
      sustain: rawDataBank[0x02],
      compAttack: rawDataBank[0x03],
      tone: rawDataBank[0x04],
      compEffect: rawDataBank[0x05],
      limiterType: BassLimType(rawValue: rawDataBank[0x06]) ?? .bossLimiter,
      limiterAttack: rawDataBank[0x07],
      threshold: rawDataBank[0x08],
      ratio: LimiterRatio(rawValue: rawDataBank[0x09]) ?? .fiveToOne,
      release: rawDataBank[0x0A],
      limiterEffect: rawDataBank[0x0B]
    )
  }
}
