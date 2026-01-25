import KatanaEQ
import KatanaFx
import KatanaGoData

extension DataBank {
  func buildSoloBank() -> SoloBank {
    return SoloBank(
      status: self.soloSwitchLevelBank[0x00] == 1,
      level: self.soloSwitchLevelBank[0x01],
      eqPosition: EQPosition(rawValue: self.soloBank[0x00]) ?? .ampIn,
      eqStatus: self.soloBank[0x01] == 1,
      eqLowCut: EQLowCut(rawValue: self.soloBank[0x02]) ?? .flat,
      eqLowGain: self.soloBank[0x03],
      eqMidFreq: EQFrequency(rawValue: self.soloBank[0x04]) ?? .freq20Hz,
      eqMidQ: EQQ(rawValue: self.soloBank[0x05]) ?? .q05,
      eqMidGain: self.soloBank[0x06],
      eqHighGain: self.soloBank[0x07],
      eqHighCut: EQHighCut(rawValue: self.soloBank[0x08]) ?? .freq630Hz,
      eqLevel: self.soloBank[0x09]
    )
  }
}
