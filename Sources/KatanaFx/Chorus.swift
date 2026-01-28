import KatanaCore
import KatanaMacros

// MARK - TwoByTwoChorus

/// The data bank representing the chorus parameters.
@KatanaFxBank
public struct ChorusBank: Sendable, Hashable {
  @FxIntegerParameter(id: .chorusCrossoverFrequency, range: 0...100)
  public var crossoverFrequency: UInt8 = 50

  @FxIntegerParameter(id: .chorusLowRate, range: 0...100)
  public var lowRate: UInt8 = 50

  @FxIntegerParameter(id: .chorusLowDepth, range: 0...100)
  public var lowDepth: UInt8 = 50

  @FxIntegerParameter(id: .chorusLowPreDelay, range: 0...80)
  public var lowPreDelay: UInt8 = 0

  @FxIntegerParameter(id: .chorusLowLevel, range: 0...100)
  public var lowLevel: UInt8 = 100

  @FxIntegerParameter(id: .chorusHighRate, range: 0...100)
  public var highRate: UInt8 = 50

  @FxIntegerParameter(id: .chorusHighDepth, range: 0...100)
  public var highDepth: UInt8 = 50

  @FxIntegerParameter(id: .chorusHighPreDelay, range: 0...80)
  public var highPreDelay: UInt8 = 0

  @FxIntegerParameter(id: .chorusHighLevel, range: 0...100)
  public var highLevel: UInt8 = 100

  @FxIntegerParameter(id: .chorusDirectMix, range: 0...100)
  public var directMix: UInt8 = 0
}

// MARK: - DC30

/// The data bank representing the DC-30 parameters.
@KatanaFxBank
public struct DC30Bank: Sendable, Hashable {
  @FxParameter(id: .dc30Type)
  public var type: DC30Type = .chorus

  @FxIntegerParameter(id: .dc30InputVolume, range: 0...100)
  public var inputVolume: UInt8 = 50

  @FxIntegerParameter(id: .dc30ChorusIntensity, range: 0...100)
  public var chorusIntensity: UInt8 = 50

  @FxIntegerParameter(id: .dc30RepeatTime, range: 0...600)
  public var repeatTime: UInt16 = 300

  @FxIntegerParameter(id: .dc30EchoIntensity, range: 0...100)
  public var echoIntensity: UInt8 = 50

  @FxIntegerParameter(id: .dc30Volume, range: 0...100)
  public var volume: UInt8 = 50

  @FxIntegerParameter(id: .dc30Tone, range: 0...100)
  public var tone: UInt8 = 50

  @FxParameter(id: .dc30OutputType)
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
