import KatanaCore
import KatanaMacros

/// Available equalizer types.
@KatanaUInt8RawBytes
public enum EQType: UInt8, Sendable, Hashable, CaseIterable {
  case parametric = 0x00
  case graphic = 0x01
}

/// Available equalizer low cut frequencies.
@KatanaUInt8RawBytes
public enum EQLowCut: UInt8, Sendable, Hashable, CaseIterable {
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

/// Available equalizer high cut frequencies.
@KatanaUInt8RawBytes
public enum EQHighCut: UInt8, Sendable, Hashable, CaseIterable {
  case freq630Hz = 0x00
  case freq800Hz = 0x01
  case freq1kHz = 0x02
  case freq1k250Hz = 0x03
  case freq1k600Hz = 0x04
  case freq2kHz = 0x05
  case freq2k500Hz = 0x06
  case freq3k150Hz = 0x07
  case freq4kHz = 0x08
  case freq5kHz = 0x09
  case freq6k300Hz = 0x0A
  case freq8kHz = 0x0B
  case freq10kHz = 0x0C
  case freq12k500Hz = 0x0D
  case flat = 0x0E
}

/// Available equalizer frequencies.
@KatanaUInt8RawBytes
public enum EQFrequency: UInt8, Sendable, Hashable, CaseIterable {
  case freq20Hz = 0x00
  case freq25Hz = 0x01
  case freq31Hz5 = 0x02
  case freq40Hz = 0x03
  case freq50Hz = 0x04
  case freq63Hz = 0x05
  case freq80Hz = 0x06
  case freq100Hz = 0x07
  case freq125Hz = 0x08
  case freq160Hz = 0x09
  case freq200Hz = 0x0A
  case freq250Hz = 0x0B
  case freq315Hz = 0x0C
  case freq400Hz = 0x0D
  case freq500Hz = 0x0E
  case freq630Hz = 0x0F
  case freq800Hz = 0x10
  case freq1kHz = 0x11
  case freq1k250Hz = 0x12
  case freq1k600Hz = 0x13
  case freq2kHz = 0x14
  case freq2k500Hz = 0x15
  case freq3k150Hz = 0x16
  case freq4kHz = 0x17
  case freq5kHz = 0x18
  case freq6k300Hz = 0x19
  case freq8kHz = 0x1A
  case freq10kHz = 0x1B
}

/// Available equalizer Q values.
@KatanaUInt8RawBytes
public enum EQQ: UInt8, Sendable, Hashable, CaseIterable {
  case q05 = 0x00
  case q1 = 0x01
  case q2 = 0x02
  case q4 = 0x03
  case q8 = 0x04
  case q16 = 0x05
}

/// Available equalizer positions.
@KatanaUInt8RawBytes
public enum EQPosition: UInt8, Sendable, Hashable, CaseIterable {
  case ampIn = 0x00
  case ampOut = 0x01
}
