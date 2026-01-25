import KatanaCore
import KatanaMacros

// MARK: - ModFxGraphicEQ

/// The data bank representing the MOD/FX graphic equalizer parameters.
@KatanaBank
public struct ModFxGraphicEQBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00_01_00_4B, range: 0...40)
  public var band31Hz: UInt8 = 20

  @IntegerParameter(at: 0x00_01_00_4C, range: 0...40)
  public var band62Hz: UInt8 = 20

  @IntegerParameter(at: 0x00_01_00_4D, range: 0...40)
  public var band125Hz: UInt8 = 20

  @IntegerParameter(at: 0x00_01_00_4E, range: 0...40)
  public var band250Hz: UInt8 = 20

  @IntegerParameter(at: 0x00_01_00_4F, range: 0...40)
  public var band500Hz: UInt8 = 20

  @IntegerParameter(at: 0x00_01_00_50, range: 0...40)
  public var band1kHz: UInt8 = 20

  @IntegerParameter(at: 0x00_01_00_51, range: 0...40)
  public var band2kHz: UInt8 = 20

  @IntegerParameter(at: 0x00_01_00_52, range: 0...40)
  public var band4kHz: UInt8 = 20

  @IntegerParameter(at: 0x00_01_00_53, range: 0...40)
  public var band8kHz: UInt8 = 20

  @IntegerParameter(at: 0x00_01_00_54, range: 0...40)
  public var band16kHz: UInt8 = 20

  @IntegerParameter(at: 0x00_01_00_55, range: 0...40)
  public var level: UInt8 = 20
}
