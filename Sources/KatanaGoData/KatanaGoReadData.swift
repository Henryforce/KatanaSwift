import Foundation
import KatanaFx

public struct KatanaGoReadOptions: OptionSet, Sendable, Hashable {
  public let rawValue: Int

  public static let preset = KatanaGoReadOptions(rawValue: 1 << 0)
  public static let amp = KatanaGoReadOptions(rawValue: 1 << 1)
  public static let boost = KatanaGoReadOptions(rawValue: 1 << 2)
  public static let bass = KatanaGoReadOptions(rawValue: 1 << 3)
  public static let modSelection = KatanaGoReadOptions(rawValue: 1 << 4)
  public static let fxSelection = KatanaGoReadOptions(rawValue: 1 << 5)
  public static let delay1 = KatanaGoReadOptions(rawValue: 1 << 6)
  public static let delay2 = KatanaGoReadOptions(rawValue: 1 << 7)
  public static let reverb = KatanaGoReadOptions(rawValue: 1 << 8)
  public static let solo = KatanaGoReadOptions(rawValue: 1 << 9)
  public static let contour = KatanaGoReadOptions(rawValue: 1 << 10)
  public static let pedalFx = KatanaGoReadOptions(rawValue: 1 << 11)
  public static let eq1 = KatanaGoReadOptions(rawValue: 1 << 12)
  public static let eq2 = KatanaGoReadOptions(rawValue: 1 << 13)
  public static let noiseGate = KatanaGoReadOptions(rawValue: 1 << 14)

  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
}

/// Data received from the Katana GO device.
public enum KatanaGoReadData: Sendable {
  case preset(Preset)
  case ampBank(AmpBank)
  case boostBank(BoostBank)
  case bassBank(BassCompLimBank)
  case modSelectionBank(ModSelectionBank)
  case modSingleEffect(KatanaGoFxReadData)
  case modAllEffects(ModFxBank)
  case fxSelectionBank(FxSelectionBank)
  case fxSingleEffect(KatanaGoFxReadData)
  case fxAllEffects(ModFxBank)
  case delay1Bank(DelayBank)
  case delay2Bank(DelayBank)
  case reverbBank(ReverbBank)
  case soloBank(SoloBank)
  case contourBank(ContourBank)
  case eq1Bank(EQBank)
  case eq2Bank(EQBank)
  case noiseGateBank(NoiseGateBank)
}

public enum KatanaGoFxReadData: Sendable, Hashable {
  case chorus(ChorusBank)
  case flanger(FlangerBank)
  case phaser(PhaserBank)
  case univibe(UniVibeBank)
  case tremolo(TremoloBank)
  case vibrato(VibratoBank)
  case rotary(RotaryBank)
  case ringMod(RingModBank)
  case slowGear(SlowGearBank)
  case slicer(SlicerBank)
  case comp(CompBank)
  case tWah(TWahBank)
  case autoWah(AutoWahBank)
  case modFxGraphicEQ(ModFxGraphicEQBank)
  case modFxParametricEQ(ModFxParametricEQBank)
  case guitarSim(GuitarSimBank)
  case acSim(ACSimBank)
  case acousticPro(AcousticProBank)
  case waveSynth(WaveSynthBank)
  case octaver(OctaverBank)
  case heavyOctave(HeavyOctaveBank)
  case pitchShifter(PitchShifterBank)
  case harmonist(HarmonistBank)
  case phase90(Phaser90EBank)
  case flanger117E(Flanger117EBank)
  case dc30(DC30Bank)
}
