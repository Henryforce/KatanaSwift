import Foundation

/// Available MOD/FX types for the Katana GO in Bass Mode.
public enum BassModFXType: UInt8, Sendable, Hashable, CaseIterable {
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
