import KatanaCore
import KatanaMacros

// MARK: - Tremolo

/// The data bank representing the tremolo parameters.
@KatanaFxBank
public struct TremoloBank: Sendable, Hashable {
  @FxIntegerParameter(id: .tremoloWaveShape, range: 0...100)
  public var waveShape: UInt8 = 0

  @FxIntegerParameter(id: .tremoloRate, range: 0...100)
  public var rate: UInt8 = 50

  @FxIntegerParameter(id: .tremoloDepth, range: 0...100)
  public var depth: UInt8 = 50

  @FxIntegerParameter(id: .tremoloLevel, range: 0...100)
  public var level: UInt8 = 100
}
