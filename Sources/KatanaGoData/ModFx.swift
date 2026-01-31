import KatanaCore
import KatanaEQ
import KatanaFx
import KatanaMacros

/// A bank of parameters for the MOD/FX section.
public protocol KatanaGoFxBank: WritableBank {}

@KatanaBank
public struct ModSelectionBank: Sendable, Hashable {
  @Parameter(at: 0x00)
  public var type: ModFxType = .chorus

  public static let address: UInt32 = 0x20_00_60_00

  public static let size: UInt32 = 1
}

@KatanaBank
public struct FxSelectionBank: Sendable, Hashable {
  @Parameter(at: 0x00)
  public var type: ModFxType = .chorus

  public static let address: UInt32 = 0x20_00_70_00

  public static let size: UInt32 = 1
}

/// The data bank representing the MOD/FX parameters.
public struct ModFxBank: Sendable, Hashable {
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
    chorus: ChorusBank, flanger: FlangerBank, phaser: PhaserBank,
    uniVibe: UniVibeBank, tremolo: TremoloBank, vibrato: VibratoBank, rotary: RotaryBank,
    ringMod: RingModBank, slowGear: SlowGearBank, slicer: SlicerBank, comp: CompBank,
    limiter: LimiterBank, tWah: TWahBank, autoWah: AutoWahBank, graphicEQ: ModFxGraphicEQBank,
    parametricEQ: ModFxParametricEQBank, guitarSim: GuitarSimBank, acSim: ACSimBank,
    acousticPro: AcousticProBank, waveSynth: WaveSynthBank, octaver: OctaverBank,
    heavyOctave: HeavyOctaveBank, pitchShifter: PitchShifterBank, harmonist: HarmonistBank,
    humanizer: HumanizerBank, phaser90E: Phaser90EBank, flanger117E: Flanger117EBank, dc30: DC30Bank
  ) {
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
