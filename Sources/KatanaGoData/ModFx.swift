public enum ModFxParameter: Sendable {
  case enable(Bool)
  case type(ModFxType)
  case chorus(ChorusParameter)
  case flanger(FlangerParameter)
  case phaser(PhaserParameter)
  case uniVibe(UniVibeParameter)
  case tremolo(TremoloParameter)
  case vibrato(VibratoParameter)
  case rotary(RotaryParameter)
  case ringMod(RingModParameter)
  case slowGear(SlowGearParameter)
  case slicer(SlicerParameter)
  case comp(CompParameter)
  case limiter(LimiterParameter)
  case tWah(TWahParameter)
  case autoWah(AutoWahParameter)
  case graphicEQ(ModFxGraphicEQParameter)
  case parametricEQ(ModFxParametricEQParameter)
  case guitarSim(GuitarSimParameter)
  case acSim(ACSimParameter)
  case acousticPro(AcousticProParameter)
  case waveSynth(WaveSynthParameter)
  case octaver(OctaverParameter)
  case heavyOctave(HeavyOctaveParameter)
  case pitchShifter(PitchShifterParameter)
  case harmonist(HarmonistParameter)
  case humanizer(HumanizerParameter)
  case phaser90E(Phaser90EParameter)
  case flanger117E(Flanger117EParameter)
  case dc30(DC30Parameter)
}

// TODO: manual QA these types.
/// Available MOD types for the Katana GO.
public enum ModFxType: UInt8, Sendable, CaseIterable {
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

public enum ChorusParameter: Sendable {
  case crossoverFrequency(UInt8)
  case lowRate(UInt8)
  case lowDepth(UInt8)
  /// Low pre-delay, range between 0 and 40ms with 0.5ms steps mapped to 0..80.
  case lowPreDelay(UInt8)
  case lowLevel(UInt8)
  case highRate(UInt8)
  case highDepth(UInt8)
  /// High pre-delay, range between 0 and 40ms with 0.5ms steps mapped to 0..80.
  case highPreDelay(UInt8)
  case highLevel(UInt8)
  case directMix(UInt8)
}

public enum FlangerParameter: Sendable {
  case rate(UInt8)
  case depth(UInt8)
  case manual(UInt8)
  case resonance(UInt8)
  case lowCut(FlangerLowCut)
  case effectLevel(UInt8)
  case directLevel(UInt8)
}

public enum FlangerLowCut: UInt8, Sendable, CaseIterable {
  case flat = 0x00
  case freq55Hz = 0x01
  case freq110Hz = 0x02
  case freq165Hz = 0x03
  case freq200Hz = 0x04
  case freq280Hz = 0x05
  case freq340Hz = 0x06
  case freq400Hz = 0x07
  case freq500Hz = 0x08
  case freq630Hz = 0x09
  case freq800Hz = 0x0A
}

public enum PhaserParameter: Sendable {
  case type(PhaserType)
  case rate(UInt8)
  case depth(UInt8)
  case manual(UInt8)
  case resonance(UInt8)
  case stepRate(UInt8)
  case effectLevel(UInt8)
  case directLevel(UInt8)
}

public enum PhaserType: UInt8, Sendable, CaseIterable {
  case fourStage = 0x00
  case eightStage = 0x01
  case twelveStage = 0x02
  case biStage = 0x03
}

public enum UniVibeParameter: Sendable {
  case rate(UInt8)
  case depth(UInt8)
  case level(UInt8)
}

public enum TremoloParameter: Sendable {
  case waveShape(UInt8)
  case rate(UInt8)
  case depth(UInt8)
  case level(UInt8)
}

public enum VibratoParameter: Sendable {
  case rate(UInt8)
  case depth(UInt8)
  case level(UInt8)
}

public enum RotaryParameter: Sendable {
  case rate(UInt8)
  case depth(UInt8)
  case level(UInt8)
}

public enum RingModParameter: Sendable {
  case mode(RingModMode)
  case frequency(UInt8)
  case effectLevel(UInt8)
  case directMix(UInt8)
}

public enum RingModMode: UInt8, Sendable, CaseIterable {
  case normal = 0x00
  case intelligent = 0x01
}

public enum SlowGearParameter: Sendable {
  case sens(UInt8)
  case riseTime(UInt8)
  case level(UInt8)
}

public enum SlicerParameter: Sendable {
  /// Starts from 0 to 19 where 0 is Pattern 1 and 19 is Pattern 20.
  case pattern(UInt8)
  case rate(UInt8)
  case triggerSens(UInt8)
  case effectLevel(UInt8)
  case directMix(UInt8)
}

public enum CompParameter: Sendable {
  case type(CompType)
  case sustain(UInt8)
  case attack(UInt8)
  case tone(UInt8)
  case level(UInt8)
}

public enum CompType: UInt8, Sendable, CaseIterable {
  case boss = 0x00
  case hiBand = 0x01
  case light = 0x02
  case dComp = 0x03
  case orange = 0x04
  case fat = 0x05
  case mild = 0x06
}

public enum LimiterParameter: Sendable {
  case type(LimiterType)
  case attack(UInt8)
  case threshold(UInt8)
  case ratio(LimiterRatio)
  case release(UInt8)
  case level(UInt8)
}

public enum LimiterType: UInt8, Sendable, CaseIterable {
  case boss = 0x00
  case rack160D = 0x01
  case vtgRackU = 0x02
}

public enum LimiterRatio: UInt8, Sendable, CaseIterable {
  case oneToOne = 0x00
  case oneDotTwoToOne = 0x01
  case oneDotFourToOne = 0x02
  case oneDotSixToOne = 0x03
  case oneDotEightToOne = 0x04
  case twoToOne = 0x05
  case twoDotThreeToOne = 0x06
  case twoDotSixToOne = 0x07
  case threeToOne = 0x08
  case threeDotFiveToOne = 0x09
  case fourToOne = 0x0A
  case fiveToOne = 0x0B
  case sixToOne = 0x0C
  case eightToOne = 0x0D
  case tenToOne = 0x0E
  case twelveToOne = 0x0F
  case twentyToOne = 0x10
  case infiniteToOne = 0x11
}

public enum TWahParameter: Sendable {
  case mode(WahMode)
  case polarity(TWahPolarity)
  case sens(UInt8)
  case frequency(UInt8)
  case peak(UInt8)
  case effectLevel(UInt8)
  case directLevel(UInt8)
}

public enum WahMode: UInt8, Sendable, CaseIterable {
  case lowPassFilter = 0x00
  case highPassFilter = 0x01
}

public enum TWahPolarity: UInt8, Sendable, CaseIterable {
  case down = 0x00
  case up = 0x01
}

public enum AutoWahParameter: Sendable {
  case mode(WahMode)
  case frequency(UInt8)
  case peak(UInt8)
  case rate(UInt8)
  case depth(UInt8)
  case effectLevel(UInt8)
  case directLevel(UInt8)
}

public enum ModFxGraphicEQParameter: Sendable {
  /// Range is from -20 to 20 mapped to 0..40.
  case band31Hz(UInt8)
  case band62Hz(UInt8)
  case band125Hz(UInt8)
  case band250Hz(UInt8)
  case band500Hz(UInt8)
  case band1kHz(UInt8)
  case band2kHz(UInt8)
  case band4kHz(UInt8)
  case band8kHz(UInt8)
  case band16kHz(UInt8)
  case level(UInt8)
}

public enum ModFxParametricEQParameter: Sendable {
  case lowCut(EQLowCut)
  /// Range is from -20 to 20 mapped to 0..40.
  case lowGain(UInt8)
  case lowMidFreq(EQFrequency)
  case lowMidQ(EQQ)
  /// Range is from -20 to 20 mapped to 0..40.
  case lowMidGain(UInt8)
  case highMidFreq(EQFrequency)
  case highMidQ(EQQ)
  /// Range is from -20 to 20 mapped to 0..40.
  case highMidGain(UInt8)
  /// Range is from -20 to 20 mapped to 0..40.
  case highGain(UInt8)
  case highCut(EQHighCut)
  /// Range is from -20 to 20 mapped to 0..40.
  case level(UInt8)
}

public enum GuitarSimParameter: Sendable {
  case type(GuitarSimType)
  /// Range is from -50 to 50 mapped to 0..100.
  case low(UInt8)
  /// Range is from -50 to 50 mapped to 0..100.
  case high(UInt8)
  case body(UInt8)
  case level(UInt8)
}

public enum GuitarSimType: UInt8, Sendable, CaseIterable {
  case sToH = 0x00
  case hToS = 0x01
  case hToHF = 0x02
  case sToHollow = 0x03
  case hToHollow = 0x04
  case sToAc = 0x05
  case hToAc = 0x06
  case pToAc = 0x07
}

public enum ACSimParameter: Sendable {
  /// Range is from -50 to 50 mapped to 0..100.
  case high(UInt8)
  case body(UInt8)
  /// Range is from -50 to 50 mapped to 0..100.
  case low(UInt8)
  case level(UInt8)
}

public enum AcousticProParameter: Sendable {
  case type(AcousticProType)
  /// Range is from -50 to 50 mapped to 0..100.
  case bass(UInt8)
  /// Range is from -50 to 50 mapped to 0..100.
  case middle(UInt8)
  case midFrequency(AcousticProMidFrequency)
  /// Range is from -50 to 50 mapped to 0..100.
  case treble(UInt8)
  /// Range is from -50 to 50 mapped to 0..100.
  case presence(UInt8)
  case level(UInt8)
}

public enum AcousticProType: UInt8, Sendable, CaseIterable {
  case small = 0x00
  case medium = 0x01
  case bright = 0x02
  case power = 0x03
}

public enum AcousticProMidFrequency: UInt8, Sendable, CaseIterable {
  case freq20Hz = 0x00
  case freq25Hz = 0x01
  case freq31Hz5 = 0x02
  case freq40Hz = 0x03
  case freq50Hz = 0x04
  case freq63Hz = 0x05
  case freq80Hz = 0x06
  case freq100Hz = 0x07
  case freq125Hz = 0x08
  case freq160Hz = 0x09
  case freq200Hz = 0x0A
  case freq250Hz = 0x0B
  case freq315Hz = 0x0C
  case freq400Hz = 0x0D
  case freq500Hz = 0x0E
  case freq630Hz = 0x0F
  case freq800Hz = 0x10
  case freq1kHz = 0x11
  case freq1k25Hz = 0x12
  case freq1k6Hz = 0x13
  case freq2kHz = 0x14
  case freq2k5Hz = 0x15
  case freq3k15Hz = 0x16
  case freq4kHz = 0x17
  case freq5kHz = 0x18
  case freq6k3Hz = 0x19
  case freq8kHz = 0x1A
  case freq10kHz = 0x1B
}

public enum WaveSynthParameter: Sendable {
  case type(WaveSynthType)
  case cutoff(UInt8)
  case resonance(UInt8)
  case filterSens(UInt8)
  case filterDecay(UInt8)
  case filterDepth(UInt8)
  case synthLevel(UInt8)
  case directMix(UInt8)
}

public enum WaveSynthType: UInt8, Sendable, CaseIterable {
  case saw = 0x00
  case square = 0x01
}

public enum OctaverParameter: Sendable {
  case range(OctaverRange)
  case level(UInt8)
  case directLevel(UInt8)
}

public enum OctaverRange: UInt8, Sendable, CaseIterable {
  case range1 = 0x00
  case range2 = 0x01
  case range3 = 0x02
  case range4 = 0x03
}

public enum HeavyOctaveParameter: Sendable {
  case octaveMinus1(UInt8)
  case octaveMinus2(UInt8)
  case directMix(UInt8)
}

public enum PitchShifterParameter: Sendable {
  case voice(PitchShifterVoice)
  case ps1Mode(PitchShifterMode)
  /// Range is from -50 to 50 mapped to 0..100.
  case ps1Pitch(UInt8)
  /// Range is from -50 to 50 mapped to 0..100.
  case ps1Fine(UInt8)
  /// Range is from 0 to 300.
  case ps1PreDelay(UInt16)
  case ps1Level(UInt8)
  case ps2Mode(PitchShifterMode)
  /// Range is from -50 to 50 mapped to 0..100.
  case ps2Pitch(UInt8)
  /// Range is from -50 to 50 mapped to 0..100.
  case ps2Fine(UInt8)
  /// Range is from 0 to 300.
  case ps2PreDelay(UInt16)
  case ps2Level(UInt8)
  case ps1Feedback(UInt8)
  case directLevel(UInt8)
}

public enum PitchShifterVoice: UInt8, Sendable, CaseIterable {
  case oneVoice = 0x00
  case twoVoice = 0x01
}

public enum PitchShifterMode: UInt8, Sendable, CaseIterable {
  case fast = 0x00
  case medium = 0x01
  case slow = 0x02
  case mono = 0x03
}

// TODO: Finish updating this enum.
public enum HarmonistParameter: Sendable {
  case voice(HarmonistVoice)
  case h1Harmony(UInt8)
  case h1PreDelay(UInt16)
  case h1Level(UInt8)
  case h2Harmony(UInt8)
  case h2PreDelay(UInt16)
  case h2Level(UInt8)
  case h1Feedback(UInt8)
  case directLevel(UInt8)
}

public enum HarmonistVoice: UInt8, Sendable, CaseIterable {
  case oneVoice = 0x00
  case twoVoice = 0x01
}

public enum HumanizerParameter: Sendable {
  case mode(HumanizerMode)
  case vowel1(HumanizerWovel)
  case vowel2(HumanizerWovel)
  case sens(UInt8)
  case rate(UInt8)
  case depth(UInt8)
  case manual(UInt8)
  case level(UInt8)
}

public enum HumanizerMode: UInt8, Sendable, CaseIterable {
  case picking = 0x00
  case auto = 0x01
}

public enum HumanizerWovel: UInt8, Sendable, CaseIterable {
  case a = 0x00
  case e = 0x01
  case i = 0x02
  case o = 0x03
  case u = 0x04
}

public enum Phaser90EParameter: Sendable {
  case scriptEnable(Bool)
  case speed(UInt8)
}

public enum Flanger117EParameter: Sendable {
  case manual(UInt8)
  case width(UInt8)
  case speed(UInt8)
  case regen(UInt8)
}

public enum DC30Parameter: Sendable {
  case type(DC30Type)
  case inputVolume(UInt8)
  case intensity(UInt8)
  case repeatTime(UInt16)
  case volume(UInt8)
  case tone(UInt8)
  case outputType(DC30OutputType)
}

public enum DC30Type: UInt8, Sendable, CaseIterable {
  case chorus = 0x00
  case echo = 0x01
}

public enum DC30OutputType: UInt8, Sendable, CaseIterable {
  case dPlusE = 0x00
  case dOverE = 0x01
}
