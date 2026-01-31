import KatanaCore
import KatanaMacros

// MARK: - Wah

@KatanaUInt8RawBytes
public enum WahMode: UInt8, Sendable, Hashable, CaseIterable {
  case lowPassFilter = 0x00
  case highPassFilter = 0x01
}

// MARK: - TWah

/// The data bank representing the T-Wah parameters.
@KatanaFxBank
public struct TWahBank: Sendable, Hashable {
  @Parameter(at: 0x00_00_00_00)
  public var mode: WahMode = .lowPassFilter

  @Parameter(at: 0x00_00_00_01)
  public var polarity: TWahPolarity = .up

  @IntegerParameter(at: 0x00_00_00_02, range: 0...100)
  public var sens: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_03, range: 0...100)
  public var frequency: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_04, range: 0...100)
  public var peak: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_05, range: 0...100)
  public var effectLevel: UInt8 = 100

  @IntegerParameter(at: 0x00_00_00_06, range: 0...100)
  public var directLevel: UInt8 = 0

  public static let size: UInt32 = 7
}

@KatanaUInt8RawBytes
public enum TWahPolarity: UInt8, Sendable, Hashable, CaseIterable {
  case down = 0x00
  case up = 0x01
}

// MARK: - AutoWah

/// The data bank representing the auto wah parameters.
@KatanaFxBank
public struct AutoWahBank: Sendable, Hashable {
  @Parameter(at: 0x00_00_00_00)
  public var mode: WahMode = .lowPassFilter

  @IntegerParameter(at: 0x00_00_00_01, range: 0...100)
  public var frequency: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_02, range: 0...100)
  public var peak: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_03, range: 0...100)
  public var rate: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_04, range: 0...100)
  public var depth: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_05, range: 0...100)
  public var effectLevel: UInt8 = 100

  @IntegerParameter(at: 0x00_00_00_06, range: 0...100)
  public var directLevel: UInt8 = 0

  public static let size: UInt32 = 7
}
