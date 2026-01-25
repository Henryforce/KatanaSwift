import KatanaGoData

extension DataBank {
  func buildContourBank() -> ContourBank {
    let rawDataBank = self.contourBank
    return ContourBank(
      type: ContourType(rawValue: rawDataBank[0x00]) ?? .off,
      frequencyShift: rawDataBank[0x01]
    )
  }
}
