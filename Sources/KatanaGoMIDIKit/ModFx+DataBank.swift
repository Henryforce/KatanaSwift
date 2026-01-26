import KatanaEQ
import KatanaFx
import KatanaGoData

extension DataBank {
  func buildModSelectionBank() -> ModSelectionBank {
    return ModSelectionBank(
      type: ModFxType(rawValue: self.modTypeBank[0]) ?? .chorus
    )
  }

  func buildFxSelectionBank() -> FxSelectionBank {
    return FxSelectionBank(
      type: ModFxType(rawValue: self.fxTypeBank[0]) ?? .chorus
    )
  }

  func buildModBank() -> ModFxBank {
    return buildModFxBank(bank: self.modBank)
  }

  func buildFxBank() -> ModFxBank {
    return buildModFxBank(bank: self.fxBank)
  }

  func buildChorusBank(bank: [UInt8]) -> ChorusBank {
    return ChorusBank(
      crossoverFrequency: bank[0x00],
      lowRate: bank[0x01],
      lowDepth: bank[0x02],
      lowPreDelay: bank[0x03],
      lowLevel: bank[0x04],
      highRate: bank[0x05],
      highDepth: bank[0x06],
      highPreDelay: bank[0x07],
      highLevel: bank[0x08],
      directMix: bank[0x09]
    )
  }

  func buildFlangerBank(bank: [UInt8]) -> FlangerBank {
    return FlangerBank(
      rate: bank[0x0A],
      depth: bank[0x0B],
      manual: bank[0x0C],
      resonance: bank[0x0D],
      lowCut: FlangerLowCut(rawValue: bank[0x0E]) ?? .flat,
      effectLevel: bank[0x0F],
      directLevel: bank[0x10]
    )
  }

  func buildPhaserBank(bank: [UInt8]) -> PhaserBank {
    return PhaserBank(
      type: PhaserType(rawValue: bank[0x11]) ?? .fourStage,
      rate: bank[0x12],
      depth: bank[0x13],
      manual: bank[0x14],
      resonance: bank[0x15],
      stepRate: bank[0x16],
      effectLevel: bank[0x17],
      directLevel: bank[0x18]
    )
  }

  func buildUniVibeBank(bank: [UInt8]) -> UniVibeBank {
    return UniVibeBank(
      rate: bank[0x19],
      depth: bank[0x1A],
      level: bank[0x1B]
    )
  }

  func buildTremoloBank(bank: [UInt8]) -> TremoloBank {
    return TremoloBank(
      waveShape: bank[0x1C],
      rate: bank[0x1D],
      depth: bank[0x1E],
      level: bank[0x1F]
    )
  }

  func buildVibratoBank(bank: [UInt8]) -> VibratoBank {
    return VibratoBank(
      rate: bank[0x20],
      depth: bank[0x21],
      level: bank[0x22]
    )
  }

  func buildRotaryBank(bank: [UInt8]) -> RotaryBank {
    return RotaryBank(
      rate: bank[0x23],
      depth: bank[0x24],
      level: bank[0x25]
    )
  }

  func buildRingModBank(bank: [UInt8]) -> RingModBank {
    return RingModBank(
      mode: RingModMode(rawValue: bank[0x26]) ?? .normal,
      frequency: bank[0x27],
      effectLevel: bank[0x28],
      directMix: bank[0x29]
    )
  }

  func buildSlowGearBank(bank: [UInt8]) -> SlowGearBank {
    return SlowGearBank(
      sens: bank[0x2A],
      riseTime: bank[0x2B],
      level: bank[0x2C]
    )
  }

  func buildSlicerBank(bank: [UInt8]) -> SlicerBank {
    return SlicerBank(
      pattern: bank[0x2D],
      rate: bank[0x2E],
      triggerSens: bank[0x2F],
      effectLevel: bank[0x30],
      directMix: bank[0x31]
    )
  }

  func buildCompBank(bank: [UInt8]) -> CompBank {
    return CompBank(
      type: CompType(rawValue: bank[0x32]) ?? .boss,
      sustain: bank[0x33],
      attack: bank[0x34],
      tone: bank[0x35],
      level: bank[0x36]
    )
  }

  func buildLimiterBank(bank: [UInt8]) -> LimiterBank {
    return LimiterBank(
      type: LimiterType(rawValue: bank[0x37]) ?? .boss,
      attack: bank[0x38],
      threshold: bank[0x39],
      ratio: LimiterRatio(rawValue: bank[0x3A]) ?? .oneToOne,
      release: bank[0x3B],
      level: bank[0x3C]
    )
  }

  func buildTWahBank(bank: [UInt8]) -> TWahBank {
    return TWahBank(
      mode: WahMode(rawValue: bank[0x3D]) ?? .lowPassFilter,
      polarity: TWahPolarity(rawValue: bank[0x3E]) ?? .down,
      sens: bank[0x3F],
      frequency: bank[0x40],
      peak: bank[0x41],
      effectLevel: bank[0x42],
      directLevel: bank[0x43]
    )
  }

  func buildAutoWahBank(bank: [UInt8]) -> AutoWahBank {
    return AutoWahBank(
      mode: WahMode(rawValue: bank[0x44]) ?? .lowPassFilter,
      frequency: bank[0x45],
      peak: bank[0x46],
      rate: bank[0x47],
      depth: bank[0x48],
      effectLevel: bank[0x49],
      directLevel: bank[0x4A]
    )
  }

  func buildGraphicEQBank(bank: [UInt8]) -> ModFxGraphicEQBank {
    return ModFxGraphicEQBank(
      band31Hz: bank[0x4B],
      band62Hz: bank[0x4C],
      band125Hz: bank[0x4D],
      band250Hz: bank[0x4E],
      band500Hz: bank[0x4F],
      band1kHz: bank[0x50],
      band2kHz: bank[0x51],
      band4kHz: bank[0x52],
      band8kHz: bank[0x53],
      band16kHz: bank[0x54],
      level: bank[0x55]
    )
  }

  func buildParametricEQBank(bank: [UInt8]) -> ModFxParametricEQBank {
    return ModFxParametricEQBank(
      lowCut: EQLowCut(rawValue: bank[0x56]) ?? .flat,
      lowGain: bank[0x57],
      lowMidFreq: EQFrequency(rawValue: bank[0x58]) ?? .freq20Hz,
      lowMidQ: EQQ(rawValue: bank[0x59]) ?? .q05,
      lowMidGain: bank[0x5A],
      highMidFreq: EQFrequency(rawValue: bank[0x5B]) ?? .freq20Hz,
      highMidQ: EQQ(rawValue: bank[0x5C]) ?? .q05,
      highMidGain: bank[0x5D],
      highGain: bank[0x5E],
      highCut: EQHighCut(rawValue: bank[0x5F]) ?? .freq630Hz,
      level: bank[0x60]
    )
  }

  func buildGuitarSimBank(bank: [UInt8]) -> GuitarSimBank {
    return GuitarSimBank(
      type: GuitarSimType(rawValue: bank[0x61]) ?? .sToH,
      low: bank[0x62],
      high: bank[0x63],
      body: bank[0x64],
      level: bank[0x65]
    )
  }

  func buildACSimBank(bank: [UInt8]) -> ACSimBank {
    return ACSimBank(
      high: bank[0x66],
      body: bank[0x67],
      low: bank[0x68],
      level: bank[0x69]
    )
  }

  func buildAcousticProBank(bank: [UInt8]) -> AcousticProBank {
    return AcousticProBank(
      type: AcousticProType(rawValue: bank[0x6A]) ?? .small,
      bass: bank[0x6B],
      middle: bank[0x6C],
      midFrequency: EQFrequency(rawValue: bank[0x6D]) ?? .freq20Hz,
      treble: bank[0x6E],
      presence: bank[0x6F],
      level: bank[0x70]
    )
  }

  func buildWaveSynthBank(bank: [UInt8]) -> WaveSynthBank {
    return WaveSynthBank(
      type: WaveSynthType(rawValue: bank[0x71]) ?? .saw,
      cutoff: bank[0x72],
      resonance: bank[0x73],
      filterSens: bank[0x74],
      filterDecay: bank[0x75],
      filterDepth: bank[0x76],
      synthLevel: bank[0x77],
      directMix: bank[0x78]
    )
  }

  func buildOctaverBank(bank: [UInt8]) -> OctaverBank {
    return OctaverBank(
      range: OctaverRange(rawValue: bank[0x79]) ?? .range1,
      level: bank[0x7A],
      directLevel: bank[0x7B]
    )
  }

  func buildHeavyOctaveBank(bank: [UInt8]) -> HeavyOctaveBank {
    return HeavyOctaveBank(
      octaveMinus1: bank[0x7C],
      octaveMinus2: bank[0x7D],
      directMix: bank[0x7E]
    )
  }

  func buildPitchShifterBank(bank: [UInt8]) -> PitchShifterBank {
    return PitchShifterBank(
      voice: PitchShifterVoice(rawValue: bank[127]) ?? .oneVoice,
      ps1Mode: PitchShifterMode(rawValue: bank[128]) ?? .fast,
      ps1Pitch: bank[129],
      ps1Fine: bank[130],
      ps1PreDelay: UInt16.decodeFromByteArray([bank[131], bank[132], bank[133], bank[134]]),
      ps1Level: bank[135],
      ps2Mode: PitchShifterMode(rawValue: bank[136]) ?? .fast,
      ps2Pitch: bank[137],
      ps2Fine: bank[138],
      ps2PreDelay: UInt16.decodeFromByteArray([bank[139], bank[140], bank[141], bank[142]]),
      ps2Level: bank[143],
      ps1Feedback: bank[144],
      directLevel: bank[145]
    )
  }

  func buildHarmonistBank(bank: [UInt8]) -> HarmonistBank {
    return HarmonistBank(
      voice: HarmonistVoice(rawValue: bank[146]) ?? .oneVoice,
      h1Harmony: HarmonistHarmony(rawValue: bank[147]) ?? .unison,
      h1PreDelay: UInt16.decodeFromByteArray([bank[148], bank[149], bank[150], bank[151]]),
      h1Level: bank[152],
      h2Harmony: HarmonistHarmony(rawValue: bank[153]) ?? .unison,
      h2PreDelay: UInt16.decodeFromByteArray([bank[154], bank[155], bank[156], bank[157]]),
      h2Level: bank[158],
      h1Feedback: bank[159],
      directLevel: bank[160]
    )
  }

  func buildHumanizerBank(bank: [UInt8]) -> HumanizerBank {
    return HumanizerBank(
      mode: HumanizerMode(rawValue: bank[185]) ?? .picking,
      vowel1: HumanizerWovel(rawValue: bank[186]) ?? .a,
      vowel2: HumanizerWovel(rawValue: bank[187]) ?? .a,
      sens: bank[188],
      rate: bank[189],
      depth: bank[190],
      manual: bank[191],
      level: bank[192]
    )
  }

  func buildPhaser90EBank(bank: [UInt8]) -> Phaser90EBank {
    return Phaser90EBank(
      scriptStatus: bank[193] == 1,
      speed: bank[194]
    )
  }

  func buildFlanger117EBank(bank: [UInt8]) -> Flanger117EBank {
    return Flanger117EBank(
      manual: bank[195],
      width: bank[196],
      speed: bank[197],
      regen: bank[198]
    )
  }

  func buildDC30Bank(bank: [UInt8]) -> DC30Bank {
    return DC30Bank(
      type: DC30Type(rawValue: bank[199]) ?? .chorus,
      inputVolume: bank[200],
      chorusIntensity: bank[201],
      repeatTime: UInt16.decodeFromByteArray([bank[202], bank[203], bank[204], bank[205]]),
      echoIntensity: bank[206],
      volume: bank[207],
      tone: bank[208],
      outputType: DC30OutputType(rawValue: bank[209]) ?? .dPlusE
    )
  }

  private func buildModFxBank(bank: [UInt8]) -> ModFxBank {
    return ModFxBank(
      chorus: buildChorusBank(bank: bank),
      flanger: buildFlangerBank(bank: bank),
      phaser: buildPhaserBank(bank: bank),
      uniVibe: buildUniVibeBank(bank: bank),
      tremolo: buildTremoloBank(bank: bank),
      vibrato: buildVibratoBank(bank: bank),
      rotary: buildRotaryBank(bank: bank),
      ringMod: buildRingModBank(bank: bank),
      slowGear: buildSlowGearBank(bank: bank),
      slicer: buildSlicerBank(bank: bank),
      comp: buildCompBank(bank: bank),
      limiter: buildLimiterBank(bank: bank),
      tWah: buildTWahBank(bank: bank),
      autoWah: buildAutoWahBank(bank: bank),
      graphicEQ: buildGraphicEQBank(bank: bank),
      parametricEQ: buildParametricEQBank(bank: bank),
      guitarSim: buildGuitarSimBank(bank: bank),
      acSim: buildACSimBank(bank: bank),
      acousticPro: buildAcousticProBank(bank: bank),
      waveSynth: buildWaveSynthBank(bank: bank),
      octaver: buildOctaverBank(bank: bank),
      heavyOctave: buildHeavyOctaveBank(bank: bank),
      pitchShifter: buildPitchShifterBank(bank: bank),
      harmonist: buildHarmonistBank(bank: bank),
      humanizer: buildHumanizerBank(bank: bank),
      phaser90E: buildPhaser90EBank(bank: bank),
      flanger117E: buildFlanger117EBank(bank: bank),
      dc30: buildDC30Bank(bank: bank)
    )
  }
}
