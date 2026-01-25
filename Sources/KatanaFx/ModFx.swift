import KatanaCore
import KatanaMacros

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
@KatanaUInt8RawBytes
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
