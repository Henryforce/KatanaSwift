import KatanaCore
import KatanaMacros

// MARK: - RingMod

/// The data bank representing the ring modulator parameters.
@KatanaBank
public struct RingModBank: Sendable, Hashable {
  @Parameter(at: 0x00_01_00_26)
  public var mode: RingModMode = .normal

  @IntegerParameter(at: 0x00_01_00_27, range: 0...100)
  public var frequency: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_28, range: 0...100)
  public var effectLevel: UInt8 = 100

  @IntegerParameter(at: 0x00_01_00_29, range: 0...100)
  public var directMix: UInt8 = 0
}

@KatanaUInt8RawBytes
public enum RingModMode: UInt8, Sendable, Hashable, CaseIterable {
  case normal = 0x00
  case intelligent = 0x01
}
