import KatanaGoData

extension DataBank {
  func buildModeBank() -> ModeBank {
    let rawDataBank = modeBank
    return ModeBank(mode: KatanaGoMode(rawValue: rawDataBank[0x00]) ?? .guitar)
  }
}
