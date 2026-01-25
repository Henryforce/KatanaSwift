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
@KatanaBank
public struct TWahBank: Sendable, Hashable {
  @Parameter(at: 0x00_01_00_3D)
  public var mode: WahMode = .lowPassFilter

  @Parameter(at: 0x00_01_00_3E)
  public var polarity: TWahPolarity = .up

  @IntegerParameter(at: 0x00_01_00_3F, range: 0...100)
  public var sens: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_40, range: 0...100)
  public var frequency: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_41, range: 0...100)
  public var peak: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_42, range: 0...100)
  public var effectLevel: UInt8 = 100

  @IntegerParameter(at: 0x00_01_00_43, range: 0...100)
  public var directLevel: UInt8 = 0
}

@KatanaUInt8RawBytes
public enum TWahPolarity: UInt8, Sendable, Hashable, CaseIterable {
  case down = 0x00
  case up = 0x01
}

// MARK: - AutoWah

/// The data bank representing the auto wah parameters.
@KatanaBank
public struct AutoWahBank: Sendable, Hashable {
  @Parameter(at: 0x00_01_00_44)
  public var mode: WahMode = .lowPassFilter

  @IntegerParameter(at: 0x00_01_00_45, range: 0...100)
  public var frequency: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_46, range: 0...100)
  public var peak: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_47, range: 0...100)
  public var rate: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_48, range: 0...100)
  public var depth: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_49, range: 0...100)
  public var effectLevel: UInt8 = 100

  @IntegerParameter(at: 0x00_01_00_4A, range: 0...100)
  public var directLevel: UInt8 = 0
}
