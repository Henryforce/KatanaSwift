import KatanaCore
import KatanaMacros

// MARK: - Wah

@KatanaUInt8RawBytes
public enum WahMode: UInt8, Sendable, Hashable, CaseIterable {
  case lowPassFilter = 0x00
  case highPassFilter = 0x01
}

// MARK: - TWah

/// The data bank representing the T-Wah parameters.
@KatanaFxBank
public struct TWahBank: Sendable, Hashable {
  @FxParameter(id: .tWahMode)
  public var mode: WahMode = .lowPassFilter

  @FxParameter(id: .tWahPolarity)
  public var polarity: TWahPolarity = .up

  @FxIntegerParameter(id: .tWahSens, range: 0...100)
  public var sens: UInt8 = 50

  @FxIntegerParameter(id: .tWahFrequency, range: 0...100)
  public var frequency: UInt8 = 50

  @FxIntegerParameter(id: .tWahPeak, range: 0...100)
  public var peak: UInt8 = 50

  @FxIntegerParameter(id: .tWahEffectLevel, range: 0...100)
  public var effectLevel: UInt8 = 100

  @FxIntegerParameter(id: .tWahDirectLevel, range: 0...100)
  public var directLevel: UInt8 = 0
}

@KatanaUInt8RawBytes
public enum TWahPolarity: UInt8, Sendable, Hashable, CaseIterable {
  case down = 0x00
  case up = 0x01
}

// MARK: - AutoWah

/// The data bank representing the auto wah parameters.
@KatanaFxBank
public struct AutoWahBank: Sendable, Hashable {
  @FxParameter(id: .autoWahMode)
  public var mode: WahMode = .lowPassFilter

  @FxIntegerParameter(id: .autoWahFrequency, range: 0...100)
  public var frequency: UInt8 = 50

  @FxIntegerParameter(id: .autoWahPeak, range: 0...100)
  public var peak: UInt8 = 50

  @FxIntegerParameter(id: .autoWahRate, range: 0...100)
  public var rate: UInt8 = 50

  @FxIntegerParameter(id: .autoWahDepth, range: 0...100)
  public var depth: UInt8 = 50

  @FxIntegerParameter(id: .autoWahEffectLevel, range: 0...100)
  public var effectLevel: UInt8 = 100

  @FxIntegerParameter(id: .autoWahDirectLevel, range: 0...100)
  public var directLevel: UInt8 = 0
}
