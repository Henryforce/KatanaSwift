import KatanaGoData

// extension AmpParameter {
//   var address: [UInt8] {
//     switch self {
//     case .ampType: return [0x20, 0x00, 0x20, 0x0C]
//     case .gain: return [0x20, 0x00, 0x20, 0x00]
//     case .volume: return [0x20, 0x00, 0x20, 0x01]
//     case .bass: return [0x20, 0x00, 0x20, 0x03]
//     case .middle: return [0x20, 0x00, 0x20, 0x04]
//     case .treble: return [0x20, 0x00, 0x20, 0x05]
//     case .presence: return [0x20, 0x00, 0x20, 0x0A]
//     case .variation: return [0x20, 0x00, 0x20, 0x0D]
//     }
//   }

//   var values: [UInt8] {
//     switch self {
//     case .ampType(let type): return [type.rawValue]
//     case .gain(let value): return [value & 0x7F]
//     case .volume(let value): return [value & 0x7F]
//     case .bass(let value): return [value & 0x7F]
//     case .middle(let value): return [value & 0x7F]
//     case .treble(let value): return [value & 0x7F]
//     case .presence(let value): return [value & 0x7F]
//     case .variation(let value): return [value ? 0x01 : 0x00]
//     }
//   }
// }

extension DataBank {
  func buildAmpBank() -> AmpBank {
    let rawDataBank = self.preampBank
    return AmpBank(
      type: AmpType(rawValue: rawDataBank[0x0C]) ?? .clean,
      gain: rawDataBank[0x00],
      volume: rawDataBank[0x01],
      bass: rawDataBank[0x03],
      middle: rawDataBank[0x04],
      treble: rawDataBank[0x05],
      presence: rawDataBank[0x0A],
      variation: rawDataBank[0x0D] == 1
    )
  }
}
