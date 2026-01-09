import Foundation

/// Defines the various pedal switches available on the Katana GO (or external controllers).
public enum PedalSwitch: Int, Sendable {
  /// Left pedal switch (CC 80)
  case switch1 = 80
  /// Center pedal switch (CC 81)
  case switch2 = 81
  /// Right pedal switch (CC 82)
  case switch3 = 83
  /// Control switch 1 (CC 85)
  case control1 = 85
  /// Control switch 2 (CC 86)
  case control2 = 86
}

/// Identifiers for the verschiedenen effect blocks in the Katana GO chain.
public enum EffectID: Sendable {
  case boost
  case mod
  case fx
  case delay
  case reverb
  case pedalFX
  case solo
  case eq
}
