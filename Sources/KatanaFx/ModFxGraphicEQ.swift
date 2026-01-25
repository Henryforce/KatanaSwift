import KatanaCore
import KatanaMacros
import KatanaEQ

// MARK: - ModFxGraphicEQ

/// The data bank representing the MOD/FX graphic equalizer parameters.
@KatanaFxBank
public struct ModFxGraphicEQBank: Sendable, Hashable {
  @FxIntegerParameter(id: .modFxGraphicEQBand31Hz, range: 0...40)
  public var band31Hz: UInt8 = 20

  @FxIntegerParameter(id: .modFxGraphicEQBand62Hz, range: 0...40)
  public var band62Hz: UInt8 = 20

  @FxIntegerParameter(id: .modFxGraphicEQBand125Hz, range: 0...40)
  public var band125Hz: UInt8 = 20

  @FxIntegerParameter(id: .modFxGraphicEQBand250Hz, range: 0...40)
  public var band250Hz: UInt8 = 20

  @FxIntegerParameter(id: .modFxGraphicEQBand500Hz, range: 0...40)
  public var band500Hz: UInt8 = 20

  @FxIntegerParameter(id: .modFxGraphicEQBand1kHz, range: 0...40)
  public var band1kHz: UInt8 = 20

  @FxIntegerParameter(id: .modFxGraphicEQBand2kHz, range: 0...40)
  public var band2kHz: UInt8 = 20

  @FxIntegerParameter(id: .modFxGraphicEQBand4kHz, range: 0...40)
  public var band4kHz: UInt8 = 20

  @FxIntegerParameter(id: .modFxGraphicEQBand8kHz, range: 0...40)
  public var band8kHz: UInt8 = 20

  @FxIntegerParameter(id: .modFxGraphicEQBand16kHz, range: 0...40)
  public var band16kHz: UInt8 = 20

  @FxIntegerParameter(id: .modFxGraphicEQLevel, range: 0...40)
  public var level: UInt8 = 20
}
