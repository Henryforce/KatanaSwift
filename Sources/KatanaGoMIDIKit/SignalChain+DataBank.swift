import KatanaGoData

extension DataBank {
  func buildSignalChainBank() -> SignalChainBank {
    return SignalChainBank(
      chain: Chain(rawValue: signalChainBank[0x00]) ?? .threeOne,
      resonance: CabinetResonance(rawValue: signalChainBank[0x01]) ?? .vintage
    )
  }
}
