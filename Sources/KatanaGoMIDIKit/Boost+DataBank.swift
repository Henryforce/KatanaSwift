import KatanaGoData

extension DataBank {
  func buildBoostBank() -> BoostBank {
    let rawDataBank = self.boosterBank
    return BoostBank(
      type: BoostType(rawValue: rawDataBank[0x00]) ?? .midBoost,
      drive: rawDataBank[0x01],
      bottom: rawDataBank[0x02],
      tone: rawDataBank[0x03],
      soloSwitchStatus: rawDataBank[0x04] == 1,
      soloLevel: rawDataBank[0x05],
      effectLevel: rawDataBank[0x06],
      directMix: rawDataBank[0x07]
    )
  }
}
