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

  /// Updates the global volume.
  case volume(value: Int)

  /// Updates a system parameter.
  case system(SystemParameter, value: Int)

  /// Updates an amplifier parameter.
  case amp(AmpParameter, value: Int)

  /// Toggles an effect block on or off.
  case setEffectOn(EffectID, on: Bool)

  /// Updates a booster parameter.
  case boost(BoostParameter, value: Int)

  /// Updates a modulation parameter.
  case mod(ModFXParameter, value: Int)

  /// Updates an FX parameter.
  case fx(ModFXParameter, value: Int)

  /// Updates a delay parameter.
  case delay(DelayParameter, value: Int)

  /// Updates a reverb parameter.
  case reverb(ReverbParameter, value: Int)

  /// Updates a noise gate parameter.
  case noiseGate(NoiseGateParameter, value: Int)

  /// Toggles the tuner on or off.
  case setTuner(on: Bool)

  /// Switches the device to a specific preset.
  case changePreset(_ preset: KatanaGoPreset)

  /// Updates the signal chain.
  case setChain(Int)
}
