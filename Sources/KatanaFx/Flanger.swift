import KatanaCore
import KatanaMacros

// MARK: - Flanger

@KatanaFxBank
public struct FlangerBank: Sendable, Hashable {
  @FxIntegerParameter(id: .flangerRate, range: 0...100)
  public var rate: UInt8 = 50

  @FxIntegerParameter(id: .flangerDepth, range: 0...100)
  public var depth: UInt8 = 50

  @FxIntegerParameter(id: .flangerManual, range: 0...100)
  public var manual: UInt8 = 50

  @FxIntegerParameter(id: .flangerResonance, range: 0...100)
  public var resonance: UInt8 = 50

  @FxParameter(id: .flangerLowCut)
  public var lowCut: FlangerLowCut = .flat

  @FxIntegerParameter(id: .flangerEffectLevel, range: 0...100)
  public var effectLevel: UInt8 = 100

  @FxIntegerParameter(id: .flangerDirectLevel, range: 0...100)
  public var directLevel: UInt8 = 0
}

@KatanaUInt8RawBytes
public enum FlangerLowCut: UInt8, Sendable, Hashable, CaseIterable {
  case flat = 0x00
  case freq55Hz = 0x01
  case freq110Hz = 0x02
  case freq165Hz = 0x03
  case freq200Hz = 0x04
  case freq280Hz = 0x05
  case freq340Hz = 0x06
  case freq400Hz = 0x07
  case freq500Hz = 0x08
  case freq630Hz = 0x09
  case freq800Hz = 0x0A
}

// MARK: - Flanger117E

/// The data bank representing the flanger 117E parameters.
@KatanaFxBank
public struct Flanger117EBank: Sendable, Hashable {
  @FxIntegerParameter(id: .flanger117EManual, range: 0...100)
  public var manual: UInt8 = 50

  @FxIntegerParameter(id: .flanger117EWidth, range: 0...100)
  public var width: UInt8 = 50

  @FxIntegerParameter(id: .flanger117ESpeed, range: 0...100)
  public var speed: UInt8 = 50

  @FxIntegerParameter(id: .flanger117ERegen, range: 0...100)
  public var regen: UInt8 = 50
}
