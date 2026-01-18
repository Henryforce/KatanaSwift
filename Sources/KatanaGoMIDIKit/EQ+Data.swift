import KatanaGoData

extension EQParameter {
  func address(isEQ2: Bool) -> [UInt8] {
    switch self {
    case .enable: return [0x20, 0x02, isEQ2 ? 0x70 : 0x60, 0x00]
    case .type: return [0x20, 0x02, isEQ2 ? 0x70 : 0x60, 0x02]
    case .parametric(let parameter): return parameter.address(isEQ2: isEQ2)
    case .graphic(let parameter): return parameter.address(isEQ2: isEQ2)
    }
  }

  var values: [UInt8] {
    switch self {
    case .enable(let value): return [value ? 0x01 : 0x00]
    case .type(let value): return [value.rawValue]
    case .parametric(let parameter): return parameter.values
    case .graphic(let parameter): return parameter.values
    }
  }
}

extension ParametricEQParameter {
  fileprivate func address(isEQ2: Bool) -> [UInt8] {
    // Offset the address by 0x10 as it has a different register space as EQ1 but the same
    // structure.
    let thirdByte: UInt8 = isEQ2 ? 0x10 : 0x00
    switch self {
    case .lowCut: return [0x20, 0x03, thirdByte, 0x00]
    case .lowGain: return [0x20, 0x03, thirdByte, 0x01]
    case .lowMidFreq: return [0x20, 0x03, thirdByte, 0x02]
    case .lowMidQ: return [0x20, 0x03, thirdByte, 0x03]
    case .lowMidGain: return [0x20, 0x03, thirdByte, 0x04]
    case .highMidFreq: return [0x20, 0x03, thirdByte, 0x05]
    case .highMidQ: return [0x20, 0x03, thirdByte, 0x06]
    case .highMidGain: return [0x20, 0x03, thirdByte, 0x07]
    case .highGain: return [0x20, 0x03, thirdByte, 0x08]
    case .highCut: return [0x20, 0x03, thirdByte, 0x09]
    case .level: return [0x20, 0x03, thirdByte, 0x0A]
    case .position: return [0x20, 0x03, thirdByte, 0x0B]
    }
  }

  fileprivate var values: [UInt8] {
    switch self {
    case .lowCut(let value): return [value.rawValue]
    case .lowGain(let value): return [value]
    case .lowMidFreq(let value): return [value.rawValue]
    case .lowMidQ(let value): return [value.rawValue]
    case .lowMidGain(let value): return [value]
    case .highMidFreq(let value): return [value.rawValue]
    case .highMidQ(let value): return [value.rawValue]
    case .highMidGain(let value): return [value]
    case .highGain(let value): return [value]
    case .highCut(let value): return [value.rawValue]
    case .level(let value): return [value]
    case .position(let value): return [value.rawValue]
    }
  }
}

extension GraphicEQParameter {
  fileprivate func address(isEQ2: Bool) -> [UInt8] {
    // Offset the address by 0x10 as it has a different register space as EQ1 but the same
    // structure.
    let thirdByte: UInt8 = isEQ2 ? 0x30 : 0x20
    switch self {
    case .band31Hz: return [0x20, 0x03, thirdByte, 0x00]
    case .band62Hz: return [0x20, 0x03, thirdByte, 0x01]
    case .band125Hz: return [0x20, 0x03, thirdByte, 0x02]
    case .band250Hz: return [0x20, 0x03, thirdByte, 0x03]
    case .band500Hz: return [0x20, 0x03, thirdByte, 0x04]
    case .band1kHz: return [0x20, 0x03, thirdByte, 0x05]
    case .band2kHz: return [0x20, 0x03, thirdByte, 0x06]
    case .band4kHz: return [0x20, 0x03, thirdByte, 0x07]
    case .band8kHz: return [0x20, 0x03, thirdByte, 0x08]
    case .band16kHz: return [0x20, 0x03, thirdByte, 0x09]
    case .level: return [0x20, 0x03, thirdByte, 0x0A]
    case .position: return [0x20, 0x03, thirdByte, 0x0B]
    }
  }

  fileprivate var values: [UInt8] {
    switch self {
    case .band31Hz(let value): return [value]
    case .band62Hz(let value): return [value]
    case .band125Hz(let value): return [value]
    case .band250Hz(let value): return [value]
    case .band500Hz(let value): return [value]
    case .band1kHz(let value): return [value]
    case .band2kHz(let value): return [value]
    case .band4kHz(let value): return [value]
    case .band8kHz(let value): return [value]
    case .band16kHz(let value): return [value]
    case .level(let value): return [value]
    case .position(let value): return [value.rawValue]
    }
  }
}
