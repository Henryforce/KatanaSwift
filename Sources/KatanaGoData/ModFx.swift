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
public struct ModFxBank: WritableBank, Sendable, Hashable {
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

  package var writeData = [WriteData]()

  init(
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

  public init(
    status: Bool? = nil, type: ModFxType? = nil, chorus: ChorusBank? = nil,
    flanger: FlangerBank? = nil, phaser: PhaserBank? = nil, uniVibe: UniVibeBank? = nil,
    tremolo: TremoloBank? = nil, vibrato: VibratoBank? = nil, rotary: RotaryBank? = nil,
    ringMod: RingModBank? = nil, slowGear: SlowGearBank? = nil, slicer: SlicerBank? = nil,
    comp: CompBank? = nil, limiter: LimiterBank? = nil, tWah: TWahBank? = nil,
    autoWah: AutoWahBank? = nil, graphicEQ: ModFxGraphicEQBank? = nil,
    parametricEQ: ModFxParametricEQBank? = nil, guitarSim: GuitarSimBank? = nil,
    acSim: ACSimBank? = nil, acousticPro: AcousticProBank? = nil, waveSynth: WaveSynthBank? = nil,
    octaver: OctaverBank? = nil, heavyOctave: HeavyOctaveBank? = nil,
    pitchShifter: PitchShifterBank? = nil, harmonist: HarmonistBank? = nil,
    humanizer: HumanizerBank? = nil, phaser90E: Phaser90EBank? = nil,
    flanger117E: Flanger117EBank? = nil, dc30: DC30Bank? = nil
  ) {
    self.status = status ?? false
    self.type = type ?? .chorus
    self.chorus = chorus ?? ChorusBank()
    self.flanger = flanger ?? FlangerBank()
    self.phaser = phaser ?? PhaserBank()
    self.uniVibe = uniVibe ?? UniVibeBank()
    self.tremolo = tremolo ?? TremoloBank()
    self.vibrato = vibrato ?? VibratoBank()
    self.rotary = rotary ?? RotaryBank()
    self.ringMod = ringMod ?? RingModBank()
    self.slowGear = slowGear ?? SlowGearBank()
    self.slicer = slicer ?? SlicerBank()
    self.comp = comp ?? CompBank()
    self.limiter = limiter ?? LimiterBank()
    self.tWah = tWah ?? TWahBank()
    self.autoWah = autoWah ?? AutoWahBank()
    self.graphicEQ = graphicEQ ?? ModFxGraphicEQBank()
    self.parametricEQ = parametricEQ ?? ModFxParametricEQBank()
    self.guitarSim = guitarSim ?? GuitarSimBank()
    self.acSim = acSim ?? ACSimBank()
    self.acousticPro = acousticPro ?? AcousticProBank()
    self.waveSynth = waveSynth ?? WaveSynthBank()
    self.octaver = octaver ?? OctaverBank()
    self.heavyOctave = heavyOctave ?? HeavyOctaveBank()
    self.pitchShifter = pitchShifter ?? PitchShifterBank()
    self.harmonist = harmonist ?? HarmonistBank()
    self.humanizer = humanizer ?? HumanizerBank()
    self.phaser90E = phaser90E ?? Phaser90EBank()
    self.flanger117E = flanger117E ?? Flanger117EBank()
    self.dc30 = dc30 ?? DC30Bank()

    if let status {
      self.writeData.append(WriteData(address: self.$status.address, data: status.bytes))
    }
    if let type {
      self.writeData.append(WriteData(address: self.$type.address, data: type.rawValue.bytes))
    }
    if let chorus { self.writeData.append(contentsOf: chorus.loadWriteData()) }
    if let flanger { self.writeData.append(contentsOf: flanger.loadWriteData()) }
    if let phaser { self.writeData.append(contentsOf: phaser.loadWriteData()) }
    if let uniVibe { self.writeData.append(contentsOf: uniVibe.loadWriteData()) }
    if let tremolo { self.writeData.append(contentsOf: tremolo.loadWriteData()) }
    if let vibrato { self.writeData.append(contentsOf: vibrato.loadWriteData()) }
    if let rotary { self.writeData.append(contentsOf: rotary.loadWriteData()) }
    if let ringMod { self.writeData.append(contentsOf: ringMod.loadWriteData()) }
    if let slowGear { self.writeData.append(contentsOf: slowGear.loadWriteData()) }
    if let slicer { self.writeData.append(contentsOf: slicer.loadWriteData()) }
    if let comp { self.writeData.append(contentsOf: comp.loadWriteData()) }
    if let limiter { self.writeData.append(contentsOf: limiter.loadWriteData()) }
    if let tWah { self.writeData.append(contentsOf: tWah.loadWriteData()) }
    if let autoWah { self.writeData.append(contentsOf: autoWah.loadWriteData()) }
    if let graphicEQ { self.writeData.append(contentsOf: graphicEQ.loadWriteData()) }
    if let parametricEQ { self.writeData.append(contentsOf: parametricEQ.loadWriteData()) }
    if let guitarSim { self.writeData.append(contentsOf: guitarSim.loadWriteData()) }
    if let acSim { self.writeData.append(contentsOf: acSim.loadWriteData()) }
    if let acousticPro { self.writeData.append(contentsOf: acousticPro.loadWriteData()) }
    if let waveSynth { self.writeData.append(contentsOf: waveSynth.loadWriteData()) }
    if let octaver { self.writeData.append(contentsOf: octaver.loadWriteData()) }
    if let heavyOctave { self.writeData.append(contentsOf: heavyOctave.loadWriteData()) }
    if let pitchShifter { self.writeData.append(contentsOf: pitchShifter.loadWriteData()) }
    if let harmonist { self.writeData.append(contentsOf: harmonist.loadWriteData()) }
    if let humanizer { self.writeData.append(contentsOf: humanizer.loadWriteData()) }
    if let phaser90E { self.writeData.append(contentsOf: phaser90E.loadWriteData()) }
    if let flanger117E { self.writeData.append(contentsOf: flanger117E.loadWriteData()) }
    if let dc30 { self.writeData.append(contentsOf: dc30.loadWriteData()) }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$status.address, data: status.bytes),
        WriteData(address: self.$type.address, data: type.rawValue.bytes),
      ] + chorus.loadWriteData() + flanger.loadWriteData() + phaser.loadWriteData()
        + uniVibe.loadWriteData() + tremolo.loadWriteData() + vibrato.loadWriteData()
        + rotary.loadWriteData() + ringMod.loadWriteData() + slowGear.loadWriteData()
        + slicer.loadWriteData() + comp.loadWriteData() + limiter.loadWriteData()
        + tWah.loadWriteData() + autoWah.loadWriteData() + graphicEQ.loadWriteData()
        + parametricEQ.loadWriteData() + guitarSim.loadWriteData() + acSim.loadWriteData()
        + acousticPro.loadWriteData() + waveSynth.loadWriteData() + octaver.loadWriteData()
        + heavyOctave.loadWriteData() + pitchShifter.loadWriteData() + harmonist.loadWriteData()
        + humanizer.loadWriteData() + phaser90E.loadWriteData() + flanger117E.loadWriteData()
        + dc30.loadWriteData()
    }
    return self.writeData
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
public struct ChorusBank: WritableBank, Sendable, Hashable {
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

  package var writeData = [WriteData]()

  init(
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

  public init(
    crossoverFrequency: UInt8? = nil, lowRate: UInt8? = nil, lowDepth: UInt8? = nil,
    lowPreDelay: UInt8? = nil, lowLevel: UInt8? = nil, highRate: UInt8? = nil,
    highDepth: UInt8? = nil, highPreDelay: UInt8? = nil, highLevel: UInt8? = nil,
    directMix: UInt8? = nil
  ) {
    if let crossoverFrequency {
      self.crossoverFrequency = crossoverFrequency
      self.writeData.append(
        WriteData(address: self.$crossoverFrequency.address, data: crossoverFrequency.bytes))
    }
    if let lowRate {
      self.lowRate = lowRate
      self.writeData.append(WriteData(address: self.$lowRate.address, data: lowRate.bytes))
    }
    if let lowDepth {
      self.lowDepth = lowDepth
      self.writeData.append(WriteData(address: self.$lowDepth.address, data: lowDepth.bytes))
    }
    if let lowPreDelay {
      self.lowPreDelay = lowPreDelay
      self.writeData.append(WriteData(address: self.$lowPreDelay.address, data: lowPreDelay.bytes))
    }
    if let lowLevel {
      self.lowLevel = lowLevel
      self.writeData.append(WriteData(address: self.$lowLevel.address, data: lowLevel.bytes))
    }
    if let highRate {
      self.highRate = highRate
      self.writeData.append(WriteData(address: self.$highRate.address, data: highRate.bytes))
    }
    if let highDepth {
      self.highDepth = highDepth
      self.writeData.append(WriteData(address: self.$highDepth.address, data: highDepth.bytes))
    }
    if let highPreDelay {
      self.highPreDelay = highPreDelay
      self.writeData.append(
        WriteData(address: self.$highPreDelay.address, data: highPreDelay.bytes))
    }
    if let highLevel {
      self.highLevel = highLevel
      self.writeData.append(WriteData(address: self.$highLevel.address, data: highLevel.bytes))
    }
    if let directMix {
      self.directMix = directMix
      self.writeData.append(WriteData(address: self.$directMix.address, data: directMix.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$crossoverFrequency.address, data: crossoverFrequency.bytes),
        WriteData(address: self.$lowRate.address, data: lowRate.bytes),
        WriteData(address: self.$lowDepth.address, data: lowDepth.bytes),
        WriteData(address: self.$lowPreDelay.address, data: lowPreDelay.bytes),
        WriteData(address: self.$lowLevel.address, data: lowLevel.bytes),
        WriteData(address: self.$highRate.address, data: highRate.bytes),
        WriteData(address: self.$highDepth.address, data: highDepth.bytes),
        WriteData(address: self.$highPreDelay.address, data: highPreDelay.bytes),
        WriteData(address: self.$highLevel.address, data: highLevel.bytes),
        WriteData(address: self.$directMix.address, data: directMix.bytes),
      ]
    }
    return self.writeData
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
public struct FlangerBank: WritableBank, Sendable, Hashable {
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

  package var writeData = [WriteData]()

  init(
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

  public init(
    rate: UInt8? = nil, depth: UInt8? = nil, manual: UInt8? = nil, resonance: UInt8? = nil,
    lowCut: FlangerLowCut? = nil, effectLevel: UInt8? = nil, directLevel: UInt8? = nil
  ) {
    if let rate {
      self.rate = rate
      self.writeData.append(WriteData(address: self.$rate.address, data: rate.bytes))
    }
    if let depth {
      self.depth = depth
      self.writeData.append(WriteData(address: self.$depth.address, data: depth.bytes))
    }
    if let manual {
      self.manual = manual
      self.writeData.append(WriteData(address: self.$manual.address, data: manual.bytes))
    }
    if let resonance {
      self.resonance = resonance
      self.writeData.append(WriteData(address: self.$resonance.address, data: resonance.bytes))
    }
    if let lowCut {
      self.lowCut = lowCut
      self.writeData.append(WriteData(address: self.$lowCut.address, data: lowCut.rawValue.bytes))
    }
    if let effectLevel {
      self.effectLevel = effectLevel
      self.writeData.append(WriteData(address: self.$effectLevel.address, data: effectLevel.bytes))
    }
    if let directLevel {
      self.directLevel = directLevel
      self.writeData.append(WriteData(address: self.$directLevel.address, data: directLevel.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$rate.address, data: rate.bytes),
        WriteData(address: self.$depth.address, data: depth.bytes),
        WriteData(address: self.$manual.address, data: manual.bytes),
        WriteData(address: self.$resonance.address, data: resonance.bytes),
        WriteData(address: self.$lowCut.address, data: lowCut.rawValue.bytes),
        WriteData(address: self.$effectLevel.address, data: effectLevel.bytes),
        WriteData(address: self.$directLevel.address, data: directLevel.bytes),
      ]
    }
    return self.writeData
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
public struct PhaserBank: WritableBank, Sendable, Hashable {
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

  package var writeData = [WriteData]()

  init(
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

  public init(
    type: PhaserType? = nil, rate: UInt8? = nil, depth: UInt8? = nil, manual: UInt8? = nil,
    resonance: UInt8? = nil, stepRate: UInt8? = nil, effectLevel: UInt8? = nil,
    directLevel: UInt8? = nil
  ) {
    if let type {
      self.type = type
      self.writeData.append(WriteData(address: self.$type.address, data: type.rawValue.bytes))
    }
    if let rate {
      self.rate = rate
      self.writeData.append(WriteData(address: self.$rate.address, data: rate.bytes))
    }
    if let depth {
      self.depth = depth
      self.writeData.append(WriteData(address: self.$depth.address, data: depth.bytes))
    }
    if let manual {
      self.manual = manual
      self.writeData.append(WriteData(address: self.$manual.address, data: manual.bytes))
    }
    if let resonance {
      self.resonance = resonance
      self.writeData.append(WriteData(address: self.$resonance.address, data: resonance.bytes))
    }
    if let stepRate {
      self.stepRate = stepRate
      self.writeData.append(WriteData(address: self.$stepRate.address, data: stepRate.bytes))
    }
    if let effectLevel {
      self.effectLevel = effectLevel
      self.writeData.append(WriteData(address: self.$effectLevel.address, data: effectLevel.bytes))
    }
    if let directLevel {
      self.directLevel = directLevel
      self.writeData.append(WriteData(address: self.$directLevel.address, data: directLevel.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$type.address, data: type.rawValue.bytes),
        WriteData(address: self.$rate.address, data: rate.bytes),
        WriteData(address: self.$depth.address, data: depth.bytes),
        WriteData(address: self.$manual.address, data: manual.bytes),
        WriteData(address: self.$resonance.address, data: resonance.bytes),
        WriteData(address: self.$stepRate.address, data: stepRate.bytes),
        WriteData(address: self.$effectLevel.address, data: effectLevel.bytes),
        WriteData(address: self.$directLevel.address, data: directLevel.bytes),
      ]
    }
    return self.writeData
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
public struct UniVibeBank: WritableBank, Sendable, Hashable {
  @IntegerParameter(at: 0x00_01_00_19, range: 0...100)
  public var rate: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_1A, range: 0...100)
  public var depth: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_1B, range: 0...100)
  public var level: UInt8 = 100

  package var writeData = [WriteData]()

  init(rate: UInt8, depth: UInt8, level: UInt8) {
    self.rate = rate
    self.depth = depth
    self.level = level
  }

  public init(rate: UInt8? = nil, depth: UInt8? = nil, level: UInt8? = nil) {
    if let rate {
      self.rate = rate
      self.writeData.append(WriteData(address: self.$rate.address, data: rate.bytes))
    }
    if let depth {
      self.depth = depth
      self.writeData.append(WriteData(address: self.$depth.address, data: depth.bytes))
    }
    if let level {
      self.level = level
      self.writeData.append(WriteData(address: self.$level.address, data: level.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$rate.address, data: rate.bytes),
        WriteData(address: self.$depth.address, data: depth.bytes),
        WriteData(address: self.$level.address, data: level.bytes),
      ]
    }
    return self.writeData
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
public struct TremoloBank: WritableBank, Sendable, Hashable {
  @IntegerParameter(at: 0x00_01_00_1C, range: 0...100)
  public var waveShape: UInt8 = 0

  @IntegerParameter(at: 0x00_01_00_1D, range: 0...100)
  public var rate: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_1E, range: 0...100)
  public var depth: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_1F, range: 0...100)
  public var level: UInt8 = 100

  package var writeData = [WriteData]()

  init(waveShape: UInt8, rate: UInt8, depth: UInt8, level: UInt8) {
    self.waveShape = waveShape
    self.rate = rate
    self.depth = depth
    self.level = level
  }

  public init(
    waveShape: UInt8? = nil, rate: UInt8? = nil, depth: UInt8? = nil, level: UInt8? = nil
  ) {
    if let waveShape {
      self.waveShape = waveShape
      self.writeData.append(WriteData(address: self.$waveShape.address, data: waveShape.bytes))
    }
    if let rate {
      self.rate = rate
      self.writeData.append(WriteData(address: self.$rate.address, data: rate.bytes))
    }
    if let depth {
      self.depth = depth
      self.writeData.append(WriteData(address: self.$depth.address, data: depth.bytes))
    }
    if let level {
      self.level = level
      self.writeData.append(WriteData(address: self.$level.address, data: level.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$waveShape.address, data: waveShape.bytes),
        WriteData(address: self.$rate.address, data: rate.bytes),
        WriteData(address: self.$depth.address, data: depth.bytes),
        WriteData(address: self.$level.address, data: level.bytes),
      ]
    }
    return self.writeData
  }
}

// MARK: - Vibrato

public enum VibratoParameter: Sendable, Hashable {
  case rate(UInt8)
  case depth(UInt8)
  case level(UInt8)
}

/// The data bank representing the vibrato parameters.
public struct VibratoBank: WritableBank, Sendable, Hashable {
  @IntegerParameter(at: 0x00_01_00_20, range: 0...100)
  public var rate: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_21, range: 0...100)
  public var depth: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_22, range: 0...100)
  public var level: UInt8 = 100

  package var writeData = [WriteData]()

  init(rate: UInt8, depth: UInt8, level: UInt8) {
    self.rate = rate
    self.depth = depth
    self.level = level
  }

  public init(rate: UInt8? = nil, depth: UInt8? = nil, level: UInt8? = nil) {
    if let rate {
      self.rate = rate
      self.writeData.append(WriteData(address: self.$rate.address, data: rate.bytes))
    }
    if let depth {
      self.depth = depth
      self.writeData.append(WriteData(address: self.$depth.address, data: depth.bytes))
    }
    if let level {
      self.level = level
      self.writeData.append(WriteData(address: self.$level.address, data: level.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$rate.address, data: rate.bytes),
        WriteData(address: self.$depth.address, data: depth.bytes),
        WriteData(address: self.$level.address, data: level.bytes),
      ]
    }
    return self.writeData
  }
}

// MARK: - Rotary

public enum RotaryParameter: Sendable, Hashable {
  case rate(UInt8)
  case depth(UInt8)
  case level(UInt8)
}

/// The data bank representing the rotary parameters.
public struct RotaryBank: WritableBank, Sendable, Hashable {
  @IntegerParameter(at: 0x00_01_00_23, range: 0...100)
  public var rate: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_24, range: 0...100)
  public var depth: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_25, range: 0...100)
  public var level: UInt8 = 100

  package var writeData = [WriteData]()

  init(rate: UInt8, depth: UInt8, level: UInt8) {
    self.rate = rate
    self.depth = depth
    self.level = level
  }

  public init(rate: UInt8? = nil, depth: UInt8? = nil, level: UInt8? = nil) {
    if let rate {
      self.rate = rate
      self.writeData.append(WriteData(address: self.$rate.address, data: rate.bytes))
    }
    if let depth {
      self.depth = depth
      self.writeData.append(WriteData(address: self.$depth.address, data: depth.bytes))
    }
    if let level {
      self.level = level
      self.writeData.append(WriteData(address: self.$level.address, data: level.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$rate.address, data: rate.bytes),
        WriteData(address: self.$depth.address, data: depth.bytes),
        WriteData(address: self.$level.address, data: level.bytes),
      ]
    }
    return self.writeData
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
public struct RingModBank: WritableBank, Sendable, Hashable {
  @Parameter(at: 0x00_01_00_26)
  public var mode: RingModMode = .normal

  @IntegerParameter(at: 0x00_01_00_27, range: 0...100)
  public var frequency: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_28, range: 0...100)
  public var effectLevel: UInt8 = 100

  @IntegerParameter(at: 0x00_01_00_29, range: 0...100)
  public var directMix: UInt8 = 0

  package var writeData = [WriteData]()

  public init(mode: RingModMode, frequency: UInt8, effectLevel: UInt8, directMix: UInt8) {
    self.mode = mode
    self.frequency = frequency
    self.effectLevel = effectLevel
    self.directMix = directMix
  }

  public init(
    mode: RingModMode? = nil, frequency: UInt8? = nil, effectLevel: UInt8? = nil,
    directMix: UInt8? = nil
  ) {
    if let mode {
      self.mode = mode
      self.writeData.append(WriteData(address: self.$mode.address, data: mode.rawValue.bytes))
    }
    if let frequency {
      self.frequency = frequency
      self.writeData.append(WriteData(address: self.$frequency.address, data: frequency.bytes))
    }
    if let effectLevel {
      self.effectLevel = effectLevel
      self.writeData.append(WriteData(address: self.$effectLevel.address, data: effectLevel.bytes))
    }
    if let directMix {
      self.directMix = directMix
      self.writeData.append(WriteData(address: self.$directMix.address, data: directMix.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$mode.address, data: mode.rawValue.bytes),
        WriteData(address: self.$frequency.address, data: frequency.bytes),
        WriteData(address: self.$effectLevel.address, data: effectLevel.bytes),
        WriteData(address: self.$directMix.address, data: directMix.bytes),
      ]
    }
    return self.writeData
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
public struct SlowGearBank: WritableBank, Sendable, Hashable {
  @IntegerParameter(at: 0x00_01_00_2A, range: 0...100)
  public var sens: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_2B, range: 0...100)
  public var riseTime: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_2C, range: 0...100)
  public var level: UInt8 = 100

  package var writeData = [WriteData]()

  init(sens: UInt8, riseTime: UInt8, level: UInt8) {
    self.sens = sens
    self.riseTime = riseTime
    self.level = level
  }

  public init(sens: UInt8? = nil, riseTime: UInt8? = nil, level: UInt8? = nil) {
    if let sens {
      self.sens = sens
      self.writeData.append(WriteData(address: self.$sens.address, data: sens.bytes))
    }
    if let riseTime {
      self.riseTime = riseTime
      self.writeData.append(WriteData(address: self.$riseTime.address, data: riseTime.bytes))
    }
    if let level {
      self.level = level
      self.writeData.append(WriteData(address: self.$level.address, data: level.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$sens.address, data: sens.bytes),
        WriteData(address: self.$riseTime.address, data: riseTime.bytes),
        WriteData(address: self.$level.address, data: level.bytes),
      ]
    }
    return self.writeData
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
public struct SlicerBank: WritableBank, Sendable, Hashable {
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

  package var writeData = [WriteData]()

  init(
    pattern: UInt8, rate: UInt8, triggerSens: UInt8, effectLevel: UInt8, directMix: UInt8
  ) {
    self.pattern = pattern
    self.rate = rate
    self.triggerSens = triggerSens
    self.effectLevel = effectLevel
    self.directMix = directMix
  }

  public init(
    pattern: UInt8? = nil, rate: UInt8? = nil, triggerSens: UInt8? = nil,
    effectLevel: UInt8? = nil, directMix: UInt8? = nil
  ) {
    if let pattern {
      self.pattern = pattern
      self.writeData.append(WriteData(address: self.$pattern.address, data: pattern.bytes))
    }
    if let rate {
      self.rate = rate
      self.writeData.append(WriteData(address: self.$rate.address, data: rate.bytes))
    }
    if let triggerSens {
      self.triggerSens = triggerSens
      self.writeData.append(WriteData(address: self.$triggerSens.address, data: triggerSens.bytes))
    }
    if let effectLevel {
      self.effectLevel = effectLevel
      self.writeData.append(WriteData(address: self.$effectLevel.address, data: effectLevel.bytes))
    }
    if let directMix {
      self.directMix = directMix
      self.writeData.append(WriteData(address: self.$directMix.address, data: directMix.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$pattern.address, data: pattern.bytes),
        WriteData(address: self.$rate.address, data: rate.bytes),
        WriteData(address: self.$triggerSens.address, data: triggerSens.bytes),
        WriteData(address: self.$effectLevel.address, data: effectLevel.bytes),
        WriteData(address: self.$directMix.address, data: directMix.bytes),
      ]
    }
    return self.writeData
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
public struct CompBank: WritableBank, Sendable, Hashable {
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

  package var writeData = [WriteData]()

  init(type: CompType, sustain: UInt8, attack: UInt8, tone: UInt8, level: UInt8) {
    self.type = type
    self.sustain = sustain
    self.attack = attack
    self.tone = tone
    self.level = level
  }

  public init(
    type: CompType? = nil, sustain: UInt8? = nil, attack: UInt8? = nil, tone: UInt8? = nil,
    level: UInt8? = nil
  ) {
    if let type {
      self.type = type
      self.writeData.append(WriteData(address: self.$type.address, data: type.rawValue.bytes))
    }
    if let sustain {
      self.sustain = sustain
      self.writeData.append(WriteData(address: self.$sustain.address, data: sustain.bytes))
    }
    if let attack {
      self.attack = attack
      self.writeData.append(WriteData(address: self.$attack.address, data: attack.bytes))
    }
    if let tone {
      self.tone = tone
      self.writeData.append(WriteData(address: self.$tone.address, data: tone.bytes))
    }
    if let level {
      self.level = level
      self.writeData.append(WriteData(address: self.$level.address, data: level.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$type.address, data: type.rawValue.bytes),
        WriteData(address: self.$sustain.address, data: sustain.bytes),
        WriteData(address: self.$attack.address, data: attack.bytes),
        WriteData(address: self.$tone.address, data: tone.bytes),
        WriteData(address: self.$level.address, data: level.bytes),
      ]
    }
    return self.writeData
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
public struct LimiterBank: WritableBank, Sendable, Hashable {
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

  package var writeData = [WriteData]()

  init(
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

  public init(
    type: LimiterType? = nil, attack: UInt8? = nil, threshold: UInt8? = nil,
    ratio: LimiterRatio? = nil, release: UInt8? = nil, level: UInt8? = nil
  ) {
    if let type {
      self.type = type
      self.writeData.append(WriteData(address: self.$type.address, data: type.rawValue.bytes))
    }
    if let attack {
      self.attack = attack
      self.writeData.append(WriteData(address: self.$attack.address, data: attack.bytes))
    }
    if let threshold {
      self.threshold = threshold
      self.writeData.append(WriteData(address: self.$threshold.address, data: threshold.bytes))
    }
    if let ratio {
      self.ratio = ratio
      self.writeData.append(WriteData(address: self.$ratio.address, data: ratio.rawValue.bytes))
    }
    if let release {
      self.release = release
      self.writeData.append(WriteData(address: self.$release.address, data: release.bytes))
    }
    if let level {
      self.level = level
      self.writeData.append(WriteData(address: self.$level.address, data: level.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$type.address, data: type.rawValue.bytes),
        WriteData(address: self.$attack.address, data: attack.bytes),
        WriteData(address: self.$threshold.address, data: threshold.bytes),
        WriteData(address: self.$ratio.address, data: ratio.rawValue.bytes),
        WriteData(address: self.$release.address, data: release.bytes),
        WriteData(address: self.$level.address, data: level.bytes),
      ]
    }
    return self.writeData
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
public struct TWahBank: WritableBank, Sendable, Hashable {
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

  package var writeData = [WriteData]()

  init(
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

  public init(
    mode: WahMode? = nil, polarity: TWahPolarity? = nil, sens: UInt8? = nil,
    frequency: UInt8? = nil, peak: UInt8? = nil, effectLevel: UInt8? = nil,
    directLevel: UInt8? = nil
  ) {
    if let mode {
      self.mode = mode
      self.writeData.append(WriteData(address: self.$mode.address, data: mode.rawValue.bytes))
    }
    if let polarity {
      self.polarity = polarity
      self.writeData.append(
        WriteData(address: self.$polarity.address, data: polarity.rawValue.bytes))
    }
    if let sens {
      self.sens = sens
      self.writeData.append(WriteData(address: self.$sens.address, data: sens.bytes))
    }
    if let frequency {
      self.frequency = frequency
      self.writeData.append(WriteData(address: self.$frequency.address, data: frequency.bytes))
    }
    if let peak {
      self.peak = peak
      self.writeData.append(WriteData(address: self.$peak.address, data: peak.bytes))
    }
    if let effectLevel {
      self.effectLevel = effectLevel
      self.writeData.append(WriteData(address: self.$effectLevel.address, data: effectLevel.bytes))
    }
    if let directLevel {
      self.directLevel = directLevel
      self.writeData.append(WriteData(address: self.$directLevel.address, data: directLevel.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$mode.address, data: mode.rawValue.bytes),
        WriteData(address: self.$polarity.address, data: polarity.rawValue.bytes),
        WriteData(address: self.$sens.address, data: sens.bytes),
        WriteData(address: self.$frequency.address, data: frequency.bytes),
        WriteData(address: self.$peak.address, data: peak.bytes),
        WriteData(address: self.$effectLevel.address, data: effectLevel.bytes),
        WriteData(address: self.$directLevel.address, data: directLevel.bytes),
      ]
    }
    return self.writeData
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
public struct AutoWahBank: WritableBank, Sendable, Hashable {
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

  package var writeData = [WriteData]()

  init(
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

  public init(
    mode: WahMode? = nil, frequency: UInt8? = nil, peak: UInt8? = nil, rate: UInt8? = nil,
    depth: UInt8? = nil, effectLevel: UInt8? = nil, directLevel: UInt8? = nil
  ) {
    if let mode {
      self.mode = mode
      self.writeData.append(WriteData(address: self.$mode.address, data: mode.rawValue.bytes))
    }
    if let frequency {
      self.frequency = frequency
      self.writeData.append(WriteData(address: self.$frequency.address, data: frequency.bytes))
    }
    if let peak {
      self.peak = peak
      self.writeData.append(WriteData(address: self.$peak.address, data: peak.bytes))
    }
    if let rate {
      self.rate = rate
      self.writeData.append(WriteData(address: self.$rate.address, data: rate.bytes))
    }
    if let depth {
      self.depth = depth
      self.writeData.append(WriteData(address: self.$depth.address, data: depth.bytes))
    }
    if let effectLevel {
      self.effectLevel = effectLevel
      self.writeData.append(WriteData(address: self.$effectLevel.address, data: effectLevel.bytes))
    }
    if let directLevel {
      self.directLevel = directLevel
      self.writeData.append(WriteData(address: self.$directLevel.address, data: directLevel.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$mode.address, data: mode.rawValue.bytes),
        WriteData(address: self.$frequency.address, data: frequency.bytes),
        WriteData(address: self.$peak.address, data: peak.bytes),
        WriteData(address: self.$rate.address, data: rate.bytes),
        WriteData(address: self.$depth.address, data: depth.bytes),
        WriteData(address: self.$effectLevel.address, data: effectLevel.bytes),
        WriteData(address: self.$directLevel.address, data: directLevel.bytes),
      ]
    }
    return self.writeData
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
public struct ModFxGraphicEQBank: WritableBank, Sendable, Hashable {
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

  package var writeData = [WriteData]()

  init(
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

  public init(
    band31Hz: UInt8? = nil, band62Hz: UInt8? = nil, band125Hz: UInt8? = nil,
    band250Hz: UInt8? = nil, band500Hz: UInt8? = nil, band1kHz: UInt8? = nil,
    band2kHz: UInt8? = nil, band4kHz: UInt8? = nil, band8kHz: UInt8? = nil,
    band16kHz: UInt8? = nil, level: UInt8? = nil
  ) {
    if let band31Hz {
      self.band31Hz = band31Hz
      self.writeData.append(WriteData(address: self.$band31Hz.address, data: band31Hz.bytes))
    }
    if let band62Hz {
      self.band62Hz = band62Hz
      self.writeData.append(WriteData(address: self.$band62Hz.address, data: band62Hz.bytes))
    }
    if let band125Hz {
      self.band125Hz = band125Hz
      self.writeData.append(WriteData(address: self.$band125Hz.address, data: band125Hz.bytes))
    }
    if let band250Hz {
      self.band250Hz = band250Hz
      self.writeData.append(WriteData(address: self.$band250Hz.address, data: band250Hz.bytes))
    }
    if let band500Hz {
      self.band500Hz = band500Hz
      self.writeData.append(WriteData(address: self.$band500Hz.address, data: band500Hz.bytes))
    }
    if let band1kHz {
      self.band1kHz = band1kHz
      self.writeData.append(WriteData(address: self.$band1kHz.address, data: band1kHz.bytes))
    }
    if let band2kHz {
      self.band2kHz = band2kHz
      self.writeData.append(WriteData(address: self.$band2kHz.address, data: band2kHz.bytes))
    }
    if let band4kHz {
      self.band4kHz = band4kHz
      self.writeData.append(WriteData(address: self.$band4kHz.address, data: band4kHz.bytes))
    }
    if let band8kHz {
      self.band8kHz = band8kHz
      self.writeData.append(WriteData(address: self.$band8kHz.address, data: band8kHz.bytes))
    }
    if let band16kHz {
      self.band16kHz = band16kHz
      self.writeData.append(WriteData(address: self.$band16kHz.address, data: band16kHz.bytes))
    }
    if let level {
      self.level = level
      self.writeData.append(WriteData(address: self.$level.address, data: level.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$band31Hz.address, data: band31Hz.bytes),
        WriteData(address: self.$band62Hz.address, data: band62Hz.bytes),
        WriteData(address: self.$band125Hz.address, data: band125Hz.bytes),
        WriteData(address: self.$band250Hz.address, data: band250Hz.bytes),
        WriteData(address: self.$band500Hz.address, data: band500Hz.bytes),
        WriteData(address: self.$band1kHz.address, data: band1kHz.bytes),
        WriteData(address: self.$band2kHz.address, data: band2kHz.bytes),
        WriteData(address: self.$band4kHz.address, data: band4kHz.bytes),
        WriteData(address: self.$band8kHz.address, data: band8kHz.bytes),
        WriteData(address: self.$band16kHz.address, data: band16kHz.bytes),
        WriteData(address: self.$level.address, data: level.bytes),
      ]
    }
    return self.writeData
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
public struct ModFxParametricEQBank: WritableBank, Sendable, Hashable {
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

  package var writeData = [WriteData]()

  init(
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

  public init(
    lowCut: EQLowCut? = nil, lowGain: UInt8? = nil, lowMidFreq: EQFrequency? = nil,
    lowMidQ: EQQ? = nil, lowMidGain: UInt8? = nil, highMidFreq: EQFrequency? = nil,
    highMidQ: EQQ? = nil, highMidGain: UInt8? = nil, highGain: UInt8? = nil,
    highCut: EQHighCut? = nil, level: UInt8? = nil
  ) {
    if let lowCut {
      self.lowCut = lowCut
      self.writeData.append(WriteData(address: self.$lowCut.address, data: lowCut.rawValue.bytes))
    }
    if let lowGain {
      self.lowGain = lowGain
      self.writeData.append(WriteData(address: self.$lowGain.address, data: lowGain.bytes))
    }
    if let lowMidFreq {
      self.lowMidFreq = lowMidFreq
      self.writeData.append(
        WriteData(address: self.$lowMidFreq.address, data: lowMidFreq.rawValue.bytes))
    }
    if let lowMidQ {
      self.lowMidQ = lowMidQ
      self.writeData.append(WriteData(address: self.$lowMidQ.address, data: lowMidQ.rawValue.bytes))
    }
    if let lowMidGain {
      self.lowMidGain = lowMidGain
      self.writeData.append(WriteData(address: self.$lowMidGain.address, data: lowMidGain.bytes))
    }
    if let highMidFreq {
      self.highMidFreq = highMidFreq
      self.writeData.append(
        WriteData(address: self.$highMidFreq.address, data: highMidFreq.rawValue.bytes))
    }
    if let highMidQ {
      self.highMidQ = highMidQ
      self.writeData.append(
        WriteData(address: self.$highMidQ.address, data: highMidQ.rawValue.bytes))
    }
    if let highMidGain {
      self.highMidGain = highMidGain
      self.writeData.append(WriteData(address: self.$highMidGain.address, data: highMidGain.bytes))
    }
    if let highGain {
      self.highGain = highGain
      self.writeData.append(WriteData(address: self.$highGain.address, data: highGain.bytes))
    }
    if let highCut {
      self.highCut = highCut
      self.writeData.append(WriteData(address: self.$highCut.address, data: highCut.rawValue.bytes))
    }
    if let level {
      self.level = level
      self.writeData.append(WriteData(address: self.$level.address, data: level.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$lowCut.address, data: lowCut.rawValue.bytes),
        WriteData(address: self.$lowGain.address, data: lowGain.bytes),
        WriteData(address: self.$lowMidFreq.address, data: lowMidFreq.rawValue.bytes),
        WriteData(address: self.$lowMidQ.address, data: lowMidQ.rawValue.bytes),
        WriteData(address: self.$lowMidGain.address, data: lowMidGain.bytes),
        WriteData(address: self.$highMidFreq.address, data: highMidFreq.rawValue.bytes),
        WriteData(address: self.$highMidQ.address, data: highMidQ.rawValue.bytes),
        WriteData(address: self.$highMidGain.address, data: highMidGain.bytes),
        WriteData(address: self.$highGain.address, data: highGain.bytes),
        WriteData(address: self.$highCut.address, data: highCut.rawValue.bytes),
        WriteData(address: self.$level.address, data: level.bytes),
      ]
    }
    return self.writeData
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
public struct GuitarSimBank: WritableBank, Sendable, Hashable {
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

  package var writeData = [WriteData]()

  init(type: GuitarSimType, low: UInt8, high: UInt8, body: UInt8, level: UInt8) {
    self.type = type
    self.low = low
    self.high = high
    self.body = body
    self.level = level
  }

  public init(
    type: GuitarSimType? = nil, low: UInt8? = nil, high: UInt8? = nil, body: UInt8? = nil,
    level: UInt8? = nil
  ) {
    if let type {
      self.type = type
      self.writeData.append(WriteData(address: self.$type.address, data: type.rawValue.bytes))
    }
    if let low {
      self.low = low
      self.writeData.append(WriteData(address: self.$low.address, data: low.bytes))
    }
    if let high {
      self.high = high
      self.writeData.append(WriteData(address: self.$high.address, data: high.bytes))
    }
    if let body {
      self.body = body
      self.writeData.append(WriteData(address: self.$body.address, data: body.bytes))
    }
    if let level {
      self.level = level
      self.writeData.append(WriteData(address: self.$level.address, data: level.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$type.address, data: type.rawValue.bytes),
        WriteData(address: self.$low.address, data: low.bytes),
        WriteData(address: self.$high.address, data: high.bytes),
        WriteData(address: self.$body.address, data: body.bytes),
        WriteData(address: self.$level.address, data: level.bytes),
      ]
    }
    return self.writeData
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
public struct ACSimBank: WritableBank, Sendable, Hashable {
  @IntegerParameter(at: 0x00_01_00_66, range: 0...100)
  public var high: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_67, range: 0...100)
  public var body: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_68, range: 0...100)
  public var low: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_69, range: 0...100)
  public var level: UInt8 = 100

  package var writeData = [WriteData]()

  init(high: UInt8, body: UInt8, low: UInt8, level: UInt8) {
    self.high = high
    self.body = body
    self.low = low
    self.level = level
  }

  public init(high: UInt8? = nil, body: UInt8? = nil, low: UInt8? = nil, level: UInt8? = nil) {
    if let high {
      self.high = high
      self.writeData.append(WriteData(address: self.$high.address, data: high.bytes))
    }
    if let body {
      self.body = body
      self.writeData.append(WriteData(address: self.$body.address, data: body.bytes))
    }
    if let low {
      self.low = low
      self.writeData.append(WriteData(address: self.$low.address, data: low.bytes))
    }
    if let level {
      self.level = level
      self.writeData.append(WriteData(address: self.$level.address, data: level.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$high.address, data: high.bytes),
        WriteData(address: self.$body.address, data: body.bytes),
        WriteData(address: self.$low.address, data: low.bytes),
        WriteData(address: self.$level.address, data: level.bytes),
      ]
    }
    return self.writeData
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
public struct AcousticProBank: WritableBank, Sendable, Hashable {
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

  package var writeData = [WriteData]()

  init(
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

  public init(
    type: AcousticProType? = nil, bass: UInt8? = nil, middle: UInt8? = nil,
    midFrequency: EQFrequency? = nil, treble: UInt8? = nil, presence: UInt8? = nil,
    level: UInt8? = nil
  ) {
    if let type {
      self.type = type
      self.writeData.append(WriteData(address: self.$type.address, data: type.rawValue.bytes))
    }
    if let bass {
      self.bass = bass
      self.writeData.append(WriteData(address: self.$bass.address, data: bass.bytes))
    }
    if let middle {
      self.middle = middle
      self.writeData.append(WriteData(address: self.$middle.address, data: middle.bytes))
    }
    if let midFrequency {
      self.midFrequency = midFrequency
      self.writeData.append(
        WriteData(address: self.$midFrequency.address, data: midFrequency.rawValue.bytes))
    }
    if let treble {
      self.treble = treble
      self.writeData.append(WriteData(address: self.$treble.address, data: treble.bytes))
    }
    if let presence {
      self.presence = presence
      self.writeData.append(WriteData(address: self.$presence.address, data: presence.bytes))
    }
    if let level {
      self.level = level
      self.writeData.append(WriteData(address: self.$level.address, data: level.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$type.address, data: type.rawValue.bytes),
        WriteData(address: self.$bass.address, data: bass.bytes),
        WriteData(address: self.$middle.address, data: middle.bytes),
        WriteData(address: self.$midFrequency.address, data: midFrequency.rawValue.bytes),
        WriteData(address: self.$treble.address, data: treble.bytes),
        WriteData(address: self.$presence.address, data: presence.bytes),
        WriteData(address: self.$level.address, data: level.bytes),
      ]
    }
    return self.writeData
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
public struct WaveSynthBank: WritableBank, Sendable, Hashable {
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

  package var writeData = [WriteData]()

  init(
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

  public init(
    type: WaveSynthType? = nil, cutoff: UInt8? = nil, resonance: UInt8? = nil,
    filterSens: UInt8? = nil, filterDecay: UInt8? = nil, filterDepth: UInt8? = nil,
    synthLevel: UInt8? = nil, directMix: UInt8? = nil
  ) {
    if let type {
      self.type = type
      self.writeData.append(WriteData(address: self.$type.address, data: type.rawValue.bytes))
    }
    if let cutoff {
      self.cutoff = cutoff
      self.writeData.append(WriteData(address: self.$cutoff.address, data: cutoff.bytes))
    }
    if let resonance {
      self.resonance = resonance
      self.writeData.append(WriteData(address: self.$resonance.address, data: resonance.bytes))
    }
    if let filterSens {
      self.filterSens = filterSens
      self.writeData.append(WriteData(address: self.$filterSens.address, data: filterSens.bytes))
    }
    if let filterDecay {
      self.filterDecay = filterDecay
      self.writeData.append(WriteData(address: self.$filterDecay.address, data: filterDecay.bytes))
    }
    if let filterDepth {
      self.filterDepth = filterDepth
      self.writeData.append(WriteData(address: self.$filterDepth.address, data: filterDepth.bytes))
    }
    if let synthLevel {
      self.synthLevel = synthLevel
      self.writeData.append(WriteData(address: self.$synthLevel.address, data: synthLevel.bytes))
    }
    if let directMix {
      self.directMix = directMix
      self.writeData.append(WriteData(address: self.$directMix.address, data: directMix.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$type.address, data: type.rawValue.bytes),
        WriteData(address: self.$cutoff.address, data: cutoff.bytes),
        WriteData(address: self.$resonance.address, data: resonance.bytes),
        WriteData(address: self.$filterSens.address, data: filterSens.bytes),
        WriteData(address: self.$filterDecay.address, data: filterDecay.bytes),
        WriteData(address: self.$filterDepth.address, data: filterDepth.bytes),
        WriteData(address: self.$synthLevel.address, data: synthLevel.bytes),
        WriteData(address: self.$directMix.address, data: directMix.bytes),
      ]
    }
    return self.writeData
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
public struct OctaverBank: WritableBank, Sendable, Hashable {
  @Parameter(at: 0x00_01_00_79)
  public var range: OctaverRange = .range1

  @IntegerParameter(at: 0x00_01_00_7A, range: 0...100)
  public var level: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_7B, range: 0...100)
  public var directLevel: UInt8 = 0

  package var writeData = [WriteData]()

  init(range: OctaverRange, level: UInt8, directLevel: UInt8) {
    self.range = range
    self.level = level
    self.directLevel = directLevel
  }

  public init(range: OctaverRange? = nil, level: UInt8? = nil, directLevel: UInt8? = nil) {
    if let range {
      self.range = range
      self.writeData.append(WriteData(address: self.$range.address, data: range.rawValue.bytes))
    }
    if let level {
      self.level = level
      self.writeData.append(WriteData(address: self.$level.address, data: level.bytes))
    }
    if let directLevel {
      self.directLevel = directLevel
      self.writeData.append(WriteData(address: self.$directLevel.address, data: directLevel.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$range.address, data: range.rawValue.bytes),
        WriteData(address: self.$level.address, data: level.bytes),
        WriteData(address: self.$directLevel.address, data: directLevel.bytes),
      ]
    }
    return self.writeData
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
public struct HeavyOctaveBank: WritableBank, Sendable, Hashable {
  @IntegerParameter(at: 0x00_01_00_7C, range: 0...100)
  public var octaveMinus1: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_7D, range: 0...100)
  public var octaveMinus2: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_7E, range: 0...100)
  public var directMix: UInt8 = 0

  package var writeData = [WriteData]()

  init(octaveMinus1: UInt8, octaveMinus2: UInt8, directMix: UInt8) {
    self.octaveMinus1 = octaveMinus1
    self.octaveMinus2 = octaveMinus2
    self.directMix = directMix
  }

  public init(octaveMinus1: UInt8? = nil, octaveMinus2: UInt8? = nil, directMix: UInt8? = nil) {
    if let octaveMinus1 {
      self.octaveMinus1 = octaveMinus1
      self.writeData.append(
        WriteData(address: self.$octaveMinus1.address, data: octaveMinus1.bytes))
    }
    if let octaveMinus2 {
      self.octaveMinus2 = octaveMinus2
      self.writeData.append(
        WriteData(address: self.$octaveMinus2.address, data: octaveMinus2.bytes))
    }
    if let directMix {
      self.directMix = directMix
      self.writeData.append(WriteData(address: self.$directMix.address, data: directMix.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$octaveMinus1.address, data: octaveMinus1.bytes),
        WriteData(address: self.$octaveMinus2.address, data: octaveMinus2.bytes),
        WriteData(address: self.$directMix.address, data: directMix.bytes),
      ]
    }
    return self.writeData
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
public struct PitchShifterBank: WritableBank, Sendable, Hashable {
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

  package var writeData = [WriteData]()

  init(
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

  public init(
    voice: PitchShifterVoice? = nil, ps1Mode: PitchShifterMode? = nil, ps1Pitch: UInt8? = nil,
    ps1Fine: UInt8? = nil, ps1PreDelay: UInt16? = nil, ps1Level: UInt8? = nil,
    ps2Mode: PitchShifterMode? = nil, ps2Pitch: UInt8? = nil, ps2Fine: UInt8? = nil,
    ps2PreDelay: UInt16? = nil, ps2Level: UInt8? = nil, ps1Feedback: UInt8? = nil,
    directLevel: UInt8? = nil
  ) {
    if let voice {
      self.voice = voice
      self.writeData.append(WriteData(address: self.$voice.address, data: voice.rawValue.bytes))
    }
    if let ps1Mode {
      self.ps1Mode = ps1Mode
      self.writeData.append(WriteData(address: self.$ps1Mode.address, data: ps1Mode.rawValue.bytes))
    }
    if let ps1Pitch {
      self.ps1Pitch = ps1Pitch
      self.writeData.append(WriteData(address: self.$ps1Pitch.address, data: ps1Pitch.bytes))
    }
    if let ps1Fine {
      self.ps1Fine = ps1Fine
      self.writeData.append(WriteData(address: self.$ps1Fine.address, data: ps1Fine.bytes))
    }
    if let ps1PreDelay {
      self.ps1PreDelay = ps1PreDelay
      self.writeData.append(WriteData(address: self.$ps1PreDelay.address, data: ps1PreDelay.bytes))
    }
    if let ps1Level {
      self.ps1Level = ps1Level
      self.writeData.append(WriteData(address: self.$ps1Level.address, data: ps1Level.bytes))
    }
    if let ps2Mode {
      self.ps2Mode = ps2Mode
      self.writeData.append(WriteData(address: self.$ps2Mode.address, data: ps2Mode.rawValue.bytes))
    }
    if let ps2Pitch {
      self.ps2Pitch = ps2Pitch
      self.writeData.append(WriteData(address: self.$ps2Pitch.address, data: ps2Pitch.bytes))
    }
    if let ps2Fine {
      self.ps2Fine = ps2Fine
      self.writeData.append(WriteData(address: self.$ps2Fine.address, data: ps2Fine.bytes))
    }
    if let ps2PreDelay {
      self.ps2PreDelay = ps2PreDelay
      self.writeData.append(WriteData(address: self.$ps2PreDelay.address, data: ps2PreDelay.bytes))
    }
    if let ps2Level {
      self.ps2Level = ps2Level
      self.writeData.append(WriteData(address: self.$ps2Level.address, data: ps2Level.bytes))
    }
    if let ps1Feedback {
      self.ps1Feedback = ps1Feedback
      self.writeData.append(WriteData(address: self.$ps1Feedback.address, data: ps1Feedback.bytes))
    }
    if let directLevel {
      self.directLevel = directLevel
      self.writeData.append(WriteData(address: self.$directLevel.address, data: directLevel.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$voice.address, data: voice.rawValue.bytes),
        WriteData(address: self.$ps1Mode.address, data: ps1Mode.rawValue.bytes),
        WriteData(address: self.$ps1Pitch.address, data: ps1Pitch.bytes),
        WriteData(address: self.$ps1Fine.address, data: ps1Fine.bytes),
        WriteData(address: self.$ps1PreDelay.address, data: ps1PreDelay.bytes),
        WriteData(address: self.$ps1Level.address, data: ps1Level.bytes),
        WriteData(address: self.$ps2Mode.address, data: ps2Mode.rawValue.bytes),
        WriteData(address: self.$ps2Pitch.address, data: ps2Pitch.bytes),
        WriteData(address: self.$ps2Fine.address, data: ps2Fine.bytes),
        WriteData(address: self.$ps2PreDelay.address, data: ps2PreDelay.bytes),
        WriteData(address: self.$ps2Level.address, data: ps2Level.bytes),
        WriteData(address: self.$ps1Feedback.address, data: ps1Feedback.bytes),
        WriteData(address: self.$directLevel.address, data: directLevel.bytes),
      ]
    }
    return self.writeData
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
public struct HarmonistBank: WritableBank, Sendable, Hashable {
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

  package var writeData = [WriteData]()

  init(
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

  public init(
    voice: HarmonistVoice? = nil, h1Harmony: HarmonistHarmony? = nil, h1PreDelay: UInt16? = nil,
    h1Level: UInt8? = nil, h2Harmony: HarmonistHarmony? = nil, h2PreDelay: UInt16? = nil,
    h2Level: UInt8? = nil, h1Feedback: UInt8? = nil, directLevel: UInt8? = nil
  ) {
    if let voice {
      self.voice = voice
      self.writeData.append(WriteData(address: self.$voice.address, data: voice.rawValue.bytes))
    }
    if let h1Harmony {
      self.h1Harmony = h1Harmony
      self.writeData.append(
        WriteData(address: self.$h1Harmony.address, data: h1Harmony.rawValue.bytes))
    }
    if let h1PreDelay {
      self.h1PreDelay = h1PreDelay
      self.writeData.append(WriteData(address: self.$h1PreDelay.address, data: h1PreDelay.bytes))
    }
    if let h1Level {
      self.h1Level = h1Level
      self.writeData.append(WriteData(address: self.$h1Level.address, data: h1Level.bytes))
    }
    if let h2Harmony {
      self.h2Harmony = h2Harmony
      self.writeData.append(
        WriteData(address: self.$h2Harmony.address, data: h2Harmony.rawValue.bytes))
    }
    if let h2PreDelay {
      self.h2PreDelay = h2PreDelay
      self.writeData.append(WriteData(address: self.$h2PreDelay.address, data: h2PreDelay.bytes))
    }
    if let h2Level {
      self.h2Level = h2Level
      self.writeData.append(WriteData(address: self.$h2Level.address, data: h2Level.bytes))
    }
    if let h1Feedback {
      self.h1Feedback = h1Feedback
      self.writeData.append(WriteData(address: self.$h1Feedback.address, data: h1Feedback.bytes))
    }
    if let directLevel {
      self.directLevel = directLevel
      self.writeData.append(WriteData(address: self.$directLevel.address, data: directLevel.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$voice.address, data: voice.rawValue.bytes),
        WriteData(address: self.$h1Harmony.address, data: h1Harmony.rawValue.bytes),
        WriteData(address: self.$h1PreDelay.address, data: h1PreDelay.bytes),
        WriteData(address: self.$h1Level.address, data: h1Level.bytes),
        WriteData(address: self.$h2Harmony.address, data: h2Harmony.rawValue.bytes),
        WriteData(address: self.$h2PreDelay.address, data: h2PreDelay.bytes),
        WriteData(address: self.$h2Level.address, data: h2Level.bytes),
        WriteData(address: self.$h1Feedback.address, data: h1Feedback.bytes),
        WriteData(address: self.$directLevel.address, data: directLevel.bytes),
      ]
    }
    return self.writeData
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
public struct HumanizerBank: WritableBank, Sendable, Hashable {
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

  package var writeData = [WriteData]()

  init(
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

  public init(
    mode: HumanizerMode? = nil, vowel1: HumanizerWovel? = nil, vowel2: HumanizerWovel? = nil,
    sens: UInt8? = nil, rate: UInt8? = nil, depth: UInt8? = nil, manual: UInt8? = nil,
    level: UInt8? = nil
  ) {
    if let mode {
      self.mode = mode
      self.writeData.append(WriteData(address: self.$mode.address, data: mode.rawValue.bytes))
    }
    if let vowel1 {
      self.vowel1 = vowel1
      self.writeData.append(WriteData(address: self.$vowel1.address, data: vowel1.rawValue.bytes))
    }
    if let vowel2 {
      self.vowel2 = vowel2
      self.writeData.append(WriteData(address: self.$vowel2.address, data: vowel2.rawValue.bytes))
    }
    if let sens {
      self.sens = sens
      self.writeData.append(WriteData(address: self.$sens.address, data: sens.bytes))
    }
    if let rate {
      self.rate = rate
      self.writeData.append(WriteData(address: self.$rate.address, data: rate.bytes))
    }
    if let depth {
      self.depth = depth
      self.writeData.append(WriteData(address: self.$depth.address, data: depth.bytes))
    }
    if let manual {
      self.manual = manual
      self.writeData.append(WriteData(address: self.$manual.address, data: manual.bytes))
    }
    if let level {
      self.level = level
      self.writeData.append(WriteData(address: self.$level.address, data: level.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$mode.address, data: mode.rawValue.bytes),
        WriteData(address: self.$vowel1.address, data: vowel1.rawValue.bytes),
        WriteData(address: self.$vowel2.address, data: vowel2.rawValue.bytes),
        WriteData(address: self.$sens.address, data: sens.bytes),
        WriteData(address: self.$rate.address, data: rate.bytes),
        WriteData(address: self.$depth.address, data: depth.bytes),
        WriteData(address: self.$manual.address, data: manual.bytes),
        WriteData(address: self.$level.address, data: level.bytes),
      ]
    }
    return self.writeData
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
public struct Phaser90EBank: WritableBank, Sendable, Hashable {
  @Parameter(at: 0x00_01_01_41)
  public var scriptStatus: Bool = false

  @IntegerParameter(at: 0x00_01_01_42, range: 0...100)
  public var speed: UInt8 = 50

  package var writeData = [WriteData]()

  init(scriptStatus: Bool, speed: UInt8) {
    self.scriptStatus = scriptStatus
    self.speed = speed
  }

  public init(scriptStatus: Bool? = nil, speed: UInt8? = nil) {
    if let scriptStatus {
      self.scriptStatus = scriptStatus
      self.writeData.append(
        WriteData(address: self.$scriptStatus.address, data: scriptStatus.bytes))
    }
    if let speed {
      self.speed = speed
      self.writeData.append(WriteData(address: self.$speed.address, data: speed.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$scriptStatus.address, data: scriptStatus.bytes),
        WriteData(address: self.$speed.address, data: speed.bytes),
      ]
    }
    return self.writeData
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
public struct Flanger117EBank: WritableBank, Sendable, Hashable {
  @IntegerParameter(at: 0x00_01_01_43, range: 0...100)
  public var manual: UInt8 = 50

  @IntegerParameter(at: 0x00_01_01_44, range: 0...100)
  public var width: UInt8 = 50

  @IntegerParameter(at: 0x00_01_01_45, range: 0...100)
  public var speed: UInt8 = 50

  @IntegerParameter(at: 0x00_01_01_46, range: 0...100)
  public var regen: UInt8 = 50

  package var writeData = [WriteData]()

  init(manual: UInt8, width: UInt8, speed: UInt8, regen: UInt8) {
    self.manual = manual
    self.width = width
    self.speed = speed
    self.regen = regen
  }

  public init(
    manual: UInt8? = nil, width: UInt8? = nil, speed: UInt8? = nil, regen: UInt8? = nil
  ) {
    if let manual {
      self.manual = manual
      self.writeData.append(WriteData(address: self.$manual.address, data: manual.bytes))
    }
    if let width {
      self.width = width
      self.writeData.append(WriteData(address: self.$width.address, data: width.bytes))
    }
    if let speed {
      self.speed = speed
      self.writeData.append(WriteData(address: self.$speed.address, data: speed.bytes))
    }
    if let regen {
      self.regen = regen
      self.writeData.append(WriteData(address: self.$regen.address, data: regen.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$manual.address, data: manual.bytes),
        WriteData(address: self.$width.address, data: width.bytes),
        WriteData(address: self.$speed.address, data: speed.bytes),
        WriteData(address: self.$regen.address, data: regen.bytes),
      ]
    }
    return self.writeData
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
public struct DC30Bank: WritableBank, Sendable, Hashable {
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

  package var writeData = [WriteData]()

  init(
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

  public init(
    type: DC30Type? = nil, inputVolume: UInt8? = nil, chorusIntensity: UInt8? = nil,
    repeatTime: UInt16? = nil, echoIntensity: UInt8? = nil, volume: UInt8? = nil,
    tone: UInt8? = nil, outputType: DC30OutputType? = nil
  ) {
    if let type {
      self.type = type
      self.writeData.append(WriteData(address: self.$type.address, data: type.rawValue.bytes))
    }
    if let inputVolume {
      self.inputVolume = inputVolume
      self.writeData.append(WriteData(address: self.$inputVolume.address, data: inputVolume.bytes))
    }
    if let chorusIntensity {
      self.chorusIntensity = chorusIntensity
      self.writeData.append(
        WriteData(address: self.$chorusIntensity.address, data: chorusIntensity.bytes))
    }
    if let repeatTime {
      self.repeatTime = repeatTime
      self.writeData.append(WriteData(address: self.$repeatTime.address, data: repeatTime.bytes))
    }
    if let echoIntensity {
      self.echoIntensity = echoIntensity
      self.writeData.append(
        WriteData(address: self.$echoIntensity.address, data: echoIntensity.bytes))
    }
    if let volume {
      self.volume = volume
      self.writeData.append(WriteData(address: self.$volume.address, data: volume.bytes))
    }
    if let tone {
      self.tone = tone
      self.writeData.append(WriteData(address: self.$tone.address, data: tone.bytes))
    }
    if let outputType {
      self.outputType = outputType
      self.writeData.append(
        WriteData(address: self.$outputType.address, data: outputType.rawValue.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$type.address, data: type.rawValue.bytes),
        WriteData(address: self.$inputVolume.address, data: inputVolume.bytes),
        WriteData(address: self.$chorusIntensity.address, data: chorusIntensity.bytes),
        WriteData(address: self.$repeatTime.address, data: repeatTime.bytes),
        WriteData(address: self.$echoIntensity.address, data: echoIntensity.bytes),
        WriteData(address: self.$volume.address, data: volume.bytes),
        WriteData(address: self.$tone.address, data: tone.bytes),
        WriteData(address: self.$outputType.address, data: outputType.rawValue.bytes),
      ]
    }
    return self.writeData
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
