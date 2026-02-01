import KatanaCore
import KatanaEQ
import KatanaMacros

// MARK - EQ

/// The data bank representing the equalizer parameters.
@KatanaBank
public struct EQSelectionBank: KatanaGoBank, Sendable, Hashable {
  @Parameter(at: 0x01)
  public var status: Bool = false

  @Parameter(at: 0x00)
  public var position: EQPosition = .ampIn

  @Parameter(at: 0x02)
  public var type: EQType = .parametric

  public static let katanaGoAddress: UInt32 = 0x20_02_60_00

  public static let size: UInt32 = 3
}

/// The data bank representing the parametric equalizer parameters.
@KatanaBank
public struct ParametricEQBank: KatanaGoBank, Sendable, Hashable {
  @Parameter(at: 0x00)
  public var lowCut: EQLowCut = .flat

  /// Range is from -20 to 20 mapped to 0..40.
  @IntegerParameter(at: 0x01, range: 0...40)
  public var lowGain: UInt8 = 20

  @Parameter(at: 0x02)
  public var lowMidFreq: EQFrequency = .freq200Hz

  @Parameter(at: 0x03)
  public var lowMidQ: EQQ = .q1

  /// Range is from -20 to 20 mapped to 0..40.
  @IntegerParameter(at: 0x04, range: 0...40)
  public var lowMidGain: UInt8 = 20

  @Parameter(at: 0x05)
  public var highMidFreq: EQFrequency = .freq2kHz

  @Parameter(at: 0x06)
  public var highMidQ: EQQ = .q1

  /// Range is from -20 to 20 mapped to 0..40.
  @IntegerParameter(at: 0x07, range: 0...40)
  public var highMidGain: UInt8 = 20

  /// Range is from -20 to 20 mapped to 0..40.
  @IntegerParameter(at: 0x08, range: 0...40)
  public var highGain: UInt8 = 20

  @Parameter(at: 0x09)
  public var highCut: EQHighCut = .flat

  /// Range is from -20 to 20 mapped to 0..40.
  @IntegerParameter(at: 0x0A, range: 0...40)
  public var level: UInt8 = 20

  public static let katanaGoAddress: UInt32 = 0x20_03_00_00

  public static let size: UInt32 = 11
}

/// The data bank representing the graphic equalizer parameters.
@KatanaBank
public struct GraphicEQBank: KatanaGoBank, Sendable, Hashable {
  /// Range is from -12dB to 12dB mapped to 0..24..48 with steps of 0.5dB.
  @IntegerParameter(at: 0x00, range: 0...48)
  public var band31Hz: UInt8 = 24

  @IntegerParameter(at: 0x01, range: 0...48)
  public var band62Hz: UInt8 = 24

  @IntegerParameter(at: 0x02, range: 0...48)
  public var band125Hz: UInt8 = 24

  @IntegerParameter(at: 0x03, range: 0...48)
  public var band250Hz: UInt8 = 24

  @IntegerParameter(at: 0x04, range: 0...48)
  public var band500Hz: UInt8 = 24

  @IntegerParameter(at: 0x05, range: 0...48)
  public var band1kHz: UInt8 = 24

  @IntegerParameter(at: 0x06, range: 0...48)
  public var band2kHz: UInt8 = 24

  @IntegerParameter(at: 0x07, range: 0...48)
  public var band4kHz: UInt8 = 24

  @IntegerParameter(at: 0x08, range: 0...48)
  public var band8kHz: UInt8 = 24

  @IntegerParameter(at: 0x09, range: 0...48)
  public var band16kHz: UInt8 = 24

  @IntegerParameter(at: 0x0A, range: 0...48)
  public var level: UInt8 = 24

  public static let katanaGoAddress: UInt32 = 0x20_03_20_00

  public static let size: UInt32 = 11
}
