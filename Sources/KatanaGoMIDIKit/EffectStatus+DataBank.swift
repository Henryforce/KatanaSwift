import KatanaGoData

extension DataBank {
  func buildEffectStatusBank() -> EffectStatusBank {
    let rawDataBank = self.effectsOnOffBank
    return EffectStatusBank(
      booster: rawDataBank[0] == 1,
      mod: rawDataBank[1] == 1,
      fx: rawDataBank[2] == 1,
      delay1: rawDataBank[3] == 1,
      delay2: rawDataBank[4] == 1,
      reverb: rawDataBank[5] == 1,
      bassComp: rawDataBank[6] == 1
    )
  }
}
