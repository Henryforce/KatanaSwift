import KatanaCore
import KatanaEQ
import KatanaFx
import KatanaMacros

@KatanaBank
public struct ModSelectionBank: KatanaGoBank, Sendable, Hashable {
  @Parameter(at: 0x00)
  public var type: ModFxType = .chorus

  public static let katanaGoAddress: UInt32 = 0x20_00_60_00

  public static let size: UInt32 = 1
}

@KatanaBank
public struct FxSelectionBank: KatanaGoBank, Sendable, Hashable {
  @Parameter(at: 0x00)
  public var type: ModFxType = .chorus

  public static let katanaGoAddress: UInt32 = 0x20_00_70_00

  public static let size: UInt32 = 1
}

// TODO: re-audit these values.
/// Available MOD/FX types for the Katana GO.
public enum ModFxType: UInt8, KatanaByteCodable, Sendable, Hashable, CaseIterable {
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
