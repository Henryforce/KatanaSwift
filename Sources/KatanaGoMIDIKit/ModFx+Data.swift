import KatanaGoData

extension ModFxParameter {
  var address: [UInt8] {
    switch self {
    case .enable:
      return [0x20, 0x00, 0x30, 0x01]
    case .type:
      return [0x20, 0x00, 0x60, 0x00]
    case .chorus(let parameter): return parameter.address
    case .flanger(let parameter): return parameter.address
    case .phaser(let parameter): return parameter.address
    case .uniVibe(let parameter): return parameter.address
    case .tremolo(let parameter): return parameter.address
    case .vibrato(let parameter): return parameter.address
    case .rotary(let parameter): return parameter.address
    case .ringMod(let parameter): return parameter.address
    case .slowGear(let parameter): return parameter.address
    case .slicer(let parameter): return parameter.address
    case .comp(let parameter): return parameter.address
    case .limiter(let parameter): return parameter.address
    case .tWah(let parameter): return parameter.address
    case .autoWah(let parameter): return parameter.address
    case .graphicEQ(let parameter): return parameter.address
    case .parametricEQ(let parameter): return parameter.address
    case .guitarSim(let parameter): return parameter.address
    case .acSim(let parameter): return parameter.address
    case .acousticPro(let parameter): return parameter.address
    case .waveSynth(let parameter): return parameter.address
    case .octaver(let parameter): return parameter.address
    case .heavyOctave(let parameter): return parameter.address
    case .pitchShifter(let parameter): return parameter.address
    case .harmonist(let parameter): return parameter.address
    case .humanizer(let parameter): return parameter.address
    case .phaser90E(let parameter): return parameter.address
    case .flanger117E(let parameter): return parameter.address
    case .dc30(let parameter): return parameter.address
    }
  }

  var values: [UInt8] {
    switch self {
    case .enable(let value):
      return [value ? 0x01 : 0x00]
    case .type(let value):
      return [value.rawValue]
    case .chorus(let parameter): return parameter.values
    case .flanger(let parameter): return parameter.values
    case .phaser(let parameter): return parameter.values
    case .uniVibe(let parameter): return parameter.values
    case .tremolo(let parameter): return parameter.values
    case .vibrato(let parameter): return parameter.values
    case .rotary(let parameter): return parameter.values
    case .ringMod(let parameter): return parameter.values
    case .slowGear(let parameter): return parameter.values
    case .slicer(let parameter): return parameter.values
    case .comp(let parameter): return parameter.values
    case .limiter(let parameter): return parameter.values
    case .tWah(let parameter): return parameter.values
    case .autoWah(let parameter): return parameter.values
    case .graphicEQ(let parameter): return parameter.values
    case .parametricEQ(let parameter): return parameter.values
    case .guitarSim(let parameter): return parameter.values
    case .acSim(let parameter): return parameter.values
    case .acousticPro(let parameter): return parameter.values
    case .waveSynth(let parameter): return parameter.values
    case .octaver(let parameter): return parameter.values
    case .heavyOctave(let parameter): return parameter.values
    case .pitchShifter(let parameter): return parameter.values
    case .harmonist(let parameter): return parameter.values
    case .humanizer(let parameter): return parameter.values
    case .phaser90E(let parameter): return parameter.values
    case .flanger117E(let parameter): return parameter.values
    case .dc30(let parameter): return parameter.values
    }
  }
}

extension ChorusParameter {
  fileprivate var address: [UInt8] {
    switch self {
    case .crossoverFrequency: return [0x20, 0x01, 0x00, 0x00]
    case .lowRate: return [0x20, 0x01, 0x00, 0x01]
    case .lowDepth: return [0x20, 0x01, 0x00, 0x02]
    case .lowPreDelay: return [0x20, 0x01, 0x00, 0x03]
    case .lowLevel: return [0x20, 0x01, 0x00, 0x04]
    case .highRate: return [0x20, 0x01, 0x00, 0x05]
    case .highDepth: return [0x20, 0x01, 0x00, 0x06]
    case .highPreDelay: return [0x20, 0x01, 0x00, 0x07]
    case .highLevel: return [0x20, 0x01, 0x00, 0x08]
    case .directMix: return [0x20, 0x01, 0x00, 0x09]
    }
  }

  fileprivate var values: [UInt8] {
    switch self {
    case .crossoverFrequency(let value), .lowRate(let value), .lowDepth(let value),
      .lowPreDelay(let value), .lowLevel(let value), .highRate(let value), .highDepth(let value),
      .highPreDelay(let value), .highLevel(let value), .directMix(let value):
      return [value]
    }
  }
}

extension FlangerParameter {
  fileprivate var address: [UInt8] {
    switch self {
    case .rate: return [0x20, 0x01, 0x00, 0x0A]
    case .depth: return [0x20, 0x01, 0x00, 0x0B]
    case .manual: return [0x20, 0x01, 0x00, 0x0C]
    case .resonance: return [0x20, 0x01, 0x00, 0x0D]
    case .lowCut: return [0x20, 0x01, 0x00, 0x0E]
    case .effectLevel: return [0x20, 0x01, 0x00, 0x0F]
    case .directLevel: return [0x20, 0x01, 0x00, 0x10]
    }
  }

  fileprivate var values: [UInt8] {
    switch self {
    case .rate(let value): return [value]
    case .depth(let value): return [value]
    case .manual(let value): return [value]
    case .resonance(let value): return [value]
    case .lowCut(let value): return [value.rawValue]
    case .effectLevel(let value): return [value]
    case .directLevel(let value): return [value]
    }
  }
}

extension PhaserParameter {
  fileprivate var address: [UInt8] {
    switch self {
    case .type: return [0x20, 0x01, 0x00, 0x11]
    case .rate: return [0x20, 0x01, 0x00, 0x12]
    case .depth: return [0x20, 0x01, 0x00, 0x13]
    case .manual: return [0x20, 0x01, 0x00, 0x14]
    case .resonance: return [0x20, 0x01, 0x00, 0x15]
    case .stepRate: return [0x20, 0x01, 0x00, 0x16]
    case .effectLevel: return [0x20, 0x01, 0x00, 0x17]
    case .directLevel: return [0x20, 0x01, 0x00, 0x18]
    }
  }

  fileprivate var values: [UInt8] {
    switch self {
    case .type(let value): return [value.rawValue]
    case .rate(let value), .depth(let value), .manual(let value),
      .resonance(let value), .stepRate(let value), .effectLevel(let value), .directLevel(let value):
      return [value]
    }
  }
}

extension UniVibeParameter {
  fileprivate var address: [UInt8] {
    switch self {
    case .rate: return [0x20, 0x01, 0x00, 0x19]
    case .depth: return [0x20, 0x01, 0x00, 0x1A]
    case .level: return [0x20, 0x01, 0x00, 0x1B]
    }
  }

  fileprivate var values: [UInt8] {
    switch self {
    case .rate(let value), .depth(let value), .level(let value):
      return [value]
    }
  }
}

extension TremoloParameter {
  fileprivate var address: [UInt8] {
    switch self {
    case .waveShape: return [0x20, 0x01, 0x00, 0x1C]
    case .rate: return [0x20, 0x01, 0x00, 0x1D]
    case .depth: return [0x20, 0x01, 0x00, 0x1E]
    case .level: return [0x20, 0x01, 0x00, 0x1F]
    }
  }

  fileprivate var values: [UInt8] {
    switch self {
    case .waveShape(let value), .rate(let value), .depth(let value), .level(let value):
      return [value]
    }
  }
}

extension VibratoParameter {
  fileprivate var address: [UInt8] {
    switch self {
    case .rate: return [0x20, 0x01, 0x00, 0x20]
    case .depth: return [0x20, 0x01, 0x00, 0x21]
    case .level: return [0x20, 0x01, 0x00, 0x22]
    }
  }

  fileprivate var values: [UInt8] {
    switch self {
    case .rate(let value), .depth(let value), .level(let value):
      return [value]
    }
  }
}

extension RotaryParameter {
  fileprivate var address: [UInt8] {
    switch self {
    case .rate: return [0x20, 0x01, 0x00, 0x23]
    case .depth: return [0x20, 0x01, 0x00, 0x24]
    case .level: return [0x20, 0x01, 0x00, 0x25]
    }
  }

  fileprivate var values: [UInt8] {
    switch self {
    case .rate(let value), .depth(let value), .level(let value):
      return [value]
    }
  }
}

extension RingModParameter {
  fileprivate var address: [UInt8] {
    switch self {
    case .mode: return [0x20, 0x01, 0x00, 0x26]
    case .frequency: return [0x20, 0x01, 0x00, 0x27]
    case .effectLevel: return [0x20, 0x01, 0x00, 0x28]
    case .directMix: return [0x20, 0x01, 0x00, 0x29]
    }
  }

  fileprivate var values: [UInt8] {
    switch self {
    case .mode(let value): return [value.rawValue]
    case .frequency(let value), .effectLevel(let value), .directMix(let value):
      return [value]
    }
  }
}

extension SlowGearParameter {
  fileprivate var address: [UInt8] {
    switch self {
    case .sens: return [0x20, 0x01, 0x00, 0x2A]
    case .riseTime: return [0x20, 0x01, 0x00, 0x2B]
    case .level: return [0x20, 0x01, 0x00, 0x2C]
    }
  }

  fileprivate var values: [UInt8] {
    switch self {
    case .sens(let value), .riseTime(let value), .level(let value):
      return [value]
    }
  }
}

extension SlicerParameter {
  fileprivate var address: [UInt8] {
    switch self {
    case .pattern: return [0x20, 0x01, 0x00, 0x2D]
    case .rate: return [0x20, 0x01, 0x00, 0x2E]
    case .triggerSens: return [0x20, 0x01, 0x00, 0x2F]
    case .effectLevel: return [0x20, 0x01, 0x00, 0x30]
    case .directMix: return [0x20, 0x01, 0x00, 0x31]
    }
  }

  fileprivate var values: [UInt8] {
    switch self {
    case .pattern(let value), .rate(let value), .triggerSens(let value),
      .effectLevel(let value), .directMix(let value):
      return [value]
    }
  }
}

extension CompParameter {
  fileprivate var address: [UInt8] {
    switch self {
    case .type: return [0x20, 0x01, 0x00, 0x32]
    case .sustain: return [0x20, 0x01, 0x00, 0x33]
    case .attack: return [0x20, 0x01, 0x00, 0x34]
    case .tone: return [0x20, 0x01, 0x00, 0x35]
    case .level: return [0x20, 0x01, 0x00, 0x36]
    }
  }

  fileprivate var values: [UInt8] {
    switch self {
    case .type(let value): return [value.rawValue]
    case .sustain(let value), .attack(let value), .tone(let value), .level(let value):
      return [value]
    }
  }
}

extension LimiterParameter {
  fileprivate var address: [UInt8] {
    switch self {
    case .type: return [0x20, 0x01, 0x00, 0x37]
    case .attack: return [0x20, 0x01, 0x00, 0x38]
    case .threshold: return [0x20, 0x01, 0x00, 0x39]
    case .ratio: return [0x20, 0x01, 0x00, 0x3A]
    case .release: return [0x20, 0x01, 0x00, 0x3B]
    case .level: return [0x20, 0x01, 0x00, 0x3C]
    }
  }

  fileprivate var values: [UInt8] {
    switch self {
    case .type(let value): return [value.rawValue]
    case .ratio(let value): return [value.rawValue]
    case .attack(let value), .threshold(let value), .release(let value), .level(let value):
      return [value]
    }
  }
}

extension TWahParameter {
  fileprivate var address: [UInt8] {
    switch self {
    case .mode: return [0x20, 0x01, 0x00, 0x3D]
    case .polarity: return [0x20, 0x01, 0x00, 0x3E]
    case .sens: return [0x20, 0x01, 0x00, 0x3F]
    case .frequency: return [0x20, 0x01, 0x00, 0x40]
    case .peak: return [0x20, 0x01, 0x00, 0x41]
    case .effectLevel: return [0x20, 0x01, 0x00, 0x42]
    case .directLevel: return [0x20, 0x01, 0x00, 0x43]
    }
  }

  fileprivate var values: [UInt8] {
    switch self {
    case .mode(let value): return [value.rawValue]
    case .polarity(let value): return [value.rawValue]
    case .sens(let value), .frequency(let value),
      .peak(let value), .effectLevel(let value), .directLevel(let value):
      return [value]
    }
  }
}

extension AutoWahParameter {
  var address: [UInt8] {
    switch self {
    case .mode: return [0x20, 0x01, 0x00, 0x44]
    case .frequency: return [0x20, 0x01, 0x00, 0x45]
    case .peak: return [0x20, 0x01, 0x00, 0x46]
    case .rate: return [0x20, 0x01, 0x00, 0x47]
    case .depth: return [0x20, 0x01, 0x00, 0x48]
    case .effectLevel: return [0x20, 0x01, 0x00, 0x49]
    case .directLevel: return [0x20, 0x01, 0x00, 0x4A]
    }
  }

  fileprivate var values: [UInt8] {
    switch self {
    case .mode(let value): return [value.rawValue]
    case .frequency(let value), .peak(let value), .rate(let value),
      .depth(let value), .effectLevel(let value), .directLevel(let value):
      return [value]
    }
  }
}

extension ModFxGraphicEQParameter {
  fileprivate var address: [UInt8] {
    switch self {
    case .band31Hz: return [0x20, 0x01, 0x00, 0x4B]
    case .band62Hz: return [0x20, 0x01, 0x00, 0x4C]
    case .band125Hz: return [0x20, 0x01, 0x00, 0x4D]
    case .band250Hz: return [0x20, 0x01, 0x00, 0x4E]
    case .band500Hz: return [0x20, 0x01, 0x00, 0x4F]
    case .band1kHz: return [0x20, 0x01, 0x00, 0x50]
    case .band2kHz: return [0x20, 0x01, 0x00, 0x51]
    case .band4kHz: return [0x20, 0x01, 0x00, 0x52]
    case .band8kHz: return [0x20, 0x01, 0x00, 0x53]
    case .band16kHz: return [0x20, 0x01, 0x00, 0x54]
    case .level: return [0x20, 0x01, 0x00, 0x55]
    }
  }

  fileprivate var values: [UInt8] {
    switch self {
    case .band31Hz(let value), .band62Hz(let value), .band125Hz(let value), .band250Hz(let value),
      .band500Hz(let value), .band1kHz(let value), .band2kHz(let value), .band4kHz(let value),
      .band8kHz(let value), .band16kHz(let value), .level(let value):
      return [value]
    }
  }
}

extension ModFxParametricEQParameter {
  fileprivate var address: [UInt8] {
    switch self {
    case .lowCut: return [0x20, 0x01, 0x00, 0x56]
    case .lowGain: return [0x20, 0x01, 0x00, 0x57]
    case .lowMidFreq: return [0x20, 0x01, 0x00, 0x58]
    case .lowMidQ: return [0x20, 0x01, 0x00, 0x59]
    case .lowMidGain: return [0x20, 0x01, 0x00, 0x5A]
    case .highMidFreq: return [0x20, 0x01, 0x00, 0x5B]
    case .highMidQ: return [0x20, 0x01, 0x00, 0x5C]
    case .highMidGain: return [0x20, 0x01, 0x00, 0x5D]
    case .highGain: return [0x20, 0x01, 0x00, 0x5E]
    case .highCut: return [0x20, 0x01, 0x00, 0x5F]
    case .level: return [0x20, 0x01, 0x00, 0x60]
    }
  }

  fileprivate var values: [UInt8] {
    switch self {
    case .lowCut(let value): return [value.rawValue]
    case .lowGain(let value): return [value]
    case .lowMidFreq(let value): return [value.rawValue]
    case .lowMidQ(let value): return [value.rawValue]
    case .lowMidGain(let value): return [value]
    case .highMidFreq(let value): return [value.rawValue]
    case .highMidQ(let value): return [value.rawValue]
    case .highMidGain(let value): return [value]
    case .highGain(let value): return [value]
    case .highCut(let value): return [value.rawValue]
    case .level(let value): return [value]
    }
  }
}

extension GuitarSimParameter {
  fileprivate var address: [UInt8] {
    switch self {
    case .type: return [0x20, 0x01, 0x00, 0x61]
    case .low: return [0x20, 0x01, 0x00, 0x62]
    case .high: return [0x20, 0x01, 0x00, 0x63]
    case .body: return [0x20, 0x01, 0x00, 0x64]
    case .level: return [0x20, 0x01, 0x00, 0x65]
    }
  }

  fileprivate var values: [UInt8] {
    switch self {
    case .type(let value): return [value.rawValue]
    case .low(let value), .high(let value), .body(let value), .level(let value):
      return [value]
    }
  }
}

extension ACSimParameter {
  fileprivate var address: [UInt8] {
    switch self {
    case .high: return [0x20, 0x01, 0x00, 0x66]
    case .body: return [0x20, 0x01, 0x00, 0x67]
    case .low: return [0x20, 0x01, 0x00, 0x68]
    case .level: return [0x20, 0x01, 0x00, 0x69]
    }
  }

  fileprivate var values: [UInt8] {
    switch self {
    case .high(let value), .body(let value), .low(let value), .level(let value):
      return [value]
    }
  }
}

extension AcousticProParameter {
  fileprivate var address: [UInt8] {
    switch self {
    case .type: return [0x20, 0x01, 0x00, 0x6A]
    case .bass: return [0x20, 0x01, 0x00, 0x6B]
    case .middle: return [0x20, 0x01, 0x00, 0x6C]
    case .midFrequency: return [0x20, 0x01, 0x00, 0x6D]
    case .treble: return [0x20, 0x01, 0x00, 0x6E]
    case .presence: return [0x20, 0x01, 0x00, 0x6F]
    case .level: return [0x20, 0x01, 0x00, 0x70]
    }
  }

  fileprivate var values: [UInt8] {
    switch self {
    case .type(let value): return [value.rawValue]
    case .midFrequency(let value): return [value.rawValue]
    case .bass(let value), .middle(let value),
      .treble(let value), .presence(let value), .level(let value):
      return [value]
    }
  }
}

extension WaveSynthParameter {
  fileprivate var address: [UInt8] {
    switch self {
    case .type: return [0x20, 0x01, 0x00, 0x71]
    case .cutoff: return [0x20, 0x01, 0x00, 0x72]
    case .resonance: return [0x20, 0x01, 0x00, 0x73]
    case .filterSens: return [0x20, 0x01, 0x00, 0x74]
    case .filterDecay: return [0x20, 0x01, 0x00, 0x75]
    case .filterDepth: return [0x20, 0x01, 0x00, 0x76]
    case .synthLevel: return [0x20, 0x01, 0x00, 0x77]
    case .directMix: return [0x20, 0x01, 0x00, 0x78]
    }
  }

  fileprivate var values: [UInt8] {
    switch self {
    case .type(let value): return [value.rawValue]
    case .cutoff(let value), .resonance(let value), .filterSens(let value),
      .filterDecay(let value), .filterDepth(let value), .synthLevel(let value),
      .directMix(let value):
      return [value]
    }
  }
}

extension OctaverParameter {
  fileprivate var address: [UInt8] {
    switch self {
    case .range: return [0x20, 0x01, 0x00, 0x79]
    case .level: return [0x20, 0x01, 0x00, 0x7A]
    case .directLevel: return [0x20, 0x01, 0x00, 0x7B]
    }
  }

  fileprivate var values: [UInt8] {
    switch self {
    case .range(let value): return [value.rawValue]
    case .level(let value), .directLevel(let value):
      return [value]
    }
  }
}

extension HeavyOctaveParameter {
  fileprivate var address: [UInt8] {
    switch self {
    case .octaveMinus1: return [0x20, 0x01, 0x00, 0x7C]
    case .octaveMinus2: return [0x20, 0x01, 0x00, 0x7D]
    case .directMix: return [0x20, 0x01, 0x00, 0x7E]
    }
  }

  fileprivate var values: [UInt8] {
    switch self {
    case .octaveMinus1(let value), .octaveMinus2(let value), .directMix(let value):
      return [value]
    }
  }
}

extension PitchShifterParameter {
  fileprivate var address: [UInt8] {
    switch self {
    case .voice: return [0x20, 0x01, 0x00, 0x7F]
    case .ps1Mode: return [0x20, 0x01, 0x01, 0x00]
    case .ps1Pitch: return [0x20, 0x01, 0x01, 0x01]
    case .ps1Fine: return [0x20, 0x01, 0x01, 0x02]
    case .ps1PreDelay: return [0x20, 0x01, 0x01, 0x03]
    case .ps1Level: return [0x20, 0x01, 0x01, 0x07]
    case .ps2Mode: return [0x20, 0x01, 0x01, 0x08]
    case .ps2Pitch: return [0x20, 0x01, 0x01, 0x09]
    case .ps2Fine: return [0x20, 0x01, 0x01, 0x0A]
    case .ps2PreDelay: return [0x20, 0x01, 0x01, 0x0B]
    case .ps2Level: return [0x20, 0x01, 0x01, 0x0F]
    case .ps1Feedback: return [0x20, 0x01, 0x01, 0x10]
    case .directLevel: return [0x20, 0x01, 0x01, 0x11]
    }
  }

  fileprivate var values: [UInt8] {
    switch self {
    case .voice(let value): return [value.rawValue]
    case .ps1Mode(let value), .ps2Mode(let value):
      return [value.rawValue]
    case .ps1Pitch(let value), .ps1Fine(let value),
      .ps1Level(let value), .ps2Pitch(let value), .ps2Fine(let value),
      .ps2Level(let value), .ps1Feedback(let value), .directLevel(let value):
      return [value]
    case .ps1PreDelay(let value), .ps2PreDelay(let value):
      return value.encodeToByteArray()
    }
  }
}

// TODO: audit these values as there is something wrong.
extension HarmonistParameter {
  fileprivate var address: [UInt8] {
    switch self {
    case .voice: return [0x20, 0x01, 0x01, 0x12]
    case .h1Harmony: return [0x20, 0x01, 0x01, 0x13]
    case .h1PreDelay: return [0x20, 0x01, 0x01, 0x14]
    case .h1Level: return [0x20, 0x01, 0x01, 0x18]
    case .h2Harmony: return [0x20, 0x01, 0x01, 0x19]
    case .h2PreDelay: return [0x20, 0x01, 0x01, 0x1A]
    case .h2Level: return [0x20, 0x01, 0x01, 0x1E]
    case .h1Feedback: return [0x20, 0x01, 0x01, 0x1F]
    case .directLevel: return [0x20, 0x01, 0x01, 0x20]
    }
  }

  fileprivate var values: [UInt8] {
    switch self {
    case .voice(let value): return [value.rawValue]
    case .h1Harmony(let value), .h2Harmony(let value):
      return [value.rawValue]
    case .h1Level(let value), .h2Level(let value), .h1Feedback(let value), .directLevel(let value):
      return [value]
    case .h1PreDelay(let value), .h2PreDelay(let value):
      return value.encodeToByteArray()
    }
  }
}

extension HumanizerParameter {
  fileprivate var address: [UInt8] {
    switch self {
    case .mode: return [0x20, 0x01, 0x01, 0x39]
    case .vowel1: return [0x20, 0x01, 0x01, 0x3A]
    case .vowel2: return [0x20, 0x01, 0x01, 0x3B]
    case .sens: return [0x20, 0x01, 0x01, 0x3C]
    case .rate: return [0x20, 0x01, 0x01, 0x3D]
    case .depth: return [0x20, 0x01, 0x01, 0x3E]
    case .manual: return [0x20, 0x01, 0x01, 0x3F]
    case .level: return [0x20, 0x01, 0x01, 0x40]
    }
  }

  fileprivate var values: [UInt8] {
    switch self {
    case .mode(let value): return [value.rawValue]
    case .vowel1(let value), .vowel2(let value): return [value.rawValue]
    case .sens(let value), .rate(let value), .depth(let value), .manual(let value),
      .level(let value):
      return [value]
    }
  }
}

extension Phaser90EParameter {
  fileprivate var address: [UInt8] {
    switch self {
    case .scriptEnable: return [0x20, 0x01, 0x01, 0x41]
    case .speed: return [0x20, 0x01, 0x01, 0x42]
    }
  }

  fileprivate var values: [UInt8] {
    switch self {
    case .scriptEnable(let value): return [value ? 0x01 : 0x00]
    case .speed(let value): return [value]
    }
  }
}

extension Flanger117EParameter {
  fileprivate var address: [UInt8] {
    switch self {
    case .manual: return [0x20, 0x01, 0x01, 0x43]
    case .width: return [0x20, 0x01, 0x01, 0x44]
    case .speed: return [0x20, 0x01, 0x01, 0x45]
    case .regen: return [0x20, 0x01, 0x01, 0x46]
    }
  }

  fileprivate var values: [UInt8] {
    switch self {
    case .manual(let value), .width(let value), .speed(let value), .regen(let value):
      return [value]
    }
  }
}

extension DC30Parameter {
  fileprivate var address: [UInt8] {
    switch self {
    case .type: return [0x20, 0x01, 0x01, 0x47]
    case .inputVolume: return [0x20, 0x01, 0x01, 0x48]
    case .intensity: return [0x20, 0x01, 0x01, 0x49]
    case .repeatTime: return [0x20, 0x01, 0x01, 0x4A]
    case .volume: return [0x20, 0x01, 0x01, 0x4F]
    case .tone: return [0x20, 0x01, 0x01, 0x50]
    case .outputType: return [0x20, 0x01, 0x01, 0x51]
    }
  }

  fileprivate var values: [UInt8] {
    switch self {
    case .type(let value): return [value.rawValue]
    case .outputType(let value): return [value.rawValue]
    case .repeatTime(let value): return value.encodeToByteArray()
    case .inputVolume(let value), .intensity(let value),
      .volume(let value), .tone(let value):
      return [value]
    }
  }
}

extension DataBank {
  func buildModBank() -> ModFxBank {
    return buildModFxBank(
      status: self.effectsOnOffBank[1] == 1,
      type: ModFxType(rawValue: self.modTypeBank[0]) ?? .chorus,
      bank: self.modBank
    )
  }

  func buildFxBank() -> ModFxBank {
    return buildModFxBank(
      status: self.effectsOnOffBank[2] == 1,
      type: ModFxType(rawValue: self.fxTypeBank[0]) ?? .chorus,
      bank: self.fxBank
    )
  }

  private func buildModFxBank(status: Bool, type: ModFxType, bank: [UInt8]) -> ModFxBank {
    return ModFxBank(
      status: status,
      type: type,
      chorus: ChorusBank(
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
      ),
      flanger: FlangerBank(
        rate: bank[0x0A],
        depth: bank[0x0B],
        manual: bank[0x0C],
        resonance: bank[0x0D],
        lowCut: FlangerLowCut(rawValue: bank[0x0E]) ?? .flat,
        effectLevel: bank[0x0F],
        directLevel: bank[0x10]
      ),
      phaser: PhaserBank(
        type: PhaserType(rawValue: bank[0x11]) ?? .fourStage,
        rate: bank[0x12],
        depth: bank[0x13],
        manual: bank[0x14],
        resonance: bank[0x15],
        stepRate: bank[0x16],
        effectLevel: bank[0x17],
        directLevel: bank[0x18]
      ),
      uniVibe: UniVibeBank(
        rate: bank[0x19],
        depth: bank[0x1A],
        level: bank[0x1B]
      ),
      tremolo: TremoloBank(
        waveShape: bank[0x1C],
        rate: bank[0x1D],
        depth: bank[0x1E],
        level: bank[0x1F]
      ),
      vibrato: VibratoBank(
        rate: bank[0x20],
        depth: bank[0x21],
        level: bank[0x22]
      ),
      rotary: RotaryBank(
        rate: bank[0x23],
        depth: bank[0x24],
        level: bank[0x25]
      ),
      ringMod: RingModBank(
        mode: RingModMode(rawValue: bank[0x26]) ?? .normal,
        frequency: bank[0x27],
        effectLevel: bank[0x28],
        directMix: bank[0x29]
      ),
      slowGear: SlowGearBank(
        sens: bank[0x2A],
        riseTime: bank[0x2B],
        level: bank[0x2C]
      ),
      slicer: SlicerBank(
        pattern: bank[0x2D],
        rate: bank[0x2E],
        triggerSens: bank[0x2F],
        effectLevel: bank[0x30],
        directMix: bank[0x31]
      ),
      comp: CompBank(
        type: CompType(rawValue: bank[0x32]) ?? .boss,
        sustain: bank[0x33],
        attack: bank[0x34],
        tone: bank[0x35],
        level: bank[0x36]
      ),
      limiter: LimiterBank(
        type: LimiterType(rawValue: bank[0x37]) ?? .boss,
        attack: bank[0x38],
        threshold: bank[0x39],
        ratio: LimiterRatio(rawValue: bank[0x3A]) ?? .oneToOne,
        release: bank[0x3B],
        level: bank[0x3C]
      ),
      tWah: TWahBank(
        mode: WahMode(rawValue: bank[0x3D]) ?? .lowPassFilter,
        polarity: TWahPolarity(rawValue: bank[0x3E]) ?? .down,
        sens: bank[0x3F],
        frequency: bank[0x40],
        peak: bank[0x41],
        effectLevel: bank[0x42],
        directLevel: bank[0x43]
      ),
      autoWah: AutoWahBank(
        mode: WahMode(rawValue: bank[0x44]) ?? .lowPassFilter,
        frequency: bank[0x45],
        peak: bank[0x46],
        rate: bank[0x47],
        depth: bank[0x48],
        effectLevel: bank[0x49],
        directLevel: bank[0x4A]
      ),
      graphicEQ: ModFxGraphicEQBank(
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
      ),
      parametricEQ: ModFxParametricEQBank(
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
      ),
      guitarSim: GuitarSimBank(
        type: GuitarSimType(rawValue: bank[0x61]) ?? .sToH,
        low: bank[0x62],
        high: bank[0x63],
        body: bank[0x64],
        level: bank[0x65]
      ),
      acSim: ACSimBank(
        high: bank[0x66],
        body: bank[0x67],
        low: bank[0x68],
        level: bank[0x69]
      ),
      acousticPro: AcousticProBank(
        type: AcousticProType(rawValue: bank[0x6A]) ?? .small,
        bass: bank[0x6B],
        middle: bank[0x6C],
        midFrequency: EQFrequency(rawValue: bank[0x6D]) ?? .freq20Hz,
        treble: bank[0x6E],
        presence: bank[0x6F],
        level: bank[0x70]
      ),
      waveSynth: WaveSynthBank(
        type: WaveSynthType(rawValue: bank[0x71]) ?? .saw,
        cutoff: bank[0x72],
        resonance: bank[0x73],
        filterSens: bank[0x74],
        filterDecay: bank[0x75],
        filterDepth: bank[0x76],
        synthLevel: bank[0x77],
        directMix: bank[0x78]
      ),
      octaver: OctaverBank(
        range: OctaverRange(rawValue: bank[0x79]) ?? .range1,
        level: bank[0x7A],
        directLevel: bank[0x7B]
      ),
      heavyOctave: HeavyOctaveBank(
        octaveMinus1: bank[0x7C],
        octaveMinus2: bank[0x7D],
        directMix: bank[0x7E]
      ),
      pitchShifter: PitchShifterBank(
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
      ),
      harmonist: HarmonistBank(
        voice: HarmonistVoice(rawValue: bank[146]) ?? .oneVoice,
        h1Harmony: HarmonistHarmony(rawValue: bank[147]) ?? .unison,
        h1PreDelay: UInt16.decodeFromByteArray([bank[148], bank[149], bank[150], bank[151]]),
        h1Level: bank[152],
        h2Harmony: HarmonistHarmony(rawValue: bank[153]) ?? .unison,
        h2PreDelay: UInt16.decodeFromByteArray([bank[154], bank[155], bank[156], bank[157]]),
        h2Level: bank[158],
        h1Feedback: bank[159],
        directLevel: bank[160]
      ),
      humanizer: HumanizerBank(
        mode: HumanizerMode(rawValue: bank[185]) ?? .picking,
        vowel1: HumanizerWovel(rawValue: bank[186]) ?? .a,
        vowel2: HumanizerWovel(rawValue: bank[187]) ?? .a,
        sens: bank[188],
        rate: bank[189],
        depth: bank[190],
        manual: bank[191],
        level: bank[192]
      ),
      phaser90E: Phaser90EBank(
        scriptStatus: bank[193] == 1,
        speed: bank[194]
      ),
      flanger117E: Flanger117EBank(
        manual: bank[195],
        width: bank[196],
        speed: bank[197],
        regen: bank[198]
      ),
      // TODO: audit these parameters as there seem to be a repeated intensity parameter.
      dc30: DC30Bank(
        type: DC30Type(rawValue: bank[199]) ?? .chorus,
        inputVolume: bank[200],
        intensity: bank[201],
        repeatTime: UInt16.decodeFromByteArray([bank[202], bank[203], bank[204], bank[205]]),
        volume: bank[207],
        tone: bank[208],
        outputType: DC30OutputType(rawValue: bank[209]) ?? .dPlusE
      )
    )
  }
}
