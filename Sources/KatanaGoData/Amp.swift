import KatanaCore
import KatanaMacros

@KatanaBank
public struct AmpBank: Sendable, Hashable {
  @Parameter(at: 0x00_00_20_0C)
  public var type: AmpType = .clean

  @IntegerParameter(at: 0x00_00_20_00, range: 0...100)
  public var gain: UInt8 = 50

  @IntegerParameter(at: 0x00_00_20_01, range: 0...100)
  public var volume: UInt8 = 50

  @IntegerParameter(at: 0x00_00_20_03, range: 0...100)
  public var bass: UInt8 = 50

  @IntegerParameter(at: 0x00_00_20_04, range: 0...100)
  public var middle: UInt8 = 50

  @IntegerParameter(at: 0x00_00_20_05, range: 0...100)
  public var treble: UInt8 = 50

  @IntegerParameter(at: 0x00_00_20_0A, range: 0...100)
  public var presence: UInt8 = 50

  @Parameter(at: 0x00_00_20_0D)
  public var variation: Bool = false
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
