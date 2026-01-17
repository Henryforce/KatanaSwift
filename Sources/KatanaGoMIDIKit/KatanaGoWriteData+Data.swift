import Foundation
import KatanaGoData

extension KatanaGoWriteData {
  /// The raw MIDI bytes for the command.
  public var bytes: [UInt8] {
    switch self {

    case .system(let param, let value):
      return finalizeSysex(address: param.address, data: [UInt8(value & 0x7F)])

    case .amp(let param):
      // TODO: implement
      let value = param.value & 0x7F
      return finalizeSysex(address: param.address, data: [value])

    case .boost(let param):
      return finalizeSysex(address: param.address, data: [param.value])

    case .delay(let param):
      return finalizeSysex(address: param.address, data: param.values)

    case .reverb(let param, let value):
      if param == .preDelay {
        return finalizeSysex(address: param.address, data: encode11Bit(value))  // Pre-delay is 9-bit, encode11Bit works
      } else {
        return finalizeSysex(address: param.address, data: [UInt8(value & 0x7F)])
      }

    case .noiseGate(let param, let value):
      return finalizeSysex(address: param.address, data: [UInt8(value & 0x7F)])

    case .changePreset(let preset):
      return preset.bytes
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

extension NoiseGateParameter {
  var address: [UInt8] {
    switch self {
    case .on: return [0x20, 0x03, 0x30, 0x00]
    case .threshold: return [0x20, 0x03, 0x30, 0x01]
    case .release: return [0x20, 0x03, 0x30, 0x02]
    }
  }
}

extension UInt16 {
  func encode11Bit() -> [UInt8] {
    let hh = UInt8((self >> 7) & 0x7F)
    let ll = UInt8(self & 0x7F)
    return [hh, ll]
  }
}