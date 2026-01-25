import KatanaCore
import KatanaMacros

// MARK: - RingMod

/// The data bank representing the ring modulator parameters.
@KatanaFxBank
public struct RingModBank: Sendable, Hashable {
  @FxParameter(id: .ringModMode)
  public var mode: RingModMode = .normal

  @FxIntegerParameter(id: .ringModFrequency, range: 0...100)
  public var frequency: UInt8 = 50

  @FxIntegerParameter(id: .ringModEffectLevel, range: 0...100)
  public var effectLevel: UInt8 = 100

  @FxIntegerParameter(id: .ringModDirectMix, range: 0...100)
  public var directMix: UInt8 = 0
}

@KatanaUInt8RawBytes
public enum RingModMode: UInt8, Sendable, Hashable, CaseIterable {
  case normal = 0x00
  case intelligent = 0x01
}
