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
  case ampType(AmpType)
  case gain(UInt8)
  case volume(UInt8)
  case bass(UInt8)
  case middle(UInt8)
  case treble(UInt8)
  case presence(UInt8)
}

/// Available amplifier types for the Katana GO.
public enum AmpType: UInt8, Sendable, CaseIterable {
  case naturalClean = 0x00
  case acoustic = 0x01
  case comboCrunch = 0x02
  case stackCrunch = 0x03
  case hiGainStack = 0x04
  case powerDrive = 0x05
  case extremeLead = 0x06
  case coreMetal = 0x07
  case clean = 0x08
  case cleanTwin = 0x09
  case proCrunch = 0x0A
  case crunch = 0x0B
  case deluxeCrunch = 0x0C
  case voDrive = 0x0D
  case voLead = 0x0E
  case matchDrive = 0x0F
  case bgLead = 0x10
  case bgDrive = 0x11
  case ms1959I = 0x12
  case ms1959IPlusII = 0x13
  case rFierVintage = 0x14
  case rFierModern = 0x15
  case tAmpLead = 0x16
  case brown = 0x17
  case lead = 0x18
  case custom = 0x19
}

/// Parameters for the Booster effect.
public enum BoostParameter: Sendable {
  case enable(Bool)
  case type(BoostType)
  case drive(UInt8)
  case bottom(UInt8)
  case tone(UInt8)
  case soloSwitchEnable(Bool)
  case soloLevel(UInt8)
  case effectLevel(UInt8)
  case directMix(UInt8)
}

/// Available booster types for the Katana GO.
public enum BoostType: UInt8, Sendable, CaseIterable {
  case midBoost = 0x00
  case cleanBoost = 0x01
  case trebleBoost = 0x02
  case crunch = 0x03
  case naturalOD = 0x04
  case warmOD = 0x05
  case fatDS = 0x06
  case leadDS = 0x07
  case metalDS = 0x08
  case octFuzz = 0x09
  case bluesOD = 0x0A
  case od1 = 0x0B
  case tubescreamer = 0x0C
  case turboOD = 0x0D
  case dist = 0x0E
  case rat = 0x0F
  case guVDS = 0x10
  case dstPlus = 0x11
  case metalZone = 0x12
  case sixtiesFuzz = 0x13
  case muffFuzz = 0x14
  case custom = 0x15
}

/// Available booster types for the Katana GO in Bass Mode.
public enum BassBoostType: UInt8, Sendable, CaseIterable {
  case bluesOD = 0x00
  case natural = 0x01
  case guVDS = 0x02
  case metalZone = 0x03
  case muffFuzz = 0x04
  case booster = 0x05
  case bassOD = 0x06
  case bassDS = 0x08
  case bassMT = 0x09
  case bassFuzz = 0x0A
  case bassDrv = 0x0B
  case hiBandDrv = 0x0C
  case bassDI = 0x0D
}

/// Common parameters for Mod and FX blocks when they are set to specific effect types.
public enum ModFXParameter: Sendable {
  case type
  case parameter(Int)  // Offset from the start of the effect block parameters (e.g. 0x0C for Mode in T-Wah)
}

/// Available MOD/FX types for the Katana GO.
public enum ModFXType: UInt8, Sendable, CaseIterable {
  case tWah = 0x00
  case autoWah = 0x01
  case wah = 0x02
  case compressor = 0x03
  case limiter = 0x04
  case graphicEQ = 0x06
  case paraEQ = 0x07
  case guitarSim = 0x09
  case slowGear = 0x0A
  case waveSynth = 0x0C
  case octave = 0x0E
  case pitchShifter = 0x0F
  case harmonist = 0x10
  case acProcessor = 0x12
  case phaser = 0x13
  case flanger = 0x14
  case tremolo = 0x15
  case rotary = 0x16
  case uniV = 0x17
  case slicer = 0x19
  case vibrato = 0x1A
  case ringMod = 0x1B
  case humanizer = 0x1C
  case twoByTwoChorus = 0x1D
  case acGuitarSim = 0x1F
  case phaser90E = 0x23
  case flanger117E = 0x24
  case wah95E = 0x25
  case delayChorus30 = 0x26
  case heavyOctave = 0x27
}

/// Available MOD/FX types for the Katana GO in Bass Mode.
public enum BassModFXType: UInt8, Sendable, CaseIterable {
  case chorus = 0x00
  case flanger = 0x01
  case phaser = 0x02
  case uniV = 0x03
  case tremolo = 0x04
  case vibrato = 0x06
  case rotary = 0x07
  case ringMod = 0x09
  case slowGear = 0x0A
  case slicer = 0x0C
  case autoWah = 0x0E
  case graphicEQ = 0x0F
  case paraEQ = 0x10
  case heavyOctave = 0x12
  case pitchShifter = 0x13
  case harmonist = 0x14
  case humanizer = 0x15
  case enhancer = 0x16
  case bassSimulator = 0x17
  case defretter = 0x19
  case octave = 0x1A
  case tWah = 0x1B
  case bassSynth = 0x1C
}

/// Parameters for the Delay effect.
public enum DelayParameter: Sendable {
  case enable(Bool)
  case type(DelayType)
  case time(UInt16)
  case feedback(UInt8)
  case highCut(DelayHighCutFrequency)
  case effectLevel(UInt8)
  case directMix(UInt8)
  case modulationRate(UInt8)
  case modulationDepth(UInt8)
  case modulationSwitch(Bool)
  case tapTimePercentage(UInt8)
  case filterEnable(Bool)
  case filter(DelayFilterRange)
  case delayPhase(DelayPhase)
  case feedbackPhase(DelayPhase)
}

/// Available delay types for the Katana GO.
public enum DelayType: UInt8, Sendable, CaseIterable {
  case digital = 0x00
  case pan = 0x01
  case stereo = 0x02
  case reverse = 0x06
  case analog = 0x07
  case tapeEcho = 0x08
  case modulate = 0x09
  case sde3000 = 0x0A
}

public enum DelayHighCutFrequency: UInt8, Sendable, CaseIterable {
  case freq630Hz = 0x00
  case freq800Hz = 0x01
  case freq1kHz = 0x02
  case freq1k25Hz = 0x03
  case freq1k6Hz = 0x04
  case freq2kHz = 0x05
  case freq2k5Hz = 0x06
  case freq3k15Hz = 0x07
  case freq4kHz = 0x08
  case freq5kHz = 0x09
  case freq6k3Hz = 0x0A
  case freq8kHz = 0x0B
  case freq10kHz = 0x0C
  case freq12k5Hz = 0x0D
  case flat = 0x0E
}

public enum DelayFilterRange: UInt8, Sendable, CaseIterable {
  case freq8kHz = 0x00
  case freq17kHz = 0x01
}

public enum DelayPhase: UInt8, Sendable, CaseIterable {
  case normal = 0x00
  case inverted = 0x01
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
