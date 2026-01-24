import KatanaGoData
import KatanaCore
import KatanaFx

// extension EQParameter {
//   func address(isEQ2: Bool) -> [UInt8] {
//     switch self {
//     case .enable: return [0x20, 0x02, isEQ2 ? 0x70 : 0x60, 0x01]
//     case .position: return [0x20, 0x02, isEQ2 ? 0x70 : 0x60, 0x00]
//     case .type: return [0x20, 0x02, isEQ2 ? 0x70 : 0x60, 0x02]
//     case .parametric(let parameter): return parameter.address(isEQ2: isEQ2)
//     case .graphic(let parameter): return parameter.address(isEQ2: isEQ2)
//     }
//   }

//   var values: [UInt8] {
//     switch self {
//     case .enable(let value): return [value ? 0x01 : 0x00]
//     case .position(let value): return [value.rawValue]
//     case .type(let value): return [value.rawValue]
//     case .parametric(let parameter): return parameter.values
//     case .graphic(let parameter): return parameter.values
//     }
//   }
// }

// extension ParametricEQParameter {
//   fileprivate func address(isEQ2: Bool) -> [UInt8] {
//     // Offset the address by 0x10 as it has a different register space as EQ1 but the same
//     // structure.
//     let thirdByte: UInt8 = isEQ2 ? 0x10 : 0x00
//     switch self {
//     case .lowCut: return [0x20, 0x03, thirdByte, 0x00]
//     case .lowGain: return [0x20, 0x03, thirdByte, 0x01]
//     case .lowMidFreq: return [0x20, 0x03, thirdByte, 0x02]
//     case .lowMidQ: return [0x20, 0x03, thirdByte, 0x03]
//     case .lowMidGain: return [0x20, 0x03, thirdByte, 0x04]
//     case .highMidFreq: return [0x20, 0x03, thirdByte, 0x05]
//     case .highMidQ: return [0x20, 0x03, thirdByte, 0x06]
//     case .highMidGain: return [0x20, 0x03, thirdByte, 0x07]
//     case .highGain: return [0x20, 0x03, thirdByte, 0x08]
//     case .highCut: return [0x20, 0x03, thirdByte, 0x09]
//     case .level: return [0x20, 0x03, thirdByte, 0x0A]
//     }
//   }

//   fileprivate var values: [UInt8] {
//     switch self {
//     case .lowCut(let value): return [value.rawValue]
//     case .lowGain(let value): return [value & 0x7F]
//     case .lowMidFreq(let value): return [value.rawValue]
//     case .lowMidQ(let value): return [value.rawValue]
//     case .lowMidGain(let value): return [value & 0x7F]
//     case .highMidFreq(let value): return [value.rawValue]
//     case .highMidQ(let value): return [value.rawValue]
//     case .highMidGain(let value): return [value & 0x7F]
//     case .highGain(let value): return [value & 0x7F]
//     case .highCut(let value): return [value.rawValue]
//     case .level(let value): return [value & 0x7F]
//     }
//   }
// }

// extension GraphicEQParameter {
//   fileprivate func address(isEQ2: Bool) -> [UInt8] {
//     // Offset the address by 0x10 as it has a different register space as EQ1 but the same
//     // structure.
//     let thirdByte: UInt8 = isEQ2 ? 0x30 : 0x20
//     switch self {
//     case .band31Hz: return [0x20, 0x03, thirdByte, 0x00]
//     case .band62Hz: return [0x20, 0x03, thirdByte, 0x01]
//     case .band125Hz: return [0x20, 0x03, thirdByte, 0x02]
//     case .band250Hz: return [0x20, 0x03, thirdByte, 0x03]
//     case .band500Hz: return [0x20, 0x03, thirdByte, 0x04]
//     case .band1kHz: return [0x20, 0x03, thirdByte, 0x05]
//     case .band2kHz: return [0x20, 0x03, thirdByte, 0x06]
//     case .band4kHz: return [0x20, 0x03, thirdByte, 0x07]
//     case .band8kHz: return [0x20, 0x03, thirdByte, 0x08]
//     case .band16kHz: return [0x20, 0x03, thirdByte, 0x09]
//     case .level: return [0x20, 0x03, thirdByte, 0x0A]
//     }
//   }

//   fileprivate var values: [UInt8] {
//     switch self {
//     case .band31Hz(let value): return [value & 0x7F]
//     case .band62Hz(let value): return [value & 0x7F]
//     case .band125Hz(let value): return [value & 0x7F]
//     case .band250Hz(let value): return [value & 0x7F]
//     case .band500Hz(let value): return [value & 0x7F]
//     case .band1kHz(let value): return [value & 0x7F]
//     case .band2kHz(let value): return [value & 0x7F]
//     case .band4kHz(let value): return [value & 0x7F]
//     case .band8kHz(let value): return [value & 0x7F]
//     case .band16kHz(let value): return [value & 0x7F]
//     case .level(let value): return [value & 0x7F]
//     }
//   }
// }

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
