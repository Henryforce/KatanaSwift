public enum ModFxParameter: Sendable, Hashable {
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

/// The data bank representing the MOD/FX parameters.
public struct ModFxBank: Sendable, Hashable {
  @Parameter(at: 0x00_00_30_01)
  public var status: Bool = false

  @Parameter(at: 0x00_00_60_00)
  public var type: ModFxType = .chorus

  public var chorus: ChorusBank
  public var flanger: FlangerBank
  public var phaser: PhaserBank
  public var uniVibe: UniVibeBank
  public var tremolo: TremoloBank
  public var vibrato: VibratoBank
  public var rotary: RotaryBank
  public var ringMod: RingModBank
  public var slowGear: SlowGearBank
  public var slicer: SlicerBank
  public var comp: CompBank
  public var limiter: LimiterBank
  public var tWah: TWahBank
  public var autoWah: AutoWahBank
  public var graphicEQ: ModFxGraphicEQBank
  public var parametricEQ: ModFxParametricEQBank
  public var guitarSim: GuitarSimBank
  public var acSim: ACSimBank
  public var acousticPro: AcousticProBank
  public var waveSynth: WaveSynthBank
  public var octaver: OctaverBank
  public var heavyOctave: HeavyOctaveBank
  public var pitchShifter: PitchShifterBank
  public var harmonist: HarmonistBank
  public var humanizer: HumanizerBank
  public var phaser90E: Phaser90EBank
  public var flanger117E: Flanger117EBank
  public var dc30: DC30Bank

  public init(
    status: Bool, type: ModFxType, chorus: ChorusBank, flanger: FlangerBank, phaser: PhaserBank,
    uniVibe: UniVibeBank, tremolo: TremoloBank, vibrato: VibratoBank, rotary: RotaryBank,
    ringMod: RingModBank, slowGear: SlowGearBank, slicer: SlicerBank, comp: CompBank,
    limiter: LimiterBank, tWah: TWahBank, autoWah: AutoWahBank, graphicEQ: ModFxGraphicEQBank,
    parametricEQ: ModFxParametricEQBank, guitarSim: GuitarSimBank, acSim: ACSimBank,
    acousticPro: AcousticProBank, waveSynth: WaveSynthBank, octaver: OctaverBank,
    heavyOctave: HeavyOctaveBank, pitchShifter: PitchShifterBank, harmonist: HarmonistBank,
    humanizer: HumanizerBank, phaser90E: Phaser90EBank, flanger117E: Flanger117EBank, dc30: DC30Bank
  ) {
    self.status = status
    self.type = type
    self.chorus = chorus
    self.flanger = flanger
    self.phaser = phaser
    self.uniVibe = uniVibe
    self.tremolo = tremolo
    self.vibrato = vibrato
    self.rotary = rotary
    self.ringMod = ringMod
    self.slowGear = slowGear
    self.slicer = slicer
    self.comp = comp
    self.limiter = limiter
    self.tWah = tWah
    self.autoWah = autoWah
    self.graphicEQ = graphicEQ
    self.parametricEQ = parametricEQ
    self.guitarSim = guitarSim
    self.acSim = acSim
    self.acousticPro = acousticPro
    self.waveSynth = waveSynth
    self.octaver = octaver
    self.heavyOctave = heavyOctave
    self.pitchShifter = pitchShifter
    self.harmonist = harmonist
    self.humanizer = humanizer
    self.phaser90E = phaser90E
    self.flanger117E = flanger117E
    self.dc30 = dc30
  }
}

// TODO: re-audit these values.
/// Available MOD/FX types for the Katana GO.
public enum ModFxType: UInt8, Sendable, Hashable, CaseIterable {
  case chorus = 0x00
  case flanger = 0x01
  case phaser = 0x02
  case uniV = 0x03
  case tremolo = 0x04
  case vibrato = 0x05
  case rotary = 0x06
  case ringMod = 0x07
  case slowGear = 0x08
  case slicer = 0x09
  case comp = 0x0A
  case limiter = 0x0B
  case tWah = 0x0C
  case autoWah = 0x0D
  case graphicEQ = 0x0E
  case parametricEQ = 0x0F
  case guitarSim = 0x10
  case acSim = 0x11
  case acousticPro = 0x12
  case waveSynth = 0x13
  case octave = 0x14
  case heavyOctave = 0x15
  case pitchShifter = 0x16
  case harmonist = 0x17
  case humanizer = 0x18
  case phaser90E = 0x19
  case flanger117E = 0x1A
  case dc30 = 0x1B
}

// MARK: - Chorus

public enum ChorusParameter: Sendable, Hashable {
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

/// The data bank representing the chorus parameters.
public struct ChorusBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00_01_00_00, range: 0...100)
  public var crossoverFrequency: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_01, range: 0...100)
  public var lowRate: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_02, range: 0...100)
  public var lowDepth: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_03, range: 0...80)
  public var lowPreDelay: UInt8 = 0

  @IntegerParameter(at: 0x00_01_00_04, range: 0...100)
  public var lowLevel: UInt8 = 100

  @IntegerParameter(at: 0x00_01_00_05, range: 0...100)
  public var highRate: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_06, range: 0...100)
  public var highDepth: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_07, range: 0...80)
  public var highPreDelay: UInt8 = 0

  @IntegerParameter(at: 0x00_01_00_08, range: 0...100)
  public var highLevel: UInt8 = 100

  @IntegerParameter(at: 0x00_01_00_09, range: 0...100)
  public var directMix: UInt8 = 0

  public init(
    crossoverFrequency: UInt8, lowRate: UInt8, lowDepth: UInt8, lowPreDelay: UInt8, lowLevel: UInt8,
    highRate: UInt8, highDepth: UInt8, highPreDelay: UInt8, highLevel: UInt8, directMix: UInt8
  ) {
    self.crossoverFrequency = crossoverFrequency
    self.lowRate = lowRate
    self.lowDepth = lowDepth
    self.lowPreDelay = lowPreDelay
    self.lowLevel = lowLevel
    self.highRate = highRate
    self.highDepth = highDepth
    self.highPreDelay = highPreDelay
    self.highLevel = highLevel
    self.directMix = directMix
  }
}

// MARK: - Flanger

public enum FlangerParameter: Sendable, Hashable {
  case rate(UInt8)
  case depth(UInt8)
  case manual(UInt8)
  case resonance(UInt8)
  case lowCut(FlangerLowCut)
  case effectLevel(UInt8)
  case directLevel(UInt8)
}

/// The data bank representing the flanger parameters.
public struct FlangerBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00_01_00_0A, range: 0...100)
  public var rate: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_0B, range: 0...100)
  public var depth: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_0C, range: 0...100)
  public var manual: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_0D, range: 0...100)
  public var resonance: UInt8 = 50

  @Parameter(at: 0x00_01_00_0E)
  public var lowCut: FlangerLowCut = .flat

  @IntegerParameter(at: 0x00_01_00_0F, range: 0...100)
  public var effectLevel: UInt8 = 100

  @IntegerParameter(at: 0x00_01_00_10, range: 0...100)
  public var directLevel: UInt8 = 0

  public init(
    rate: UInt8, depth: UInt8, manual: UInt8, resonance: UInt8, lowCut: FlangerLowCut,
    effectLevel: UInt8, directLevel: UInt8
  ) {
    self.rate = rate
    self.depth = depth
    self.manual = manual
    self.resonance = resonance
    self.lowCut = lowCut
    self.effectLevel = effectLevel
    self.directLevel = directLevel
  }
}

public enum FlangerLowCut: UInt8, Sendable, Hashable, CaseIterable {
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

// MARK: - Phaser

public enum PhaserParameter: Sendable, Hashable {
  case type(PhaserType)
  case rate(UInt8)
  case depth(UInt8)
  case manual(UInt8)
  case resonance(UInt8)
  case stepRate(UInt8)
  case effectLevel(UInt8)
  case directLevel(UInt8)
}

/// The data bank representing the phaser parameters.
public struct PhaserBank: Sendable, Hashable {
  @Parameter(at: 0x00_01_00_11)
  public var type: PhaserType = .fourStage

  @IntegerParameter(at: 0x00_01_00_12, range: 0...100)
  public var rate: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_13, range: 0...100)
  public var depth: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_14, range: 0...100)
  public var manual: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_15, range: 0...100)
  public var resonance: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_16, range: 0...100)
  public var stepRate: UInt8 = 0

  @IntegerParameter(at: 0x00_01_00_17, range: 0...100)
  public var effectLevel: UInt8 = 100

  @IntegerParameter(at: 0x00_01_00_18, range: 0...100)
  public var directLevel: UInt8 = 0

  public init(
    type: PhaserType, rate: UInt8, depth: UInt8, manual: UInt8, resonance: UInt8, stepRate: UInt8,
    effectLevel: UInt8, directLevel: UInt8
  ) {
    self.type = type
    self.rate = rate
    self.depth = depth
    self.manual = manual
    self.resonance = resonance
    self.stepRate = stepRate
    self.effectLevel = effectLevel
    self.directLevel = directLevel
  }
}

public enum PhaserType: UInt8, Sendable, Hashable, CaseIterable {
  case fourStage = 0x00
  case eightStage = 0x01
  case twelveStage = 0x02
  case biStage = 0x03
}

// MARK: - UniVibe

public enum UniVibeParameter: Sendable, Hashable {
  case rate(UInt8)
  case depth(UInt8)
  case level(UInt8)
}

/// The data bank representing the univibe parameters.
public struct UniVibeBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00_01_00_19, range: 0...100)
  public var rate: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_1A, range: 0...100)
  public var depth: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_1B, range: 0...100)
  public var level: UInt8 = 100

  public init(rate: UInt8, depth: UInt8, level: UInt8) {
    self.rate = rate
    self.depth = depth
    self.level = level
  }
}

// MARK: - Tremolo

public enum TremoloParameter: Sendable, Hashable {
  case waveShape(UInt8)
  case rate(UInt8)
  case depth(UInt8)
  case level(UInt8)
}

/// The data bank representing the tremolo parameters.
public struct TremoloBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00_01_00_1C, range: 0...100)
  public var waveShape: UInt8 = 0

  @IntegerParameter(at: 0x00_01_00_1D, range: 0...100)
  public var rate: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_1E, range: 0...100)
  public var depth: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_1F, range: 0...100)
  public var level: UInt8 = 100

  public init(waveShape: UInt8, rate: UInt8, depth: UInt8, level: UInt8) {
    self.waveShape = waveShape
    self.rate = rate
    self.depth = depth
    self.level = level
  }
}

// MARK: - Vibrato

public enum VibratoParameter: Sendable, Hashable {
  case rate(UInt8)
  case depth(UInt8)
  case level(UInt8)
}

/// The data bank representing the vibrato parameters.
public struct VibratoBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00_01_00_20, range: 0...100)
  public var rate: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_21, range: 0...100)
  public var depth: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_22, range: 0...100)
  public var level: UInt8 = 100

  public init(rate: UInt8, depth: UInt8, level: UInt8) {
    self.rate = rate
    self.depth = depth
    self.level = level
  }
}

// MARK: - Rotary

public enum RotaryParameter: Sendable, Hashable {
  case rate(UInt8)
  case depth(UInt8)
  case level(UInt8)
}

/// The data bank representing the rotary parameters.
public struct RotaryBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00_01_00_23, range: 0...100)
  public var rate: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_24, range: 0...100)
  public var depth: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_25, range: 0...100)
  public var level: UInt8 = 100

  public init(rate: UInt8, depth: UInt8, level: UInt8) {
    self.rate = rate
    self.depth = depth
    self.level = level
  }
}

// MARK: - RingMod

public enum RingModParameter: Sendable, Hashable {
  case mode(RingModMode)
  case frequency(UInt8)
  case effectLevel(UInt8)
  case directMix(UInt8)
}

/// The data bank representing the ring modulator parameters.
public struct RingModBank: Sendable, Hashable {
  @Parameter(at: 0x00_01_00_26)
  public var mode: RingModMode = .normal

  @IntegerParameter(at: 0x00_01_00_27, range: 0...100)
  public var frequency: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_28, range: 0...100)
  public var effectLevel: UInt8 = 100

  @IntegerParameter(at: 0x00_01_00_29, range: 0...100)
  public var directMix: UInt8 = 0

  public init(mode: RingModMode, frequency: UInt8, effectLevel: UInt8, directMix: UInt8) {
    self.mode = mode
    self.frequency = frequency
    self.effectLevel = effectLevel
    self.directMix = directMix
  }
}

public enum RingModMode: UInt8, Sendable, Hashable, CaseIterable {
  case normal = 0x00
  case intelligent = 0x01
}

// MARK: - SlowGear

public enum SlowGearParameter: Sendable, Hashable {
  case sens(UInt8)
  case riseTime(UInt8)
  case level(UInt8)
}

/// The data bank representing the slow gear parameters.
public struct SlowGearBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00_01_00_2A, range: 0...100)
  public var sens: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_2B, range: 0...100)
  public var riseTime: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_2C, range: 0...100)
  public var level: UInt8 = 100

  public init(sens: UInt8, riseTime: UInt8, level: UInt8) {
    self.sens = sens
    self.riseTime = riseTime
    self.level = level
  }
}

// MARK: - Slicer

public enum SlicerParameter: Sendable, Hashable {
  /// Starts from 0 to 19 where 0 is Pattern 1 and 19 is Pattern 20.
  case pattern(UInt8)
  case rate(UInt8)
  case triggerSens(UInt8)
  case effectLevel(UInt8)
  case directMix(UInt8)
}

/// The data bank representing the slicer parameters.
public struct SlicerBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00_01_00_2D, range: 0...19)
  public var pattern: UInt8 = 0

  @IntegerParameter(at: 0x00_01_00_2E, range: 0...100)
  public var rate: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_2F, range: 0...100)
  public var triggerSens: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_30, range: 0...100)
  public var effectLevel: UInt8 = 100

  @IntegerParameter(at: 0x00_01_00_31, range: 0...100)
  public var directMix: UInt8 = 0

  public init(
    pattern: UInt8, rate: UInt8, triggerSens: UInt8, effectLevel: UInt8, directMix: UInt8
  ) {
    self.pattern = pattern
    self.rate = rate
    self.triggerSens = triggerSens
    self.effectLevel = effectLevel
    self.directMix = directMix
  }
}

// MARK: - Comp

public enum CompParameter: Sendable, Hashable {
  case type(CompType)
  case sustain(UInt8)
  case attack(UInt8)
  case tone(UInt8)
  case level(UInt8)
}

/// The data bank representing the compressor parameters.
public struct CompBank: Sendable, Hashable {
  @Parameter(at: 0x00_01_00_32)
  public var type: CompType = .boss

  @IntegerParameter(at: 0x00_01_00_33, range: 0...100)
  public var sustain: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_34, range: 0...100)
  public var attack: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_35, range: 0...100)
  public var tone: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_36, range: 0...100)
  public var level: UInt8 = 100

  public init(type: CompType, sustain: UInt8, attack: UInt8, tone: UInt8, level: UInt8) {
    self.type = type
    self.sustain = sustain
    self.attack = attack
    self.tone = tone
    self.level = level
  }
}

public enum CompType: UInt8, Sendable, Hashable, CaseIterable {
  case boss = 0x00
  case hiBand = 0x01
  case light = 0x02
  case dComp = 0x03
  case orange = 0x04
  case fat = 0x05
  case mild = 0x06
}

// MARK: - Limiter

public enum LimiterParameter: Sendable, Hashable {
  case type(LimiterType)
  case attack(UInt8)
  case threshold(UInt8)
  case ratio(LimiterRatio)
  case release(UInt8)
  case level(UInt8)
}

/// The data bank representing the limiter parameters.
public struct LimiterBank: Sendable, Hashable {
  @Parameter(at: 0x00_01_00_37)
  public var type: LimiterType = .boss

  @IntegerParameter(at: 0x00_01_00_38, range: 0...100)
  public var attack: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_39, range: 0...100)
  public var threshold: UInt8 = 50

  @Parameter(at: 0x00_01_00_3A)
  public var ratio: LimiterRatio = .twoToOne

  @IntegerParameter(at: 0x00_01_00_3B, range: 0...100)
  public var release: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_3C, range: 0...100)
  public var level: UInt8 = 100

  public init(
    type: LimiterType, attack: UInt8, threshold: UInt8, ratio: LimiterRatio, release: UInt8,
    level: UInt8
  ) {
    self.type = type
    self.attack = attack
    self.threshold = threshold
    self.ratio = ratio
    self.release = release
    self.level = level
  }
}

public enum LimiterType: UInt8, Sendable, Hashable, CaseIterable {
  case boss = 0x00
  case rack160D = 0x01
  case vtgRackU = 0x02
}

public enum LimiterRatio: UInt8, Sendable, Hashable, CaseIterable {
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

// MARK: - Wah

public enum WahMode: UInt8, Sendable, Hashable, CaseIterable {
  case lowPassFilter = 0x00
  case highPassFilter = 0x01
}

// MARK: - TWah

public enum TWahParameter: Sendable, Hashable {
  case mode(WahMode)
  case polarity(TWahPolarity)
  case sens(UInt8)
  case frequency(UInt8)
  case peak(UInt8)
  case effectLevel(UInt8)
  case directLevel(UInt8)
}

/// The data bank representing the T-Wah parameters.
public struct TWahBank: Sendable, Hashable {
  @Parameter(at: 0x00_01_00_3D)
  public var mode: WahMode = .lowPassFilter

  @Parameter(at: 0x00_01_00_3E)
  public var polarity: TWahPolarity = .up

  @IntegerParameter(at: 0x00_01_00_3F, range: 0...100)
  public var sens: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_40, range: 0...100)
  public var frequency: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_41, range: 0...100)
  public var peak: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_42, range: 0...100)
  public var effectLevel: UInt8 = 100

  @IntegerParameter(at: 0x00_01_00_43, range: 0...100)
  public var directLevel: UInt8 = 0

  public init(
    mode: WahMode, polarity: TWahPolarity, sens: UInt8, frequency: UInt8, peak: UInt8,
    effectLevel: UInt8, directLevel: UInt8
  ) {
    self.mode = mode
    self.polarity = polarity
    self.sens = sens
    self.frequency = frequency
    self.peak = peak
    self.effectLevel = effectLevel
    self.directLevel = directLevel
  }
}

public enum TWahPolarity: UInt8, Sendable, Hashable, CaseIterable {
  case down = 0x00
  case up = 0x01
}

// MARK: - AutoWah

public enum AutoWahParameter: Sendable, Hashable {
  case mode(WahMode)
  case frequency(UInt8)
  case peak(UInt8)
  case rate(UInt8)
  case depth(UInt8)
  case effectLevel(UInt8)
  case directLevel(UInt8)
}

/// The data bank representing the auto wah parameters.
public struct AutoWahBank: Sendable, Hashable {
  @Parameter(at: 0x00_01_00_44)
  public var mode: WahMode = .lowPassFilter

  @IntegerParameter(at: 0x00_01_00_45, range: 0...100)
  public var frequency: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_46, range: 0...100)
  public var peak: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_47, range: 0...100)
  public var rate: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_48, range: 0...100)
  public var depth: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_49, range: 0...100)
  public var effectLevel: UInt8 = 100

  @IntegerParameter(at: 0x00_01_00_4A, range: 0...100)
  public var directLevel: UInt8 = 0

  public init(
    mode: WahMode, frequency: UInt8, peak: UInt8, rate: UInt8, depth: UInt8, effectLevel: UInt8,
    directLevel: UInt8
  ) {
    self.mode = mode
    self.frequency = frequency
    self.peak = peak
    self.rate = rate
    self.depth = depth
    self.effectLevel = effectLevel
    self.directLevel = directLevel
  }
}

// MARK: - ModFxGraphicEQ

public enum ModFxGraphicEQParameter: Sendable, Hashable {
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

/// The data bank representing the MOD/FX graphic equalizer parameters.
public struct ModFxGraphicEQBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00_01_00_4B, range: 0...40)
  public var band31Hz: UInt8 = 20

  @IntegerParameter(at: 0x00_01_00_4C, range: 0...40)
  public var band62Hz: UInt8 = 20

  @IntegerParameter(at: 0x00_01_00_4D, range: 0...40)
  public var band125Hz: UInt8 = 20

  @IntegerParameter(at: 0x00_01_00_4E, range: 0...40)
  public var band250Hz: UInt8 = 20

  @IntegerParameter(at: 0x00_01_00_4F, range: 0...40)
  public var band500Hz: UInt8 = 20

  @IntegerParameter(at: 0x00_01_00_50, range: 0...40)
  public var band1kHz: UInt8 = 20

  @IntegerParameter(at: 0x00_01_00_51, range: 0...40)
  public var band2kHz: UInt8 = 20

  @IntegerParameter(at: 0x00_01_00_52, range: 0...40)
  public var band4kHz: UInt8 = 20

  @IntegerParameter(at: 0x00_01_00_53, range: 0...40)
  public var band8kHz: UInt8 = 20

  @IntegerParameter(at: 0x00_01_00_54, range: 0...40)
  public var band16kHz: UInt8 = 20

  @IntegerParameter(at: 0x00_01_00_55, range: 0...40)
  public var level: UInt8 = 20

  public init(
    band31Hz: UInt8, band62Hz: UInt8, band125Hz: UInt8, band250Hz: UInt8, band500Hz: UInt8,
    band1kHz: UInt8, band2kHz: UInt8, band4kHz: UInt8, band8kHz: UInt8, band16kHz: UInt8,
    level: UInt8
  ) {
    self.band31Hz = band31Hz
    self.band62Hz = band62Hz
    self.band125Hz = band125Hz
    self.band250Hz = band250Hz
    self.band500Hz = band500Hz
    self.band1kHz = band1kHz
    self.band2kHz = band2kHz
    self.band4kHz = band4kHz
    self.band8kHz = band8kHz
    self.band16kHz = band16kHz
    self.level = level
  }
}

// MARK: - ModFxParametricEQ

public enum ModFxParametricEQParameter: Sendable, Hashable {
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

/// The data bank representing the MOD/FX parametric equalizer parameters.
public struct ModFxParametricEQBank: Sendable, Hashable {
  @Parameter(at: 0x00_01_00_56)
  public var lowCut: EQLowCut = .flat

  @IntegerParameter(at: 0x00_01_00_57, range: 0...40)
  public var lowGain: UInt8 = 20

  @Parameter(at: 0x00_01_00_58)
  public var lowMidFreq: EQFrequency = .freq200Hz

  @Parameter(at: 0x00_01_00_59)
  public var lowMidQ: EQQ = .q1

  @IntegerParameter(at: 0x00_01_00_5A, range: 0...40)
  public var lowMidGain: UInt8 = 20

  @Parameter(at: 0x00_01_00_5B)
  public var highMidFreq: EQFrequency = .freq2kHz

  @Parameter(at: 0x00_01_00_5C)
  public var highMidQ: EQQ = .q1

  @IntegerParameter(at: 0x00_01_00_5D, range: 0...40)
  public var highMidGain: UInt8 = 20

  @IntegerParameter(at: 0x00_01_00_5E, range: 0...40)
  public var highGain: UInt8 = 20

  @Parameter(at: 0x00_01_00_5F)
  public var highCut: EQHighCut = .flat

  @IntegerParameter(at: 0x00_01_00_60, range: 0...40)
  public var level: UInt8 = 20

  public init(
    lowCut: EQLowCut, lowGain: UInt8, lowMidFreq: EQFrequency, lowMidQ: EQQ, lowMidGain: UInt8,
    highMidFreq: EQFrequency, highMidQ: EQQ, highMidGain: UInt8, highGain: UInt8,
    highCut: EQHighCut, level: UInt8
  ) {
    self.lowCut = lowCut
    self.lowGain = lowGain
    self.lowMidFreq = lowMidFreq
    self.lowMidQ = lowMidQ
    self.lowMidGain = lowMidGain
    self.highMidFreq = highMidFreq
    self.highMidQ = highMidQ
    self.highMidGain = highMidGain
    self.highGain = highGain
    self.highCut = highCut
    self.level = level
  }
}

// MARK: - GuitarSim

public enum GuitarSimParameter: Sendable, Hashable {
  case type(GuitarSimType)
  /// Range is from -50 to 50 mapped to 0..100.
  case low(UInt8)
  /// Range is from -50 to 50 mapped to 0..100.
  case high(UInt8)
  case body(UInt8)
  case level(UInt8)
}

/// The data bank representing the guitar simulation parameters.
public struct GuitarSimBank: Sendable, Hashable {
  @Parameter(at: 0x00_01_00_61)
  public var type: GuitarSimType = .sToH

  @IntegerParameter(at: 0x00_01_00_62, range: 0...100)
  public var low: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_63, range: 0...100)
  public var high: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_64, range: 0...100)
  public var body: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_65, range: 0...100)
  public var level: UInt8 = 100

  public init(type: GuitarSimType, low: UInt8, high: UInt8, body: UInt8, level: UInt8) {
    self.type = type
    self.low = low
    self.high = high
    self.body = body
    self.level = level
  }
}

public enum GuitarSimType: UInt8, Sendable, Hashable, CaseIterable {
  case sToH = 0x00
  case hToS = 0x01
  case hToHF = 0x02
  case sToHollow = 0x03
  case hToHollow = 0x04
  case sToAc = 0x05
  case hToAc = 0x06
  case pToAc = 0x07
}

// MARK: - ACSim

public enum ACSimParameter: Sendable, Hashable {
  /// Range is from -50 to 50 mapped to 0..100.
  case high(UInt8)
  case body(UInt8)
  /// Range is from -50 to 50 mapped to 0..100.
  case low(UInt8)
  case level(UInt8)
}

/// The data bank representing the acoustic simulation parameters.
public struct ACSimBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00_01_00_66, range: 0...100)
  public var high: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_67, range: 0...100)
  public var body: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_68, range: 0...100)
  public var low: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_69, range: 0...100)
  public var level: UInt8 = 100

  public init(high: UInt8, body: UInt8, low: UInt8, level: UInt8) {
    self.high = high
    self.body = body
    self.low = low
    self.level = level
  }
}

// MARK: - AcousticPro

public enum AcousticProParameter: Sendable, Hashable {
  case type(AcousticProType)
  /// Range is from -50 to 50 mapped to 0..100.
  case bass(UInt8)
  /// Range is from -50 to 50 mapped to 0..100.
  case middle(UInt8)
  case midFrequency(EQFrequency)
  /// Range is from -50 to 50 mapped to 0..100.
  case treble(UInt8)
  /// Range is from -50 to 50 mapped to 0..100.
  case presence(UInt8)
  case level(UInt8)
}

/// The data bank representing the acoustic pro parameters.
public struct AcousticProBank: Sendable, Hashable {
  @Parameter(at: 0x00_01_00_6A)
  public var type: AcousticProType = .small

  @IntegerParameter(at: 0x00_01_00_6B, range: 0...100)
  public var bass: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_6C, range: 0...100)
  public var middle: UInt8 = 50

  @Parameter(at: 0x00_01_00_6D)
  public var midFrequency: EQFrequency = .freq500Hz

  @IntegerParameter(at: 0x00_01_00_6E, range: 0...100)
  public var treble: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_6F, range: 0...100)
  public var presence: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_70, range: 0...100)
  public var level: UInt8 = 100

  public init(
    type: AcousticProType, bass: UInt8, middle: UInt8, midFrequency: EQFrequency, treble: UInt8,
    presence: UInt8, level: UInt8
  ) {
    self.type = type
    self.bass = bass
    self.middle = middle
    self.midFrequency = midFrequency
    self.treble = treble
    self.presence = presence
    self.level = level
  }
}

public enum AcousticProType: UInt8, Sendable, Hashable, CaseIterable {
  case small = 0x00
  case medium = 0x01
  case bright = 0x02
  case power = 0x03
}

// MARK: - WaveSynth

public enum WaveSynthParameter: Sendable, Hashable {
  case type(WaveSynthType)
  case cutoff(UInt8)
  case resonance(UInt8)
  case filterSens(UInt8)
  case filterDecay(UInt8)
  case filterDepth(UInt8)
  case synthLevel(UInt8)
  case directMix(UInt8)
}

/// The data bank representing the wave synth parameters.
public struct WaveSynthBank: Sendable, Hashable {
  @Parameter(at: 0x00_01_00_71)
  public var type: WaveSynthType = .saw

  @IntegerParameter(at: 0x00_01_00_72, range: 0...100)
  public var cutoff: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_73, range: 0...100)
  public var resonance: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_74, range: 0...100)
  public var filterSens: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_75, range: 0...100)
  public var filterDecay: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_76, range: 0...100)
  public var filterDepth: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_77, range: 0...100)
  public var synthLevel: UInt8 = 100

  @IntegerParameter(at: 0x00_01_00_78, range: 0...100)
  public var directMix: UInt8 = 0

  public init(
    type: WaveSynthType, cutoff: UInt8, resonance: UInt8, filterSens: UInt8, filterDecay: UInt8,
    filterDepth: UInt8, synthLevel: UInt8, directMix: UInt8
  ) {
    self.type = type
    self.cutoff = cutoff
    self.resonance = resonance
    self.filterSens = filterSens
    self.filterDecay = filterDecay
    self.filterDepth = filterDepth
    self.synthLevel = synthLevel
    self.directMix = directMix
  }
}

public enum WaveSynthType: UInt8, Sendable, Hashable, CaseIterable {
  case saw = 0x00
  case square = 0x01
}

// MARK: - Octaver

public enum OctaverParameter: Sendable, Hashable {
  case range(OctaverRange)
  case level(UInt8)
  case directLevel(UInt8)
}

/// The data bank representing the octaver parameters.
public struct OctaverBank: Sendable, Hashable {
  @Parameter(at: 0x00_01_00_79)
  public var range: OctaverRange = .range1

  @IntegerParameter(at: 0x00_01_00_7A, range: 0...100)
  public var level: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_7B, range: 0...100)
  public var directLevel: UInt8 = 0

  public init(range: OctaverRange, level: UInt8, directLevel: UInt8) {
    self.range = range
    self.level = level
    self.directLevel = directLevel
  }
}

public enum OctaverRange: UInt8, Sendable, Hashable, CaseIterable {
  case range1 = 0x00
  case range2 = 0x01
  case range3 = 0x02
  case range4 = 0x03
}

// MARK: - HeavyOctave

public enum HeavyOctaveParameter: Sendable, Hashable {
  case octaveMinus1(UInt8)
  case octaveMinus2(UInt8)
  case directMix(UInt8)
}

/// The data bank representing the heavy octave parameters.
public struct HeavyOctaveBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00_01_00_7C, range: 0...100)
  public var octaveMinus1: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_7D, range: 0...100)
  public var octaveMinus2: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_7E, range: 0...100)
  public var directMix: UInt8 = 0

  public init(octaveMinus1: UInt8, octaveMinus2: UInt8, directMix: UInt8) {
    self.octaveMinus1 = octaveMinus1
    self.octaveMinus2 = octaveMinus2
    self.directMix = directMix
  }
}

// MARK: - PitchShifter

public enum PitchShifterParameter: Sendable, Hashable {
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

/// The data bank representing the pitch shifter parameters.
public struct PitchShifterBank: Sendable, Hashable {
  @Parameter(at: 0x00_01_00_7F)
  public var voice: PitchShifterVoice = .oneVoice

  @Parameter(at: 0x00_01_01_00)
  public var ps1Mode: PitchShifterMode = .fast

  @IntegerParameter(at: 0x00_01_01_01, range: 0...100)
  public var ps1Pitch: UInt8 = 50

  @IntegerParameter(at: 0x00_01_01_02, range: 0...100)
  public var ps1Fine: UInt8 = 50

  @IntegerParameter(at: 0x00_01_01_03, range: 0...300)
  public var ps1PreDelay: UInt16 = 0

  @IntegerParameter(at: 0x00_01_01_07, range: 0...100)
  public var ps1Level: UInt8 = 100

  @Parameter(at: 0x00_01_01_08)
  public var ps2Mode: PitchShifterMode = .fast

  @IntegerParameter(at: 0x00_01_01_09, range: 0...100)
  public var ps2Pitch: UInt8 = 50

  @IntegerParameter(at: 0x00_01_01_0A, range: 0...100)
  public var ps2Fine: UInt8 = 50

  @IntegerParameter(at: 0x00_01_01_0B, range: 0...300)
  public var ps2PreDelay: UInt16 = 0

  @IntegerParameter(at: 0x00_01_01_0F, range: 0...100)
  public var ps2Level: UInt8 = 100

  @IntegerParameter(at: 0x00_01_01_10, range: 0...100)
  public var ps1Feedback: UInt8 = 0

  @IntegerParameter(at: 0x00_01_01_11, range: 0...100)
  public var directLevel: UInt8 = 0

  public init(
    voice: PitchShifterVoice, ps1Mode: PitchShifterMode, ps1Pitch: UInt8, ps1Fine: UInt8,
    ps1PreDelay: UInt16, ps1Level: UInt8, ps2Mode: PitchShifterMode, ps2Pitch: UInt8,
    ps2Fine: UInt8, ps2PreDelay: UInt16, ps2Level: UInt8, ps1Feedback: UInt8, directLevel: UInt8
  ) {
    self.voice = voice
    self.ps1Mode = ps1Mode
    self.ps1Pitch = ps1Pitch
    self.ps1Fine = ps1Fine
    self.ps1PreDelay = ps1PreDelay
    self.ps1Level = ps1Level
    self.ps2Mode = ps2Mode
    self.ps2Pitch = ps2Pitch
    self.ps2Fine = ps2Fine
    self.ps2PreDelay = ps2PreDelay
    self.ps2Level = ps2Level
    self.ps1Feedback = ps1Feedback
    self.directLevel = directLevel
  }
}

public enum PitchShifterVoice: UInt8, Sendable, Hashable, CaseIterable {
  case oneVoice = 0x00
  case twoVoice = 0x01
}

public enum PitchShifterMode: UInt8, Sendable, Hashable, CaseIterable {
  case fast = 0x00
  case medium = 0x01
  case slow = 0x02
  case mono = 0x03
}

// MARK: - Harmonist

public enum HarmonistParameter: Sendable, Hashable {
  case voice(HarmonistVoice)
  case h1Harmony(HarmonistHarmony)
  case h1PreDelay(UInt16)
  case h1Level(UInt8)
  case h2Harmony(HarmonistHarmony)
  case h2PreDelay(UInt16)
  case h2Level(UInt8)
  case h1Feedback(UInt8)
  case directLevel(UInt8)
}

/// The data bank representing the harmonist parameters.
public struct HarmonistBank: Sendable, Hashable {
  @Parameter(at: 0x00_01_01_12)
  public var voice: HarmonistVoice = .oneVoice

  @Parameter(at: 0x00_01_01_13)
  public var h1Harmony: HarmonistHarmony = .unison

  @IntegerParameter(at: 0x00_01_01_14, range: 0...300)
  public var h1PreDelay: UInt16 = 0

  @IntegerParameter(at: 0x00_01_01_18, range: 0...100)
  public var h1Level: UInt8 = 100

  @Parameter(at: 0x00_01_01_19)
  public var h2Harmony: HarmonistHarmony = .unison

  @IntegerParameter(at: 0x00_01_01_1A, range: 0...300)
  public var h2PreDelay: UInt16 = 0

  @IntegerParameter(at: 0x00_01_01_1E, range: 0...100)
  public var h2Level: UInt8 = 100

  @IntegerParameter(at: 0x00_01_01_1F, range: 0...100)
  public var h1Feedback: UInt8 = 0

  @IntegerParameter(at: 0x00_01_01_20, range: 0...100)
  public var directLevel: UInt8 = 0

  public init(
    voice: HarmonistVoice, h1Harmony: HarmonistHarmony, h1PreDelay: UInt16, h1Level: UInt8,
    h2Harmony: HarmonistHarmony,
    h2PreDelay: UInt16, h2Level: UInt8, h1Feedback: UInt8, directLevel: UInt8
  ) {
    self.voice = voice
    self.h1Harmony = h1Harmony
    self.h1PreDelay = h1PreDelay
    self.h1Level = h1Level
    self.h2Harmony = h2Harmony
    self.h2PreDelay = h2PreDelay
    self.h2Level = h2Level
    self.h1Feedback = h1Feedback
    self.directLevel = directLevel
  }
}

public enum HarmonistVoice: UInt8, Sendable, Hashable, CaseIterable {
  case oneVoice = 0x00
  case twoVoice = 0x01
}

public enum HarmonistHarmony: UInt8, Sendable, Hashable, CaseIterable {
  case minus2oct = 0x00
  case minus14th = 0x01
  case minus13th = 0x02
  case minus12th = 0x03
  case minus11th = 0x04
  case minus10th = 0x05
  case minus9th = 0x06
  case minus8th = 0x07
  case minus7th = 0x08
  case minus6th = 0x09
  case minus5th = 0x0A
  case minus4th = 0x0B
  case minus3rd = 0x0C
  case minus2nd = 0x0D
  case unison = 0x0E
  case plus2nd = 0x0F
  case plus3rd = 0x10
  case plus4th = 0x11
  case plus5th = 0x12
  case plus6th = 0x13
  case plus7th = 0x14
  case plus8th = 0x15
  case plus9th = 0x16
  case plus10th = 0x17
  case plus11th = 0x18
  case plus12th = 0x19
  case plus13th = 0x1A
  case plus14th = 0x1B
  case plus2oct = 0x1C
  case user = 0x1D
}

// MARK: - Humanizer

public enum HumanizerParameter: Sendable, Hashable {
  case mode(HumanizerMode)
  case vowel1(HumanizerWovel)
  case vowel2(HumanizerWovel)
  case sens(UInt8)
  case rate(UInt8)
  case depth(UInt8)
  case manual(UInt8)
  case level(UInt8)
}

/// The data bank representing the humanizer parameters.
public struct HumanizerBank: Sendable, Hashable {
  @Parameter(at: 0x00_01_01_39)
  public var mode: HumanizerMode = .picking

  @Parameter(at: 0x00_01_01_3A)
  public var vowel1: HumanizerWovel = .a

  @Parameter(at: 0x00_01_01_3B)
  public var vowel2: HumanizerWovel = .e

  @IntegerParameter(at: 0x00_01_01_3C, range: 0...100)
  public var sens: UInt8 = 50

  @IntegerParameter(at: 0x00_01_01_3D, range: 0...100)
  public var rate: UInt8 = 50

  @IntegerParameter(at: 0x00_01_01_3E, range: 0...100)
  public var depth: UInt8 = 50

  @IntegerParameter(at: 0x00_01_01_3F, range: 0...100)
  public var manual: UInt8 = 50

  @IntegerParameter(at: 0x00_01_01_40, range: 0...100)
  public var level: UInt8 = 100

  public init(
    mode: HumanizerMode, vowel1: HumanizerWovel, vowel2: HumanizerWovel, sens: UInt8, rate: UInt8,
    depth: UInt8, manual: UInt8, level: UInt8
  ) {
    self.mode = mode
    self.vowel1 = vowel1
    self.vowel2 = vowel2
    self.sens = sens
    self.rate = rate
    self.depth = depth
    self.manual = manual
    self.level = level
  }
}

public enum HumanizerMode: UInt8, Sendable, Hashable, CaseIterable {
  case picking = 0x00
  case auto = 0x01
}

public enum HumanizerWovel: UInt8, Sendable, Hashable, CaseIterable {
  case a = 0x00
  case e = 0x01
  case i = 0x02
  case o = 0x03
  case u = 0x04
}

// MARK: - Phaser90E

public enum Phaser90EParameter: Sendable, Hashable {
  case scriptEnable(Bool)
  case speed(UInt8)
}

/// The data bank representing the phaser 90E parameters.
public struct Phaser90EBank: Sendable, Hashable {
  @Parameter(at: 0x00_01_01_41)
  public var scriptStatus: Bool = false

  @IntegerParameter(at: 0x00_01_01_42, range: 0...100)
  public var speed: UInt8 = 50

  public init(scriptStatus: Bool, speed: UInt8) {
    self.scriptStatus = scriptStatus
    self.speed = speed
  }
}

// MARK: - Flanger117E

public enum Flanger117EParameter: Sendable, Hashable {
  case manual(UInt8)
  case width(UInt8)
  case speed(UInt8)
  case regen(UInt8)
}

/// The data bank representing the flanger 117E parameters.
public struct Flanger117EBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00_01_01_43, range: 0...100)
  public var manual: UInt8 = 50

  @IntegerParameter(at: 0x00_01_01_44, range: 0...100)
  public var width: UInt8 = 50

  @IntegerParameter(at: 0x00_01_01_45, range: 0...100)
  public var speed: UInt8 = 50

  @IntegerParameter(at: 0x00_01_01_46, range: 0...100)
  public var regen: UInt8 = 50

  public init(manual: UInt8, width: UInt8, speed: UInt8, regen: UInt8) {
    self.manual = manual
    self.width = width
    self.speed = speed
    self.regen = regen
  }
}

// MARK: - DC30

public enum DC30Parameter: Sendable, Hashable {
  case type(DC30Type)
  case inputVolume(UInt8)
  case chorusIntensity(UInt8)
  case repeatTime(UInt16)
  case echoIntensity(UInt8)
  case volume(UInt8)
  case tone(UInt8)
  case outputType(DC30OutputType)
}

/// The data bank representing the DC-30 parameters.
public struct DC30Bank: Sendable, Hashable {
  @Parameter(at: 0x00_01_01_47)
  public var type: DC30Type = .chorus

  @IntegerParameter(at: 0x00_01_01_48, range: 0...100)
  public var inputVolume: UInt8 = 50

  @IntegerParameter(at: 0x00_01_01_49, range: 0...100)
  public var chorusIntensity: UInt8 = 50

  @IntegerParameter(at: 0x00_01_01_4A, range: 0...600)
  public var repeatTime: UInt16 = 300

  @IntegerParameter(at: 0x00_01_01_4E, range: 0...100)
  public var echoIntensity: UInt8 = 50

  @IntegerParameter(at: 0x00_01_01_4F, range: 0...100)
  public var volume: UInt8 = 50

  @IntegerParameter(at: 0x00_01_01_50, range: 0...100)
  public var tone: UInt8 = 50

  @Parameter(at: 0x00_01_01_51)
  public var outputType: DC30OutputType = .dPlusE

  public init(
    type: DC30Type, inputVolume: UInt8, chorusIntensity: UInt8, repeatTime: UInt16,
    echoIntensity: UInt8, volume: UInt8, tone: UInt8, outputType: DC30OutputType
  ) {
    self.type = type
    self.inputVolume = inputVolume
    self.chorusIntensity = chorusIntensity
    self.repeatTime = repeatTime
    self.echoIntensity = echoIntensity
    self.volume = volume
    self.tone = tone
    self.outputType = outputType
  }
}

public enum DC30Type: UInt8, Sendable, Hashable, CaseIterable {
  case chorus = 0x00
  case echo = 0x01
}

public enum DC30OutputType: UInt8, Sendable, Hashable, CaseIterable {
  case dPlusE = 0x00
  case dOverE = 0x01
}
