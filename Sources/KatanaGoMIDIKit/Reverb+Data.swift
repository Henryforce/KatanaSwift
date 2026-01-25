import KatanaGoData
import KatanaFx

extension ReverbParameter {
  var address: [UInt8] {
    switch self {
    case .enable: return [0x20, 0x00, 0x30, 0x05]
    case .type: return [0x20, 0x01, 0x40, 0x00]
    case .time: return [0x20, 0x01, 0x40, 0x02]
    case .preDelay: return [0x20, 0x01, 0x40, 0x03]
    case .lowCut: return [0x20, 0x01, 0x40, 0x07]
    case .highCut: return [0x20, 0x01, 0x40, 0x08]
    case .density: return [0x20, 0x01, 0x40, 0x09]
    case .effectLevel: return [0x20, 0x01, 0x40, 0x0a]
    case .directMix: return [0x20, 0x01, 0x40, 0x0b]
    case .springSensitivity: return [0x20, 0x01, 0x40, 0x0c]
    }
  }

  var values: [UInt8] {
    switch self {
    case .enable(let value): return [value ? 0x01 : 0x00]
    case .type(let value): return [value.rawValue]
    case .time(let value): return [value]
    case .preDelay(let value): return value.encodeToByteArray()
    case .lowCut(let value): return [value.rawValue]
    case .highCut(let value): return [value.rawValue]
    case .density(let value): return [value]
    case .effectLevel(let value): return [value]
    case .directMix(let value): return [value]
    case .springSensitivity(let value): return [value]
    }
  }
}

extension DataBank {
  func buildReverbBank() -> ReverbBank {
    return ReverbBank(
      status: self.effectsOnOffBank[5] == 1,
      type: ReverbType(rawValue: reverbBank[0x00]) ?? .room,
      time: reverbBank[0x02],
      preDelay: UInt16.decodeFromByteArray([
        reverbBank[0x03], reverbBank[0x04], reverbBank[0x05], reverbBank[0x06],
      ]),
      lowCut: EQLowCut(rawValue: reverbBank[0x07]) ?? .flat,
      highCut: EQHighCut(rawValue: reverbBank[0x08]) ?? .freq630Hz,
      density: reverbBank[0x09],
      effectLevel: reverbBank[0x0A],
      directMix: reverbBank[0x0B],
      springSensitivity: reverbBank[0x0C]
    )
  }
}
