/// Parameters for the Reverb effect.
public enum ReverbParameter: Sendable {
  case enable(Bool)
  case type(ReverbType)
  // 0..100 mapped to 0.0 to 10.0 ms in 0.1 ms steps for each increment.
  case time(UInt8)
  // 0..500 encoded as an 11 bit value.
  case preDelay(UInt16)
  case lowCut(ReverbLowCut)
  case highCut(ReverbHighCut)
  case density(UInt8)
  case effectLevel(UInt8)
  case directMix(UInt8)
  // NOTE: This might refer to color.
  case springSensitivity(UInt8)
}

public enum ReverbType: UInt8, Sendable {
  case room = 0x01
  case hall = 0x03
  case plate = 0x04
  case spring = 0x05
  case modulate = 0x06
}

public enum ReverbLowCut: UInt8, Sendable {
  case flat = 0x00
  case freq20Hz = 0x01
  case freq25Hz = 0x02
  case freq31Hz5 = 0x03
  case freq40Hz = 0x04
  case freq50Hz = 0x05
  case freq63Hz = 0x06
  case freq80Hz = 0x07
  case freq100Hz = 0x08
  case freq125Hz = 0x09
  case freq160Hz = 0x0A
  case freq200Hz = 0x0B
  case freq250Hz = 0x0C
  case freq315Hz = 0x0D
  case freq400Hz = 0x0E
  case freq500Hz = 0x0F
  case freq630Hz = 0x10
  case freq800Hz = 0x11
}

public enum ReverbHighCut: UInt8, Sendable {
  case freq630Hz = 0x00
  case freq800Hz = 0x01
  case freq1kHz = 0x02
  case freq1k25Hz = 0x03
  case freq1k6Hz = 0x04
  case freq2kHz = 0x05
  case freq2k5Hz = 0x06
  case freq3k15Hz = 0x07
  case freq4kHz = 0x08
  case freq5kHz = 0x09
  case freq6k3Hz = 0x0A
  case freq8kHz = 0x0B
  case freq10kHz = 0x0C
  case freq12k5Hz = 0x0D
  case flat = 0x0E
}
