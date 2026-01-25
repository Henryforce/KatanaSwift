import KatanaGoData

extension DataBank {
  func buildPedalFxWahBank() -> PedalFxWahBank {
    let rawDataBank = self.pfxWahBank
    return PedalFxWahBank(
      wahType: PedalFxWahType(rawValue: rawDataBank[0x00]) ?? .cryWah,
      pedalPosition: rawDataBank[0x01],
      pedalMin: rawDataBank[0x02],
      pedalMax: rawDataBank[0x03],
      effectLevel: rawDataBank[0x04],
      directMix: rawDataBank[0x05]
    )
  }

  func buildPedalFxBendBank() -> PedalFxBendBank {
    let rawDataBank = self.pfxWahBank
    return PedalFxBendBank(
      pitch: rawDataBank[0x06],
      position: rawDataBank[0x07],
      effectLevel: rawDataBank[0x08],
      directMix: rawDataBank[0x09]
    )
  }

  func buildPedalFxWah95Bank() -> PedalFxWah95Bank {
    let rawDataBank = self.pfxWahBank
    return PedalFxWah95Bank(
      pedalPosition: rawDataBank[0x0A],
      pedalMin: rawDataBank[0x0B],
      pedalMax: rawDataBank[0x0C],
      effectLevel: rawDataBank[0x0D],
      directMix: rawDataBank[0x0E]
    )
  }

  func buildPedalFxBank() -> PedalFxBank {
    let signalChainPedalFXBank = self.signalChainPedalFXBank
    return PedalFxBank(
      status: signalChainPedalFXBank[0x00] == 0x01,
      type: PedalFxType(rawValue: signalChainPedalFXBank[0x01]) ?? .wah,
      wah: buildPedalFxWahBank(),
      bend: buildPedalFxBendBank(),
      wah95: buildPedalFxWah95Bank()
    )
  }
}
