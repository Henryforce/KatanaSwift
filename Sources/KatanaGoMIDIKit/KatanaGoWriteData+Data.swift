import Foundation
import KatanaGoData

extension KatanaGoWriteData {
  /// The raw MIDI bytes for the command.
  public var bytes: [UInt8] {
    switch self {
    case .pedalSwitch(let sw, let value):
      // CC command: 0xB0 <CC#> <Value>
      return [0xB0, UInt8(sw.rawValue), UInt8(value)]

    case .expressionPedal(let value):
      // Expression pedal is usually CC 11 or similar, but here we use CC 11
      return [0xB0, 11, UInt8(value)]

    case .volume(let value):
      return finalizeSysex(address: [0x20, 0x00, 0x20, 0x01], data: [UInt8(value & 0x7F)])

    case .system(let param, let value):
      return finalizeSysex(address: param.address, data: [UInt8(value & 0x7F)])

    case .amp(let param, let value):
      return finalizeSysex(address: param.address, data: [UInt8(value & 0x7F)])

    case .setEffectOn(let effect, let on):
      let val: UInt8 = on ? 1 : 0
      return finalizeSysex(address: effect.toggleAddress, data: [val])

    case .boost(let param, let value):
      return finalizeSysex(address: param.address, data: [UInt8(value & 0x7F)])

    case .mod(let param, let value):
      return encodeModFX(base: [0x60, 0x00, 0x01, 0x40], param: param, value: value)

    case .fx(let param, let value):
      return encodeModFX(base: [0x60, 0x00, 0x03, 0x4C], param: param, value: value)

    case .delay(let param, let value):
      if param == .time {
        return finalizeSysex(address: param.address, data: encode11Bit(value))
      } else {
        return finalizeSysex(address: param.address, data: [UInt8(value & 0x7F)])
      }

    case .reverb(let param, let value):
      if param == .preDelay {
        return finalizeSysex(address: param.address, data: encode11Bit(value))  // Pre-delay is 9-bit, encode11Bit works
      } else {
        return finalizeSysex(address: param.address, data: [UInt8(value & 0x7F)])
      }

    case .noiseGate(let param, let value):
      return finalizeSysex(address: param.address, data: [UInt8(value & 0x7F)])

    case .setTuner(let on):
      let val: UInt8 = on ? 1 : 0
      return finalizeSysex(address: [0x7F, 0x00, 0x00, 0x02], data: [val])

    case .changePreset(let preset):
      return preset.bytes

    case .setChain(let value):
      return finalizeSysex(address: [0x60, 0x00, 0x12, 0x00], data: [UInt8(value & 0x7F)])
    }
  }

  // MARK: - Helpers

  private func finalizeSysex(address: [UInt8], data: [UInt8]) -> [UInt8] {
    let prefix: [UInt8] = [0xf0, 0x41, 0x10, 0x01, 0x05, 0x0d, 0x12]
    let body = address + data
    let checksum = calculateChecksum(for: body)
    return prefix + body + [checksum, 0xf7]
  }

  private func calculateChecksum(for data: [UInt8]) -> UInt8 {
    var sum: Int = 0
    for byte in data {
      sum += Int(byte)
    }
    return UInt8((128 - (sum % 128)) % 128)
  }

  private func encode11Bit(_ value: Int) -> [UInt8] {
    let hh = UInt8((value >> 7) & 0x7F)
    let ll = UInt8(value & 0x7F)
    return [hh, ll]
  }

  private func encodeModFX(base: [UInt8], param: ModFXParameter, value: Int) -> [UInt8] {
    switch param {
    case .type:
      let addr = addOffset(to: base, offset: 1)
      return finalizeSysex(address: addr, data: [UInt8(value & 0x7F)])
    case .parameter(let offset):
      let addr = addOffset(to: base, offset: offset)
      return finalizeSysex(address: addr, data: [UInt8(value & 0x7F)])
    }
  }

  private func addOffset(to address: [UInt8], offset: Int) -> [UInt8] {
    // Boss addresses are 4 bytes, each 7-bit.
    var val =
      (Int(address[0]) << 21) | (Int(address[1]) << 14) | (Int(address[2]) << 7) | Int(address[3])
    val += offset
    return [
      UInt8((val >> 21) & 0x7F),
      UInt8((val >> 14) & 0x7F),
      UInt8((val >> 7) & 0x7F),
      UInt8(val & 0x7F),
    ]
  }
}

// MARK: - Address Mappings

extension SystemParameter {
  var address: [UInt8] {
    switch self {
    case .midiChannel: return [0x00, 0x02, 0x00, 0x00]
    case .toEffectLevel: return [0x00, 0x00, 0x00, 0x51]
    case .effectOutLevel: return [0x00, 0x00, 0x00, 0x52]
    case .mixLevel: return [0x00, 0x00, 0x00, 0x53]
    case .loopBack: return [0x00, 0x00, 0x00, 0x56]
    case .dryOutLevel: return [0x00, 0x00, 0x00, 0x57]
    }
  }
}

extension AmpParameter {
  var address: [UInt8] {
    switch self {
    case .loopActive: return [0x00, 0x00, 0x04, 0x00]
    case .routingScheme: return [0x00, 0x00, 0x04, 0x01]
    case .sendLevel: return [0x00, 0x00, 0x04, 0x02]
    case .returnLevel: return [0x00, 0x00, 0x04, 0x03]
    case .ampType: return [0x00, 0x00, 0x04, 0x20]
    case .gain: return [0x00, 0x00, 0x04, 0x21]
    case .volume: return [0x00, 0x00, 0x04, 0x22]
    case .bass: return [0x00, 0x00, 0x04, 0x23]
    case .middle: return [0x00, 0x00, 0x04, 0x24]
    case .treble: return [0x00, 0x00, 0x04, 0x25]
    case .presence: return [0x00, 0x00, 0x04, 0x26]
    }
  }
}

extension BoostParameter {
  var address: [UInt8] {
    let base: [UInt8] = [0x60, 0x00, 0x00, 0x31]  // Type address
    switch self {
    case .type: return base
    case .drive: return [base[0], base[1], base[2], base[3] + 1]
    case .bottom: return [base[0], base[1], base[2], base[3] + 2]
    case .tone: return [base[0], base[1], base[2], base[3] + 3]
    case .soloSwitch: return [base[0], base[1], base[2], base[3] + 4]
    case .soloLevel: return [base[0], base[1], base[2], base[3] + 5]
    case .effectLevel: return [base[0], base[1], base[2], base[3] + 6]
    case .directMix: return [base[0], base[1], base[2], base[3] + 7]
    }
  }
}

extension DelayParameter {
  var address: [UInt8] {
    switch self {
    case .time: return [0x60, 0x00, 0x05, 0x62]
    case .feedback: return [0x60, 0x00, 0x05, 0x64]
    case .highCut: return [0x60, 0x00, 0x05, 0x65]
    case .effectLevel: return [0x60, 0x00, 0x05, 0x66]
    case .directMix: return [0x60, 0x00, 0x05, 0x67]
    }
  }
}

extension ReverbParameter {
  var address: [UInt8] {
    switch self {
    case .type: return [0x60, 0x00, 0x06, 0x11]
    case .time: return [0x60, 0x00, 0x06, 0x12]
    case .preDelay: return [0x60, 0x00, 0x06, 0x13]
    case .lowCut: return [0x60, 0x00, 0x06, 0x15]
    case .highCut: return [0x60, 0x00, 0x06, 0x16]
    case .density: return [0x60, 0x00, 0x06, 0x17]
    case .effectLevel: return [0x60, 0x00, 0x06, 0x18]
    case .directMix: return [0x60, 0x00, 0x06, 0x19]
    case .springSensitivity: return [0x60, 0x00, 0x06, 0x1A]
    }
  }
}

extension NoiseGateParameter {
  var address: [UInt8] {
    switch self {
    case .on: return [0x60, 0x00, 0x06, 0x63]
    case .threshold: return [0x60, 0x00, 0x06, 0x64]
    case .release: return [0x60, 0x00, 0x06, 0x65]
    }
  }
}

extension EffectID {
  var toggleAddress: [UInt8] {
    switch self {
    case .boost: return [0x60, 0x00, 0x00, 0x30]
    case .mod: return [0x60, 0x00, 0x01, 0x40]
    case .fx: return [0x60, 0x00, 0x03, 0x4C]
    case .delay: return [0x60, 0x00, 0x05, 0x60]
    case .reverb: return [0x60, 0x00, 0x06, 0x10]
    case .pedalFX: return [0x60, 0x00, 0x01, 0x5C]  // Pedal Wah start
    case .solo: return [0x60, 0x00, 0x00, 0x35]  // Boost Solo
    case .eq: return [0x60, 0x00, 0x01, 0x70]  // Graphic EQ Mod start
    case .noiseGate: return [0x60, 0x00, 0x06, 0x63]
    }
  }
}
