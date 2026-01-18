import KatanaGoData

extension AmpParameter {
  var address: [UInt8] {
    switch self {
    case .ampType: return [0x20, 0x00, 0x20, 0x0c]
    case .gain: return [0x20, 0x00, 0x20, 0x00]
    case .volume: return [0x20, 0x00, 0x20, 0x01]
    case .bass: return [0x20, 0x00, 0x20, 0x03]
    case .middle: return [0x20, 0x00, 0x20, 0x04]
    case .treble: return [0x20, 0x00, 0x20, 0x05]
    case .presence: return [0x20, 0x00, 0x20, 0x0a]
    case .variation: return [0x20, 0x00, 0x20, 0x0d]
    }
  }

  var values: [UInt8] {
    switch self {
    case .ampType(let type): return [type.rawValue]
    case .gain(let value), .volume(let value), .bass(let value), .middle(let value),
      .treble(let value), .presence(let value):
      return [value]
    case .variation(let value): return [value ? 0x01 : 0x00]
    }
  }
}
