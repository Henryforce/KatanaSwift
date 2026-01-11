import Foundation
import KatanaGoData

extension KatanaGoPreset {
  var data: Data {
    return Data(bytes)
  }

  private var bytes: [UInt8] {
    switch self {
    case .preset1A:
      return [
        0xb9, 0xba, 0xf0, 0x41, 0x10, 0x01, 0x05, 0x0d,
        0x12, 0x7f, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00,
        0xba, 0xf7,
      ]
    case .preset1B: return [0x01]
    case .preset1C:
      return [
        0xba, 0x96, 0xf0, 0x41, 0x10, 0x01, 0x05, 0x0d,
        0x12, 0x7f, 0x00, 0x01, 0x00, 0x00, 0x02, 0x7e,
        0x96, 0xf7,
      ]
    case .preset2A: return [0x03]
    case .preset2B: return [0x04]
    case .preset2C: return [0x05]
    case .preset3A:
      return [
        0xb4, 0xc7, 0xf0, 0x41, 0x10, 0x01, 0x05, 0x0d,
        0x12, 0x7f, 0x00, 0x01, 0x00, 0x00, 0x06, 0x7a,
        0xc7, 0xf7,
      ]
    case .preset3B: return [0x07]
    case .preset3C: return [0x08]
    case .preset4A: return [0x09]
    case .preset4B: return [0x0A]
    case .preset4C: return [0x0B]
    case .preset5A: return [0x0C]
    case .preset5B: return [0x0D]
    case .preset5C: return [0x0E]
    case .preset6A: return [0x0F]
    case .preset6B: return [0x10]
    case .preset6C: return [0x11]
    case .preset7A: return [0x12]
    case .preset7B: return [0x13]
    case .preset7C: return [0x14]
    case .preset8A: return [0x15]
    case .preset8B: return [0x16]
    case .preset8C: return [0x17]
    case .preset9A: return [0x18]
    case .preset9B: return [0x19]
    case .preset9C: return [0x1A]
    case .preset10A: return [0x1B]
    case .preset10B: return [0x1C]
    case .preset10C: return [0x1D]
    case .preset11A: return [0x1E]
    case .preset11B: return [0x1F]
    case .preset11C: return [0x20]
    case .preset12A: return [0x21]
    case .preset12B: return [0x22]
    case .preset12C: return [0x23]
    }
  }
}
