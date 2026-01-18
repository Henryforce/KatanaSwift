import KatanaGoData

extension NoiseGateParameter {
  var address: [UInt8] {
    switch self {
    case .enable: return [0x20, 0x03, 0x30, 0x00]
    case .threshold: return [0x20, 0x03, 0x30, 0x01]
    case .release: return [0x20, 0x03, 0x30, 0x02]
    }
  }

  var values: [UInt8] {
    switch self {
    case .enable(let value): return [value ? 0x01 : 0x00]
    case .threshold(let value): return [value]
    case .release(let value): return [value]
    }
  }
}
