import Foundation

/// Parameters for System settings.
public enum SystemParameter: Sendable {
  case midiChannel
  case toEffectLevel
  case effectOutLevel
  case mixLevel
  case loopBack
  case dryOutLevel
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

/// Parameters for the Noise Gate.
public enum NoiseGateParameter: Sendable {
  case on
  case threshold
  case release
}
