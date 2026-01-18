/// Parameters for the Delay effect.
public enum DelayParameter: Sendable, Hashable {
  case enable(Bool)
  case type(DelayType)
  case time(UInt16)
  case feedback(UInt8)
  case highCut(DelayHighCutFrequency)
  case effectLevel(UInt8)
  case directMix(UInt8)
  case modulationRate(UInt8)
  case modulationDepth(UInt8)
  case modulationSwitch(Bool)
  case tapTimePercentage(UInt8)
  case filterEnable(Bool)
  case filter(DelayFilterRange)
  case delayPhase(DelayPhase)
  case feedbackPhase(DelayPhase)
}

/// Available delay types for the Katana GO.
public enum DelayType: UInt8, Sendable, Hashable, CaseIterable {
  case digital = 0x00
  case pan = 0x01
  case stereo = 0x02
  case reverse = 0x06
  case analog = 0x07
  case tapeEcho = 0x08
  case modulate = 0x09
  case sde3000 = 0x0A
}

public enum DelayHighCutFrequency: UInt8, Sendable, Hashable, CaseIterable {
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

public enum DelayFilterRange: UInt8, Sendable, Hashable, CaseIterable {
  case freq8kHz = 0x00
  case freq17kHz = 0x01
}

public enum DelayPhase: UInt8, Sendable, Hashable, CaseIterable {
  case normal = 0x00
  case inverted = 0x01
}
