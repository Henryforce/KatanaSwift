import Foundation
import KatanaFx

public struct KatanaGoReadOptions: OptionSet, Sendable, Hashable {
  public let rawValue: Int

  public static let mode = KatanaGoReadOptions(rawValue: 1 << 0)
  public static let preset = KatanaGoReadOptions(rawValue: 1 << 1)
  public static let presetName = KatanaGoReadOptions(rawValue: 1 << 2)
  public static let signalChain = KatanaGoReadOptions(rawValue: 1 << 3)
  public static let effectStatus = KatanaGoReadOptions(rawValue: 1 << 4)
  public static let amp = KatanaGoReadOptions(rawValue: 1 << 5)
  public static let bassAmp = KatanaGoReadOptions(rawValue: 1 << 6)
  public static let boost = KatanaGoReadOptions(rawValue: 1 << 7)
  public static let bass = KatanaGoReadOptions(rawValue: 1 << 8)
  public static let modSelection = KatanaGoReadOptions(rawValue: 1 << 9)
  public static let mod = KatanaGoReadOptions(rawValue: 1 << 10)
  public static let fxSelection = KatanaGoReadOptions(rawValue: 1 << 11)
  public static let fx = KatanaGoReadOptions(rawValue: 1 << 12)
  public static let delay1 = KatanaGoReadOptions(rawValue: 1 << 13)
  public static let delay2 = KatanaGoReadOptions(rawValue: 1 << 14)
  public static let reverb = KatanaGoReadOptions(rawValue: 1 << 15)
  public static let soloSwitchLevel = KatanaGoReadOptions(rawValue: 1 << 16)
  public static let solo = KatanaGoReadOptions(rawValue: 1 << 17)
  public static let contour = KatanaGoReadOptions(rawValue: 1 << 18)
  public static let pedalFx = KatanaGoReadOptions(rawValue: 1 << 19)
  public static let eq1Selection = KatanaGoReadOptions(rawValue: 1 << 20)
  public static let eq1Parametric = KatanaGoReadOptions(rawValue: 1 << 21)
  public static let eq1Graphic = KatanaGoReadOptions(rawValue: 1 << 22)
  public static let eq2Selection = KatanaGoReadOptions(rawValue: 1 << 23)
  public static let eq2Parametric = KatanaGoReadOptions(rawValue: 1 << 24)
  public static let eq2Graphic = KatanaGoReadOptions(rawValue: 1 << 25)
  public static let noiseGate = KatanaGoReadOptions(rawValue: 1 << 26)

  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
}

/// Data received/sent from the Katana GO device.
public enum KatanaGoDataBank: Sendable {
  case modeBank(ModeBank)
  case preset(Preset)
  case presetName(String)
  case signalChainBank(SignalChainBank)
  case effectStatusBank(EffectStatusBank)
  case ampBank(AmpBank)
  case bassAmpBank(BassAmpBank)
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
  case soloSwitchLevelBank(SoloSwitchLevelBank)
  case soloBank(SoloBank)
  case contourBank(ContourBank)
  case pedalFxBank(PedalFxBank)
  case pedalFxSingleEffect(PedalFxReadData)
  case eq1SelectionBank(EQSelectionBank)
  case eq1ParametricBank(ParametricEQBank)
  case eq1GraphicBank(GraphicEQBank)
  case eq2SelectionBank(EQSelectionBank)
  case eq2ParametricBank(ParametricEQBank)
  case eq2GraphicBank(GraphicEQBank)
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

public enum PedalFxReadData: Sendable, Hashable {
  case wah(PedalFxWahBank)
  case bend(PedalFxBendBank)
  case wah95(PedalFxWah95Bank)
}
