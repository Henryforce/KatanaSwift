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

public enum ReverbType: UInt8, Sendable, Hashable, CaseIterable {
  case room = 0x01
  case hall = 0x03
  case plate = 0x04
  case spring = 0x05
  case modulate = 0x06
}
