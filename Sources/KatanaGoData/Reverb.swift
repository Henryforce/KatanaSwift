/// Parameters for the Reverb effect.
public enum ReverbParameter: Sendable, Hashable {
  case enable(Bool)
  case type(ReverbType)
  // 0..100 mapped to 0.0 to 10.0 ms in 0.1 ms steps for each increment.
  case time(UInt8)
  // 0..500 encoded as an 11 bit value.
  case preDelay(UInt16)
  case lowCut(EQLowCut)
  case highCut(EQHighCut)
  case density(UInt8)
  case effectLevel(UInt8)
  case directMix(UInt8)
  // NOTE: This might refer to color.
  case springSensitivity(UInt8)
}

/// The data bank representing the reverb parameters.
public struct ReverbBank: Sendable, Hashable {
  @Parameter(at: 0x00_00_30_05)
  public var status: Bool = false

  @Parameter(at: 0x00_01_40_00)
  public var type: ReverbType = .room

  @IntegerParameter(at: 0x00_01_40_02, range: 0...100)
  public var time: UInt8 = 50

  @IntegerParameter(at: 0x00_01_40_03, range: 0...500)
  public var preDelay: UInt16 = 0

  @Parameter(at: 0x00_01_40_07)
  public var lowCut: EQLowCut = .flat

  @Parameter(at: 0x00_01_40_08)
  public var highCut: EQHighCut = .freq630Hz

  @IntegerParameter(at: 0x00_01_40_09, range: 0...100)
  public var density: UInt8 = 5

  @IntegerParameter(at: 0x00_01_40_0A, range: 0...100)
  public var effectLevel: UInt8 = 50

  @IntegerParameter(at: 0x00_01_40_0B, range: 0...100)
  public var directMix: UInt8 = 0

  @IntegerParameter(at: 0x00_01_40_0C, range: 0...100)
  public var springSensitivity: UInt8 = 50

  public init(
    status: Bool, type: ReverbType, time: UInt8, preDelay: UInt16, lowCut: EQLowCut,
    highCut: EQHighCut, density: UInt8, effectLevel: UInt8, directMix: UInt8,
    springSensitivity: UInt8
  ) {
    self.status = status
    self.type = type
    self.time = time
    self.preDelay = preDelay
    self.lowCut = lowCut
    self.highCut = highCut
    self.density = density
    self.effectLevel = effectLevel
    self.directMix = directMix
    self.springSensitivity = springSensitivity
  }
}

public enum ReverbType: UInt8, Sendable, Hashable, CaseIterable {
  case plate = 0x00
  case room = 0x01
  case hall = 0x02
  case spring = 0x03
  case modulate = 0x04
}
