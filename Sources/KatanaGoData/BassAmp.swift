import KatanaCore
import KatanaMacros

/// A bank representing the bass amplifier settings.
@KatanaBank
public struct BassAmpBank: KatanaGoBank, Sendable, Hashable {
  /// The selected bass amplifier model.
  @Parameter(at: 0x0C)
  public var type: BassAmpType = .vintage

  /// The amount of input gain (0-100).
  @IntegerParameter(at: 0x00, range: 0...100)
  public var gain: UInt8 = 50

  /// The post-gain volume level (0-100).
  @IntegerParameter(at: 0x01, range: 0...100)
  public var volume: UInt8 = 50

  /// Whether the shape function is enabled.
  @Parameter(at: 0x02)
  public var shape: Bool = false

  /// The bass frequency level (0-100).
  @IntegerParameter(at: 0x03, range: 0...100)
  public var bass: UInt8 = 50

  /// The middle frequency level (0-100).
  @IntegerParameter(at: 0x04, range: 0...100)
  public var middle: UInt8 = 50

  /// The treble frequency level (0-100).
  @IntegerParameter(at: 0x05, range: 0...100)
  public var treble: UInt8 = 50

  /// The gain level for the low-mid frequency range (0-100).
  @IntegerParameter(at: 0x06, range: 0...100)
  public var lowMidGain: UInt8 = 50

  /// The frequency setting for the low-mid range (0-100).
  @IntegerParameter(at: 0x07, range: 0...100)
  public var lowMidFreq: UInt8 = 50

  /// The gain level for the high-mid frequency range (0-100).
  @IntegerParameter(at: 0x08, range: 0...100)
  public var highMidGain: UInt8 = 50

  /// The frequency setting for the high-mid range (0-100).
  @IntegerParameter(at: 0x09, range: 0...100)
  public var highMidFreq: UInt8 = 50

  /// The presence adjustment level (0-100).
  @IntegerParameter(at: 0x0A, range: 0...100)
  public var presence: UInt8 = 50

  /// Whether the amp model's variation is enabled.
  @Parameter(at: 0x0D)
  public var variation: Bool = false

  public static let katanaGoAddress: UInt32 = 0x20_00_20_00

  public static let size: UInt32 = 14
}

/// Available bass amplifier types.
@KatanaUInt8RawBytes
public enum BassAmpType: UInt8, Sendable, Hashable, CaseIterable {
  /// Vintage amp type.
  case vintage = 0x05
  /// Flat amp type.
  case flat = 0x06
  /// Modern amp type.
  case modern = 0x07
}
