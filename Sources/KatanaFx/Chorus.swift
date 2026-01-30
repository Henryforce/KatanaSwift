import KatanaCore
import KatanaMacros

// MARK - TwoByTwoChorus

/// The data bank representing the chorus parameters.
@KatanaFxBank
public struct ChorusBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00_00_00_00, range: 0...100)
  public var crossoverFrequency: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_01, range: 0...100)
  public var lowRate: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_02, range: 0...100)
  public var lowDepth: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_03, range: 0...80)
  public var lowPreDelay: UInt8 = 0

  @IntegerParameter(at: 0x00_00_00_04, range: 0...100)
  public var lowLevel: UInt8 = 100

  @IntegerParameter(at: 0x00_00_00_05, range: 0...100)
  public var highRate: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_06, range: 0...100)
  public var highDepth: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_07, range: 0...80)
  public var highPreDelay: UInt8 = 0

  @IntegerParameter(at: 0x00_00_00_08, range: 0...100)
  public var highLevel: UInt8 = 100

  @IntegerParameter(at: 0x00_00_00_09, range: 0...100)
  public var directMix: UInt8 = 0

  public static let size: UInt32 = 10
}

// MARK: - DC30

/// The data bank representing the DC-30 parameters.
@KatanaFxBank
public struct DC30Bank: Sendable, Hashable {
  @Parameter(at: 0x00_00_00_00)
  public var type: DC30Type = .chorus

  @IntegerParameter(at: 0x00_00_00_01, range: 0...100)
  public var inputVolume: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_02, range: 0...100)
  public var chorusIntensity: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_03, range: 0...600)
  public var repeatTime: UInt16 = 300

  @IntegerParameter(at: 0x00_00_00_07, range: 0...100)
  public var echoIntensity: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_08, range: 0...100)
  public var volume: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_09, range: 0...100)
  public var tone: UInt8 = 50

  @Parameter(at: 0x00_00_00_0A)
  public var outputType: DC30OutputType = .dPlusE

  public static let size: UInt32 = 11
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
