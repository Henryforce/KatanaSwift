import KatanaCore
import KatanaEQ
import KatanaFx
import KatanaMacros

// MARK: - BASS ENHANCER

@KatanaBank
public struct BassEnhancerBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00, range: 0...100)
  public var sense: UInt8 = 50

  @IntegerParameter(at: 0x01, range: 0...100)
  public var lowLevel: UInt8 = 50

  @Parameter(at: 0x02)
  public var lowFreq: BassLowFrequency = .freq63Hz

  @IntegerParameter(at: 0x03, range: 0...100)
  public var highLevel: UInt8 = 50

  @Parameter(at: 0x04)
  public var highFreq: BassHighFrequency = .freq5kHz

  public static let address: UInt32 = 0x20_01_01_52

  public static let size: UInt32 = 5
}

// MARK: - BASS SIMULATOR

@KatanaBank
public struct BassSimulatorBank: Sendable, Hashable {
  @Parameter(at: 0x00)
  public var type: BassSimType = .pasToAct

  @IntegerParameter(at: 0x01, range: 0...100)
  public var low: UInt8 = 50

  @IntegerParameter(at: 0x02, range: 0...100)
  public var high: UInt8 = 50

  @IntegerParameter(at: 0x03, range: 0...100)
  public var level: UInt8 = 100

  @IntegerParameter(at: 0x04, range: 0...100)
  public var body: UInt8 = 50

  public static let address: UInt32 = 0x20_01_01_57

  public static let size: UInt32 = 5
}

// MARK: - MOD BASS DE-FR

@KatanaBank
public struct BassDeFretterBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00, range: 0...100)
  public var sense: UInt8 = 50

  @IntegerParameter(at: 0x01, range: 0...100)
  public var attack: UInt8 = 70

  @IntegerParameter(at: 0x02, range: 0...100)
  public var tone: UInt8 = 50

  @IntegerParameter(at: 0x05, range: 0...100)
  public var effect: UInt8 = 50

  @IntegerParameter(at: 0x06, range: 0...100)
  public var directMix: UInt8 = 100

  public static let address: UInt32 = 0x20_01_01_5C

  public static let size: UInt32 = 7
}

// MARK: - MOD BASS OCT

@KatanaBank
public struct BassOctaveBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00, range: 0...100)
  public var tenCTLevel: UInt8 = 50

  @IntegerParameter(at: 0x01, range: 0...100)
  public var twentyCTLevel: UInt8 = 0

  @IntegerParameter(at: 0x02, range: 0...100)
  public var directMix: UInt8 = 100

  public static let address: UInt32 = 0x20_01_01_63

  public static let size: UInt32 = 3
}

// MARK: - MOD BASS T-Wah

@KatanaBank
public struct BassTWahBank: Sendable, Hashable {
  @Parameter(at: 0x00)
  public var mode: WahMode = .lowPassFilter

  @Parameter(at: 0x01)
  public var polarity: TWahPolarity = .up

  @IntegerParameter(at: 0x02, range: 0...100)
  public var sens: UInt8 = 50

  @IntegerParameter(at: 0x03, range: 0...100)
  public var frequency: UInt8 = 35

  @IntegerParameter(at: 0x04, range: 0...100)
  public var peak: UInt8 = 35

  @IntegerParameter(at: 0x05, range: 0...100)
  public var effectLevel: UInt8 = 50

  @IntegerParameter(at: 0x06, range: 0...100)
  public var directLevel: UInt8 = 0

  public static let address: UInt32 = 0x20_01_01_66

  public static let size: UInt32 = 7
}

// MARK: - MOD BASS Synth

/// The data bank representing the BASS MOD/FX parameters.
@KatanaBank
public struct BassSynthBank: Sendable, Hashable {

  @Parameter(at: 0x00)
  public var wave: WaveSynthType = .saw

  @IntegerParameter(at: 0x01, range: 0...100)
  public var cutoff: UInt8 = 40

  @IntegerParameter(at: 0x02, range: 0...100)
  public var resonance: UInt8 = 30

  @IntegerParameter(at: 0x03, range: 0...100)
  public var filterSens: UInt8 = 40

  @IntegerParameter(at: 0x04, range: 0...100)
  public var filterDecay: UInt8 = 50

  @IntegerParameter(at: 0x05, range: 0...100)
  public var filterDepth: UInt8 = 50

  @IntegerParameter(at: 0x06, range: 0...100)
  public var synthLevel: UInt8 = 25

  @IntegerParameter(at: 0x07, range: 0...100)
  public var directMix: UInt8 = 0

  public static let address: UInt32 = 0x20_01_01_6D

  public static let size: UInt32 = 8
}

// MARK: - MOD BASS Options

/// Available MOD/FX types for the Katana GO in Bass Mode.
@KatanaUInt8RawBytes
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

@KatanaBank
public struct BassCompressorBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00, range: 0...100)
  public var threshold: UInt8 = 50

  @IntegerParameter(at: 0x01, range: 0...100)
  public var ratio: UInt8 = 50

  @IntegerParameter(at: 0x02, range: 0...100)
  public var attack: UInt8 = 50

  @IntegerParameter(at: 0x03, range: 0...100)
  public var release: UInt8 = 50

  @IntegerParameter(at: 0x04, range: 0...100)
  public var makeup: UInt8 = 50

  @IntegerParameter(at: 0x05, range: 0...100)
  public var blend: UInt8 = 50

  public static let address: UInt32 = 0x20_01_01_75

  public static let size: UInt32 = 6
}

@KatanaUInt8RawBytes
public enum BassSimType: UInt8, Sendable, Hashable, CaseIterable {
  case pasToAct = 0x00
  case actToPas = 0x01
  case sglToHum = 0x02
  case humToSgl = 0x03
  case sldToHlw = 0x04
  case sglToAc = 0x05
  case acToSgl = 0x06
}

@KatanaUInt8RawBytes
public enum BassLowFrequency: UInt8, Sendable, Hashable, CaseIterable {
  case freq31Hz5 = 0x00
  case freq40Hz = 0x01
  case freq50Hz = 0x02
  case freq63Hz = 0x03
  case freq80Hz = 0x04
  case freq100Hz = 0x05
  case freq125Hz = 0x06
}

@KatanaUInt8RawBytes
public enum BassHighFrequency: UInt8, Sendable, Hashable, CaseIterable {
  case freq800Hz = 0x00
  case freq1kHz = 0x01
  case freq1k250Hz = 0x02
  case freq1k600Hz = 0x03
  case freq2kHz = 0x04
  case freq2k500Hz = 0x05
  case freq3k150Hz = 0x06
  case freq4kHz = 0x07
  case freq5kHz = 0x08
  case freq6k300Hz = 0x09
  case freq8kHz = 0x0A
}
