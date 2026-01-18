import KatanaGoData

extension BoostParameter {
  var address: [UInt8] {
    switch self {
    case .enable: return [0x20, 0x00, 0x30, 0x00]
    case .type: return [0x20, 0x00, 0x40, 0x00]
    case .drive: return [0x20, 0x00, 0x40, 0x01]
    case .bottom: return [0x20, 0x00, 0x40, 0x02]
    case .tone: return [0x20, 0x00, 0x40, 0x03]
    case .soloSwitchEnable: return [0x20, 0x00, 0x40, 0x04]
    case .soloLevel: return [0x20, 0x00, 0x40, 0x05]
    case .effectLevel: return [0x20, 0x00, 0x40, 0x06]
    case .directMix: return [0x20, 0x00, 0x40, 0x07]
    }
  }

  var values: [UInt8] {
    switch self {
    case .enable(let value): return [value ? 1 : 0]
    case .type(let type): return [type.rawValue]
    case .drive(let value): return [value & 0x7F]
    case .bottom(let value): return [value & 0x7F]
    case .tone(let value): return [value & 0x7F]
    case .soloSwitchEnable(let value): return [value ? 1 : 0]
    case .soloLevel(let value): return [value & 0x7F]
    case .effectLevel(let value): return [value & 0x7F]
    case .directMix(let value): return [value & 0x7F]
    }
  }
}
