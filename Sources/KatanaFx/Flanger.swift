import KatanaCore
import KatanaMacros

// MARK: - Flanger

public enum FlangerParameter: Sendable, Hashable {
  case rate(UInt8)
  case depth(UInt8)
  case manual(UInt8)
  case resonance(UInt8)
  case lowCut(FlangerLowCut)
  case effectLevel(UInt8)
  case directLevel(UInt8)
}

/// The data bank representing the flanger parameters.
@KatanaBank
public struct FlangerBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00_01_00_0A, range: 0...100)
  public var rate: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_0B, range: 0...100)
  public var depth: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_0C, range: 0...100)
  public var manual: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_0D, range: 0...100)
  public var resonance: UInt8 = 50

  @Parameter(at: 0x00_01_00_0E)
  public var lowCut: FlangerLowCut = .flat

  @IntegerParameter(at: 0x00_01_00_0F, range: 0...100)
  public var effectLevel: UInt8 = 100

  @IntegerParameter(at: 0x00_01_00_10, range: 0...100)
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

public enum Flanger117EParameter: Sendable, Hashable {
  case manual(UInt8)
  case width(UInt8)
  case speed(UInt8)
  case regen(UInt8)
}

/// The data bank representing the flanger 117E parameters.
@KatanaBank
public struct Flanger117EBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00_01_01_43, range: 0...100)
  public var manual: UInt8 = 50

  @IntegerParameter(at: 0x00_01_01_44, range: 0...100)
  public var width: UInt8 = 50

  @IntegerParameter(at: 0x00_01_01_45, range: 0...100)
  public var speed: UInt8 = 50

  @IntegerParameter(at: 0x00_01_01_46, range: 0...100)
  public var regen: UInt8 = 50
}
