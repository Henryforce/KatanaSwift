import KatanaCore
import KatanaMacros

/// A bank representing the primary amplifier settings (gain, EQ, volume).
@KatanaBank
public struct AmpBank: KatanaGoBank, Sendable, Hashable {
  /// The selected amplifier model.
  @Parameter(at: 0x0C)
  public var type: AmpType = .clean

  /// The amount of input gain (0-100).
  @IntegerParameter(at: 0x00, range: 0...100)
  public var gain: UInt8 = 50

  /// The post-gain volume level (0-100).
  @IntegerParameter(at: 0x01, range: 0...100)
  public var volume: UInt8 = 50

  /// The bass frequency level (0-100).
  @IntegerParameter(at: 0x03, range: 0...100)
  public var bass: UInt8 = 50

  /// The middle frequency level (0-100).
  @IntegerParameter(at: 0x04, range: 0...100)
  public var middle: UInt8 = 50

  /// The treble frequency level (0-100).
  @IntegerParameter(at: 0x05, range: 0...100)
  public var treble: UInt8 = 50

  /// The presence adjustment level (0-100).
  @IntegerParameter(at: 0x0A, range: 0...100)
  public var presence: UInt8 = 50

  /// Whether the amp model's variation is enabled.
  @Parameter(at: 0x0D)
  public var variation: Bool = false

  public static let katanaGoAddress: UInt32 = 0x20_00_20_00

  public static let size: UInt32 = 14
}

/// Available amplifier types.
@KatanaUInt8RawBytes
public enum AmpType: UInt8, Sendable, Hashable, CaseIterable {
  case acoustic = 0x00
  case clean = 0x01
  case crunch = 0x02
  case lead = 0x03
  case brown = 0x04
}
