import KatanaCore
import KatanaMacros

@KatanaBank
public struct BassAmpBank: Sendable, Hashable {
  @Parameter(at: 0x0C)
  public var type: BassAmpType = .vintage

  @IntegerParameter(at: 0x00, range: 0...100)
  public var gain: UInt8 = 50

  @IntegerParameter(at: 0x01, range: 0...100)
  public var volume: UInt8 = 50

  @Parameter(at: 0x02)
  public var shape: Bool = false

  @IntegerParameter(at: 0x03, range: 0...100)
  public var bass: UInt8 = 50

  @IntegerParameter(at: 0x04, range: 0...100)
  public var middle: UInt8 = 50

  @IntegerParameter(at: 0x05, range: 0...100)
  public var treble: UInt8 = 50

  @IntegerParameter(at: 0x06, range: 0...100)
  public var lowMidGain: UInt8 = 50

  @IntegerParameter(at: 0x07, range: 0...100)
  public var lowMidFreq: UInt8 = 50

  @IntegerParameter(at: 0x08, range: 0...100)
  public var highMidGain: UInt8 = 50

  @IntegerParameter(at: 0x09, range: 0...100)
  public var highMidFreq: UInt8 = 50

  @IntegerParameter(at: 0x0A, range: 0...100)
  public var presence: UInt8 = 50

  @Parameter(at: 0x0D)
  public var variation: Bool = false

  public static let address: UInt32 = 0x20_00_00_00

  public static let size: UInt32 = 14
}

@KatanaUInt8RawBytes
public enum BassAmpType: UInt8, Sendable, Hashable, CaseIterable {
  case vintage = 0x05
  case flat = 0x06
  case modern = 0x07
}
