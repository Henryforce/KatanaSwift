import Foundation

/// Data received from the Katana GO device.
public enum KatanaGoReadData: Sendable {
  // MARK: - Status Updates

  /// Occurs when a pedal switch state changes.
  case pedalSwitchChanged(PedalSwitch, value: Int)

  /// Occurs when the expression pedal position changes.
  case expressionPedalChanged(value: Int)

  /// Occurs when an effect block state is updated.
  case effectChanged(EffectID, on: Bool)

  /// Occurs when the tuner is toggled.
  case tunerChanged(on: Bool)

  /// Occurs when the active preset changes.
  case presetChanged(index: Int)

  // MARK: - Raw Data

  /// Fallback for raw MIDI commands or unhandled data.
  case midiCommand(command: UInt8, data: [UInt8])
}
