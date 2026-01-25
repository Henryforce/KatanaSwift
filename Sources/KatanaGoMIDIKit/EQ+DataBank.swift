import KatanaCore
import KatanaEQ
import KatanaFx
import KatanaGoData

extension DataBank {
  func buildEQ1SelectionBank() -> EQSelectionBank {
    return buildEQSelectionBank(
      status: self.eq1SelectionBank[0x01] == 1,
      position: EQPosition(rawValue: self.eq1SelectionBank[0x00]) ?? .ampIn,
      type: EQType(rawValue: self.eq1SelectionBank[0x02]) ?? .parametric
    )
  }

  func buildEQ2SelectionBank() -> EQSelectionBank {
    return buildEQSelectionBank(
      status: self.eq2SelectionBank[0x01] == 1,
      position: EQPosition(rawValue: self.eq2SelectionBank[0x00]) ?? .ampIn,
      type: EQType(rawValue: self.eq2SelectionBank[0x02]) ?? .parametric
    )
  }

  func buildParametricEQ1Bank() -> ParametricEQBank {
    return buildParametricEQBank(bank: self.peq1Bank)
  }

  func buildParametricEQ2Bank() -> ParametricEQBank {
    return buildParametricEQBank(bank: self.peq2Bank)
  }

  func buildGraphicEQ1Bank() -> GraphicEQBank {
    return buildGraphicEQBank(bank: self.geq1Bank)
  }

  func buildGraphicEQ2Bank() -> GraphicEQBank {
    return buildGraphicEQBank(bank: self.geq2Bank)
  }

  private func buildParametricEQBank(bank: [UInt8]) -> ParametricEQBank {
    return ParametricEQBank(
      lowCut: EQLowCut(rawValue: bank[0x00]) ?? .flat,
      lowGain: bank[0x01],
      lowMidFreq: EQFrequency(rawValue: bank[0x02]) ?? .freq20Hz,
      lowMidQ: EQQ(rawValue: bank[0x03]) ?? .q05,
      lowMidGain: bank[0x04],
      highMidFreq: EQFrequency(rawValue: bank[0x05]) ?? .freq20Hz,
      highMidQ: EQQ(rawValue: bank[0x06]) ?? .q05,
      highMidGain: bank[0x07],
      highGain: bank[0x08],
      highCut: EQHighCut(rawValue: bank[0x09]) ?? .freq630Hz,
      level: bank[0x0A]
    )
  }

  private func buildGraphicEQBank(bank: [UInt8]) -> GraphicEQBank {
    return GraphicEQBank(
      band31Hz: bank[0x00],
      band62Hz: bank[0x01],
      band125Hz: bank[0x02],
      band250Hz: bank[0x03],
      band500Hz: bank[0x04],
      band1kHz: bank[0x05],
      band2kHz: bank[0x06],
      band4kHz: bank[0x07],
      band8kHz: bank[0x08],
      band16kHz: bank[0x09],
      level: bank[0x0A]
    )
  }

  private func buildEQSelectionBank(status: Bool, position: EQPosition, type: EQType)
    -> EQSelectionBank
  {
    return EQSelectionBank(
      status: status,
      position: position,
      type: type
    )
  }
}
