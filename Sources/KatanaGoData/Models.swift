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
public enum EffectID: Sendable, CaseIterable {
  case boost
  case mod
  case fx
  case delay
  case reverb
  case pedalFX
  case solo
  case eq
  case noiseGate
}

/// Parameters for System settings.
public enum SystemParameter: Sendable {
  case midiChannel
  case toEffectLevel
  case effectOutLevel
  case mixLevel
  case loopBack
  case dryOutLevel
}

/// Parameters for the Amplifier block and front panel.
public enum AmpParameter: Sendable {
  case loopActive
  case routingScheme
  case sendLevel
  case returnLevel
  case ampType
  case gain
  case volume
  case bass
  case middle
  case treble
  case presence
}

/// Parameters for the Booster effect.
public enum BoostParameter: Sendable {
  case type
  case drive
  case bottom
  case tone
  case soloSwitch
  case soloLevel
  case effectLevel
  case directMix
}

/// Common parameters for Mod and FX blocks when they are set to specific effect types.
public enum ModFXParameter: Sendable {
  case type
  case parameter(Int)  // Offset from the start of the effect block parameters (e.g. 0x0C for Mode in T-Wah)
}

/// Parameters for the Delay effect.
public enum DelayParameter: Sendable {
  case time
  case feedback
  case highCut
  case effectLevel
  case directMix
}

/// Parameters for the Reverb effect.
public enum ReverbParameter: Sendable {
  case type
  case time
  case preDelay
  case lowCut
  case highCut
  case density
  case effectLevel
  case directMix
  case springSensitivity
}

/// Parameters for the Noise Gate.
public enum NoiseGateParameter: Sendable {
  case on
  case threshold
  case release
}
