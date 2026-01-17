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

  /// Updates an amplifier parameter.
  case amp(AmpParameter)

  /// Updates a booster parameter.
  case boost(BoostParameter)

  /// Updates a modulation parameter.
  case mod(ModFxParameter)

  /// Updates an FX parameter.
  case fx(ModFxParameter)

  /// Updates the first delay parameter.
  case delay1(DelayParameter)

  /// Updates the second delay parameter.
  case delay2(DelayParameter)

  /// Updates a reverb parameter.
  case reverb(ReverbParameter)

  /// Updates a solo parameter.
  case solo(SoloParameter)

  /// Updates the first EQ parameter.
  case eq1(EQParameter)

  /// Updates the second EQ parameter.
  case eq2(EQParameter)

  /// Updates a noise gate parameter.
  case noiseGate(NoiseGateParameter)

  /// Switches the device to a specific preset.
  case changePreset(KatanaGoPreset)
}
