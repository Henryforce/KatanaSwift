import KatanaCore
import KatanaEQ
import KatanaMacros

// MARK: - ModFxGraphicEQ

/// The data bank representing the MOD/FX graphic equalizer parameters.
@KatanaFxBank
public struct ModFxGraphicEQBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00_00_00_00, range: 0...40)
  public var band31Hz: UInt8 = 20

  @IntegerParameter(at: 0x00_00_00_01, range: 0...40)
  public var band62Hz: UInt8 = 20

  @IntegerParameter(at: 0x00_00_00_02, range: 0...40)
  public var band125Hz: UInt8 = 20

  @IntegerParameter(at: 0x00_00_00_03, range: 0...40)
  public var band250Hz: UInt8 = 20

  @IntegerParameter(at: 0x00_00_00_04, range: 0...40)
  public var band500Hz: UInt8 = 20

  @IntegerParameter(at: 0x00_00_00_05, range: 0...40)
  public var band1kHz: UInt8 = 20

  @IntegerParameter(at: 0x00_00_00_06, range: 0...40)
  public var band2kHz: UInt8 = 20

  @IntegerParameter(at: 0x00_00_00_07, range: 0...40)
  public var band4kHz: UInt8 = 20

  @IntegerParameter(at: 0x00_00_00_08, range: 0...40)
  public var band8kHz: UInt8 = 20

  @IntegerParameter(at: 0x00_00_00_09, range: 0...40)
  public var band16kHz: UInt8 = 20

  @IntegerParameter(at: 0x00_00_00_0A, range: 0...40)
  public var level: UInt8 = 20

  public static let size: UInt32 = 11
}
