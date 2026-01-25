import KatanaGoData
import KatanaFx
import KatanaEQ

// extension SoloParameter {
//   var address: [UInt8] {
//     switch self {
//     case .enable: return [0x20, 0x01, 0x50, 0x00]
//     case .level: return [0x20, 0x01, 0x50, 0x01]
//     case .eqPosition: return [0x20, 0x01, 0x60, 0x00]
//     case .eqOffOn: return [0x20, 0x01, 0x60, 0x01]
//     case .eqLowCut: return [0x20, 0x01, 0x60, 0x02]
//     case .eqLowGain: return [0x20, 0x01, 0x60, 0x03]
//     case .eqMidFreq: return [0x20, 0x01, 0x60, 0x04]
//     case .eqMidQ: return [0x20, 0x01, 0x60, 0x05]
//     case .eqMidGain: return [0x20, 0x01, 0x60, 0x06]
//     case .eqHighCut: return [0x20, 0x01, 0x60, 0x07]
//     case .eqHighGain: return [0x20, 0x01, 0x60, 0x08]
//     case .eqLevel: return [0x20, 0x01, 0x60, 0x09]
//     }
//   }

//   var values: [UInt8] {
//     switch self {
//     case .enable(let value): return [value ? 0x01 : 0x00]
//     case .level(let value): return [value]
//     case .eqPosition(let value): return [value.rawValue]
//     case .eqOffOn(let value): return [value ? 0x01 : 0x00]
//     case .eqLowCut(let value): return [value.rawValue]
//     case .eqLowGain(let value): return [value]
//     case .eqMidFreq(let value): return [value.rawValue]
//     case .eqMidQ(let value): return [value.rawValue]
//     case .eqMidGain(let value): return [value]
//     case .eqHighCut(let value): return [value.rawValue]
//     case .eqHighGain(let value): return [value]
//     case .eqLevel(let value): return [value]
//     }
//   }
// }

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
