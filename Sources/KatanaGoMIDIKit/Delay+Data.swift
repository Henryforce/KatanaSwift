import KatanaGoData

extension DelayParameter {
  func address(isDelay2: Bool) -> [UInt8] {
    let enableAddressByte: UInt8 = isDelay2 ? 0x04 : 0x03
    let thirdAddressByte: UInt8 = isDelay2 ? 0x30 : 0x20
    switch self {
    case .enable: return [0x20, 0x00, 0x30, enableAddressByte]
    case .type: return [0x20, 0x01, thirdAddressByte, 0x00]
    case .time: return [0x20, 0x01, thirdAddressByte, 0x01]
    case .feedback: return [0x20, 0x01, thirdAddressByte, 0x05]
    case .highCut: return [0x20, 0x01, thirdAddressByte, 0x06]
    case .effectLevel: return [0x20, 0x01, thirdAddressByte, 0x07]
    case .directMix: return [0x20, 0x01, thirdAddressByte, 0x08]
    case .modulationRate: return [0x20, 0x01, thirdAddressByte, 0x0A]
    case .modulationDepth: return [0x20, 0x01, thirdAddressByte, 0x0B]
    case .modulationSwitch: return [0x20, 0x01, thirdAddressByte, 0x10]
    case .tapTimePercentage: return [0x20, 0x01, thirdAddressByte, 0x09]
    case .filterEnable: return [0x20, 0x01, thirdAddressByte, 0x0C]
    case .filter: return [0x20, 0x01, thirdAddressByte, 0x0D]
    case .delayPhase: return [0x20, 0x01, thirdAddressByte, 0x0F]
    case .feedbackPhase: return [0x20, 0x01, thirdAddressByte, 0x0E]
    }
  }

  var values: [UInt8] {
    switch self {
    case .enable(let value): return [value ? 1 : 0]
    case .type(let type): return [type.rawValue]
    case .time(let time): return time.encode11Bit()
    case .feedback(let value): return [value & 0x7F]
    case .highCut(let value): return [value.rawValue]
    case .effectLevel(let value): return [value & 0x7F]
    case .directMix(let value): return [value & 0x7F]
    case .modulationRate(let value): return [value & 0x7F]
    case .modulationDepth(let value): return [value & 0x7F]
    case .modulationSwitch(let value): return [value ? 1 : 0]
    case .tapTimePercentage(let value): return [value & 0x7F]
    case .filterEnable(let value): return [value ? 1 : 0]
    case .filter(let value): return [value.rawValue]
    case .delayPhase(let value): return [value.rawValue]
    case .feedbackPhase(let value): return [value.rawValue]
    }
  }
}
