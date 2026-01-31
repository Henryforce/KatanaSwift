import KatanaCore
import KatanaMacros

// MARK - TwoByTwoChorus

/// The data bank representing the chorus parameters.
@KatanaFxBank
public struct ChorusBank: Sendable, Hashable {
  @Parameter(at: 0x00_00_00_00)
  public var crossoverFrequency: ChorusCrossoverFrequency = .freq250Hz

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

  @IntegerParameter(at: 0x00_00_00_03, range: 40...600)
  public var echoRepeatTime: UInt16 = 300

  @IntegerParameter(at: 0x00_00_00_07, range: 0...100)
  public var echoIntensity: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_08, range: 0...100)
  public var echoVolume: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_09, range: 0...100)
  public var tone: UInt8 = 50

  @Parameter(at: 0x00_00_00_0A)
  public var outputType: DC30OutputType = .dPlusE

  public static let size: UInt32 = 11
}

@KatanaUInt8RawBytes
public enum ChorusCrossoverFrequency: UInt8, Sendable, Hashable, CaseIterable {
  case freq100Hz = 0x00
  case freq125Hz = 0x01
  case freq160Hz = 0x02
  case freq200Hz = 0x03
  case freq250Hz = 0x04
  case freq315Hz = 0x05
  case freq400Hz = 0x06
  case freq500Hz = 0x07
  case freq630Hz = 0x08
  case freq800Hz = 0x09
  case freq1kHz = 0x0A
  case freq1k250Hz = 0x0B
  case freq1k600Hz = 0x0C
  case freq2kHz = 0x0D
  case freq2k500Hz = 0x0E
  case freq3k150Hz = 0x0F
  case freq4kHz = 0x10
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
