import KatanaFx

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
  case selectPreset(Preset)

  /// Writes the current preset to the device.
  case writePreset(Preset)
}
