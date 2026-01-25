import KatanaCore
import KatanaMacros

// MARK: - Slicer

/// The data bank representing the slicer parameters.
@KatanaFxBank
public struct SlicerBank: Sendable, Hashable {
  @FxIntegerParameter(id: .slicerPattern, range: 0...19)
  public var pattern: UInt8 = 0

  @FxIntegerParameter(id: .slicerRate, range: 0...100)
  public var rate: UInt8 = 50

  @FxIntegerParameter(id: .slicerTriggerSens, range: 0...100)
  public var triggerSens: UInt8 = 50

  @FxIntegerParameter(id: .slicerEffectLevel, range: 0...100)
  public var effectLevel: UInt8 = 100

  @FxIntegerParameter(id: .slicerDirectMix, range: 0...100)
  public var directMix: UInt8 = 0
}
