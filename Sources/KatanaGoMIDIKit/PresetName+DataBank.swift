import Foundation
import KatanaGoData

extension DataBank {
  func buildPresetName() -> String {
    let nameData = presetNameBank.suffix(16)
    return String(bytes: nameData.filter { $0 != 0 }, encoding: .ascii)?.trimmingCharacters(
      in: .whitespacesAndNewlines) ?? ""
  }
}
