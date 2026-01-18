import Foundation
import KatanaGoData

extension KatanaGoWriteData {
  /// The raw MIDI bytes for the command.
  public var bytes: [UInt8] {
    switch self {

    case .amp(let param):
      // TODO: implement
      let value = param.value & 0x7F
      return finalizeSysex(address: param.address, data: [value])

    case .boost(let param):
      return finalizeSysex(address: param.address, data: [param.value])

    case .mod(let param):
      return finalizeSysex(address: param.address, data: param.values)

    case .fx(let param):
      // Offset the address as it has a different register space as Mod but the same structure.
      var address = param.address
      if case .enable = param {
        // Offset the address by 0x01 as it has a different register space as Mod but the same
        // structure.
        address[3] += 0x01
      } else {
        // Offset the address by 0x10 as it has a different register space as Mod but the same
        // structure.
        address[2] += 0x10
      }
      return finalizeSysex(address: address, data: param.values)

    case .delay1(let param):
      return finalizeSysex(address: param.address(isDelay2: false), data: param.values)

    case .delay2(let param):
      return finalizeSysex(address: param.address(isDelay2: true), data: param.values)

    case .reverb(let param):
      return finalizeSysex(address: param.address, data: param.values)

    case .solo(let param):
      return finalizeSysex(address: param.address, data: param.values)

    case .eq1(let param):
      return finalizeSysex(address: param.address(isEQ2: false), data: param.values)

    case .eq2(let param):
      return finalizeSysex(address: param.address(isEQ2: true), data: param.values)

    case .noiseGate(let param):
      return finalizeSysex(address: param.address, data: param.values)

    case .selectPreset(let preset):
      return finalizeSysex(address: [0x7f, 0x00, 0x01, 0x00], data: [0x00, preset.rawValue])

    case .writePreset(let preset):
      // NOTE: If the write preset does not work, remove the last byte from the data.
      return finalizeSysex(address: [0x7f, 0x00, 0x01, 0x04], data: [0x00, preset.rawValue, 0x00])
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
}

extension UInt16 {
  func encode11Bit() -> [UInt8] {
    let hh = UInt8((self >> 7) & 0x7F)
    let ll = UInt8(self & 0x7F)
    return [hh, ll]
  }
}
