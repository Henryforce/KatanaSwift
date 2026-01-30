import KatanaCore
import KatanaMacros

@KatanaBank
public struct AmpBank: Sendable, Hashable {
  @Parameter(at: 0x0C)
  public var type: AmpType = .clean

  @IntegerParameter(at: 0x00, range: 0...100)
  public var gain: UInt8 = 50

  @IntegerParameter(at: 0x01, range: 0...100)
  public var volume: UInt8 = 50

  @IntegerParameter(at: 0x03, range: 0...100)
  public var bass: UInt8 = 50

  @IntegerParameter(at: 0x04, range: 0...100)
  public var middle: UInt8 = 50

  @IntegerParameter(at: 0x05, range: 0...100)
  public var treble: UInt8 = 50

  @IntegerParameter(at: 0x0A, range: 0...100)
  public var presence: UInt8 = 50

  @Parameter(at: 0x0D)
  public var variation: Bool = false

  public static let address: UInt32 = 0x20_00_20_00

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
