import KatanaCore
import KatanaEQ
import KatanaFx
import KatanaGoData

extension DataBank {
  func buildEQ1Bank() -> EQBank {
    return buildEQBank(
      status: self.eq1Bank[0x01] == 1,
      position: EQPosition(rawValue: self.eq1Bank[0x00]) ?? .ampIn,
      type: EQType(rawValue: self.eq1Bank[0x02]) ?? .parametric,
      peqBank: self.peq1Bank,
      geqBank: self.geq1Bank
    )
  }

  func buildEQ2Bank() -> EQBank {
    return buildEQBank(
      status: self.eq2Bank[0x01] == 1,
      position: EQPosition(rawValue: self.eq2Bank[0x00]) ?? .ampIn,
      type: EQType(rawValue: self.eq2Bank[0x02]) ?? .parametric,
      peqBank: self.peq2Bank,
      geqBank: self.geq2Bank
    )
  }

  private func buildEQBank(
    status: Bool, position: EQPosition, type: EQType, peqBank: [UInt8], geqBank: [UInt8]
  ) -> EQBank {
    return EQBank(
      status: status,
      position: position,
      type: type,
      parametric: ParametricEQBank(
        lowCut: EQLowCut(rawValue: peqBank[0x00]) ?? .flat,
        lowGain: peqBank[0x01],
        lowMidFreq: EQFrequency(rawValue: peqBank[0x02]) ?? .freq20Hz,
        lowMidQ: EQQ(rawValue: peqBank[0x03]) ?? .q05,
        lowMidGain: peqBank[0x04],
        highMidFreq: EQFrequency(rawValue: peqBank[0x05]) ?? .freq20Hz,
        highMidQ: EQQ(rawValue: peqBank[0x06]) ?? .q05,
        highMidGain: peqBank[0x07],
        highGain: peqBank[0x08],
        highCut: EQHighCut(rawValue: peqBank[0x09]) ?? .freq630Hz,
        level: peqBank[0x0A]
      ),
      graphic: GraphicEQBank(
        band31Hz: geqBank[0x00],
        band62Hz: geqBank[0x01],
        band125Hz: geqBank[0x02],
        band250Hz: geqBank[0x03],
        band500Hz: geqBank[0x04],
        band1kHz: geqBank[0x05],
        band2kHz: geqBank[0x06],
        band4kHz: geqBank[0x07],
        band8kHz: geqBank[0x08],
        band16kHz: geqBank[0x09],
        level: geqBank[0x0A]
      )
    )
  }
}
