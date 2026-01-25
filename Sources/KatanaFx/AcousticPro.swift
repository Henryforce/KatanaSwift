import KatanaCore
import KatanaMacros

// MARK: - AcousticPro

public enum AcousticProParameter: Sendable, Hashable {
  case type(AcousticProType)
  /// Range is from -50 to 50 mapped to 0..100.
  case bass(UInt8)
  /// Range is from -50 to 50 mapped to 0..100.
  case middle(UInt8)
  case midFrequency(EQFrequency)
  /// Range is from -50 to 50 mapped to 0..100.
  case treble(UInt8)
  /// Range is from -50 to 50 mapped to 0..100.
  case presence(UInt8)
  case level(UInt8)
}

/// The data bank representing the acoustic pro parameters.
@KatanaBank
public struct AcousticProBank: Sendable, Hashable {
  @Parameter(at: 0x00_01_00_6A)
  public var type: AcousticProType = .small

  @IntegerParameter(at: 0x00_01_00_6B, range: 0...100)
  public var bass: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_6C, range: 0...100)
  public var middle: UInt8 = 50

  @Parameter(at: 0x00_01_00_6D)
  public var midFrequency: EQFrequency = .freq500Hz

  @IntegerParameter(at: 0x00_01_00_6E, range: 0...100)
  public var treble: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_6F, range: 0...100)
  public var presence: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_70, range: 0...100)
  public var level: UInt8 = 100
}

@KatanaUInt8RawBytes
public enum AcousticProType: UInt8, Sendable, Hashable, CaseIterable {
  case small = 0x00
  case medium = 0x01
  case bright = 0x02
  case power = 0x03
}
