import KatanaCore
import KatanaMacros

// MARK: - RingMod

/// The data bank representing the ring modulator parameters.
@KatanaFxBank
public struct RingModBank: Sendable, Hashable {
  @Parameter(at: 0x00_00_00_00)
  public var mode: RingModMode = .normal

  @IntegerParameter(at: 0x00_00_00_01, range: 0...100)
  public var frequency: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_02, range: 0...100)
  public var effectLevel: UInt8 = 100

  @IntegerParameter(at: 0x00_00_00_03, range: 0...100)
  public var directMix: UInt8 = 0

  public static let size: UInt32 = 4
}

@KatanaUInt8RawBytes
public enum RingModMode: UInt8, Sendable, Hashable, CaseIterable {
  case normal = 0x00
  case intelligent = 0x01
}
