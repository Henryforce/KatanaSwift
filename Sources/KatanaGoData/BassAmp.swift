import KatanaCore
import KatanaMacros

@KatanaBank
public struct BassAmpBank: Sendable, Hashable {
  @Parameter(at: 0x20_00_00_0C)
  public var type: BassAmpType = .vintage

  @IntegerParameter(at: 0x20_00_00_00, range: 0...100)
  public var gain: UInt8 = 50

  @IntegerParameter(at: 0x20_00_00_01, range: 0...100)
  public var volume: UInt8 = 50

  @Parameter(at: 0x20_00_00_02)
  public var shape: Bool = false

  @IntegerParameter(at: 0x20_00_00_03, range: 0...100)
  public var bass: UInt8 = 50

  @IntegerParameter(at: 0x20_00_00_04, range: 0...100)
  public var middle: UInt8 = 50

  @IntegerParameter(at: 0x20_00_00_05, range: 0...100)
  public var treble: UInt8 = 50

  @IntegerParameter(at: 0x20_00_00_06, range: 0...100)
  public var lowMidGain: UInt8 = 50

  @IntegerParameter(at: 0x20_00_00_07, range: 0...100)
  public var lowMidFreq: UInt8 = 50

  @IntegerParameter(at: 0x20_00_00_08, range: 0...100)
  public var highMidGain: UInt8 = 50

  @IntegerParameter(at: 0x20_00_00_09, range: 0...100)
  public var highMidFreq: UInt8 = 50

  @IntegerParameter(at: 0x20_00_00_0A, range: 0...100)
  public var presence: UInt8 = 50

  @Parameter(at: 0x20_00_00_0D)
  public var variation: Bool = false
}

@KatanaUInt8RawBytes
public enum BassAmpType: UInt8, Sendable, Hashable, CaseIterable {
  case vintage = 0x05
  case flat = 0x06
  case modern = 0x07
}
