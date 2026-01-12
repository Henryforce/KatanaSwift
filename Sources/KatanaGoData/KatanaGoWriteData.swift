import Foundation

/// Presets available on the Katana GO device.
public enum KatanaGoPreset: Sendable, Hashable, CaseIterable {
  case preset1A
  case preset1B
  case preset1C
  case preset2A
  case preset2B
  case preset2C
  case preset3A
  case preset3B
  case preset3C
  case preset4A
  case preset4B
  case preset4C
  case preset5A
  case preset5B
  case preset5C
  case preset6A
  case preset6B
  case preset6C
  case preset7A
  case preset7B
  case preset7C
  case preset8A
  case preset8B
  case preset8C
  case preset9A
  case preset9B
  case preset9C
  case preset10A
  case preset10B
  case preset10C
}

/// Commands sent to the Katana GO device.
public enum KatanaGoWriteData: Sendable {
  // MARK: - Control Change (CC)

  /// Updates the state of a pedal switch.
  case pedalSwitch(PedalSwitch, value: Int)

  /// Updates the expression pedal position (0-127).
  case expressionPedal(value: Int)

  // MARK: - SysEx Commands

  /// Toggles an effect block on or off.
  case setEffect(EffectID, on: Bool)

  /// Toggles the tuner on or off.
  case setTuner(on: Bool)

  /// Switches the device to a specific preset.
  case changePreset(_ preset: KatanaGoPreset)
}
