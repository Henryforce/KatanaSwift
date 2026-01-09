import Foundation

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

  /// Switches the device to a specific preset index.
  case changePreset(index: Int)
}
