import KatanaCore
import KatanaMacros

// MARK - TwoByTwoChorus

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
@KatanaBank
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
@KatanaBank
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
}

@KatanaUInt8RawBytes
public enum DC30Type: UInt8, Sendable, Hashable, CaseIterable {
  case chorus = 0x00
  case echo = 0x01
}

@KatanaUInt8RawBytes
public enum DC30OutputType: UInt8, Sendable, Hashable, CaseIterable {
  case dPlusE = 0x00
  case dOverE = 0x01
}
