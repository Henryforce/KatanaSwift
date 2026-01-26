import KatanaGoData

extension DataBank {
  func buildDelay1Bank() -> DelayBank {
    return buildDelayBank(rawDataBank: self.delay1Bank)
  }

  func buildDelay2Bank() -> DelayBank {
    return buildDelayBank(rawDataBank: self.delay2Bank)
  }

  private func buildDelayBank(rawDataBank: [UInt8]) -> DelayBank {
    return DelayBank(
      type: DelayType(rawValue: rawDataBank[0x00]) ?? .digital,
      time: UInt16.decodeFromByteArray([
        rawDataBank[0x01], rawDataBank[0x02], rawDataBank[0x03], rawDataBank[0x04],
      ]),
      feedback: rawDataBank[0x05],
      highCut: DelayHighCutFrequency(rawValue: rawDataBank[0x06]) ?? .flat,
      effectLevel: rawDataBank[0x07],
      directMix: rawDataBank[0x08],
      modulationRate: rawDataBank[0x0A],
      modulationDepth: rawDataBank[0x0B],
      modulationSwitchStatus: rawDataBank[0x10] == 1,
      tapTimePercentage: rawDataBank[0x09],
      filterStatus: rawDataBank[0x0C] == 1,
      filter: DelayFilterRange(rawValue: rawDataBank[0x0D]) ?? .freq8kHz,
      delayPhase: DelayPhase(rawValue: rawDataBank[0x0F]) ?? .normal,
      feedbackPhase: DelayPhase(rawValue: rawDataBank[0x0E]) ?? .normal
    )
  }
}
