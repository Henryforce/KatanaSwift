import KatanaGoData

extension SoloParameter {
  var address: [UInt8] {
    switch self {
    case .enable: return [0x20, 0x01, 0x50, 0x00]
    case .level: return [0x20, 0x01, 0x50, 0x01]
    case .eqPosition: return [0x20, 0x01, 0x60, 0x00]
    case .eqOffOn: return [0x20, 0x01, 0x60, 0x01]
    case .eqLowCut: return [0x20, 0x01, 0x60, 0x02]
    case .eqLowGain: return [0x20, 0x01, 0x60, 0x03]
    case .eqMidFreq: return [0x20, 0x01, 0x60, 0x04]
    case .eqMidQ: return [0x20, 0x01, 0x60, 0x05]
    case .eqMidGain: return [0x20, 0x01, 0x60, 0x06]
    case .eqHighCut: return [0x20, 0x01, 0x60, 0x07]
    case .eqHighGain: return [0x20, 0x01, 0x60, 0x08]
    case .eqLevel: return [0x20, 0x01, 0x60, 0x09]
    }
  }

  var values: [UInt8] {
    switch self {
    case .enable(let value):
      return [value ? 0x01 : 0x00]
    case .level(let value):
      return [value]
    case .eqPosition(let value):
      return [value.rawValue]
    case .eqOffOn(let value):
      return [value ? 0x01 : 0x00]
    case .eqLowCut(let value):
      return [value.rawValue]
    case .eqLowGain(let value):
      return [value]
    case .eqMidFreq(let value):
      return [value.rawValue]
    case .eqMidQ(let value):
      return [value.rawValue]
    case .eqMidGain(let value):
      return [value]
    case .eqHighCut(let value):
      return [value.rawValue]
    case .eqHighGain(let value):
      return [value]
    case .eqLevel(let value):
      return [value]
    }
  }
}

// | SOLO: Solo Sw | 20015000 |
// | SOLO: Solo Level | 20015001 |
// | SOLO EQ: Position | 20016000 |
// | SOLO EQ: Off/On | 20016001 |
// | SOLO EQ: Low Cut | 20016002 |
// | SOLO EQ: Low Gain | 20016003 |
// | SOLO EQ: Mid Freq | 20016004 |
// | SOLO EQ: Mid Q | 20016005 |
// | SOLO EQ: Mid Gain | 20016006 |
// | SOLO EQ: Hi Gain | 20016007 |
// | SOLO EQ: Hi Cut | 20016008 |
// | SOLO EQ: Level | 20016009 |
