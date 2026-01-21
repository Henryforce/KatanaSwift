public enum EQParameter: Sendable, Hashable {
  case enable(Bool)
  case position(EQPosition)
  case type(EQType)
  case parametric(ParametricEQParameter)
  case graphic(GraphicEQParameter)
}

public enum ParametricEQParameter: Sendable, Hashable {
  case lowCut(EQLowCut)
  /// Range is from -20 to 20 mapped to 0..40.
  case lowGain(UInt8)
  case lowMidFreq(EQFrequency)
  case lowMidQ(EQQ)
  /// Range is from -20 to 20 mapped to 0..40.
  case lowMidGain(UInt8)
  case highMidFreq(EQFrequency)
  case highMidQ(EQQ)
  /// Range is from -20 to 20 mapped to 0..40.
  case highMidGain(UInt8)
  /// Range is from -20 to 20 mapped to 0..40.
  case highGain(UInt8)
  case highCut(EQHighCut)
  /// Range is from -20 to 20 mapped to 0..40.
  case level(UInt8)
}

public enum GraphicEQParameter: Sendable, Hashable {
  /// Range is from -12dB to 12dB mapped to 0..24..48 with steps of 0.5dB.
  case band31Hz(UInt8)
  case band62Hz(UInt8)
  case band125Hz(UInt8)
  case band250Hz(UInt8)
  case band500Hz(UInt8)
  case band1kHz(UInt8)
  case band2kHz(UInt8)
  case band4kHz(UInt8)
  case band8kHz(UInt8)
  case band16kHz(UInt8)
  case level(UInt8)
}

/// The data bank representing the equalizer parameters.
public struct EQBank: Sendable, Hashable {
  public let status: Bool
  public let position: EQPosition
  public let type: EQType
  public let parametric: ParametricEQBank
  public let graphic: GraphicEQBank

  public init(
    status: Bool, position: EQPosition, type: EQType, parametric: ParametricEQBank,
    graphic: GraphicEQBank
  ) {
    self.status = status
    self.position = position
    self.type = type
    self.parametric = parametric
    self.graphic = graphic
  }
}

/// The data bank representing the parametric equalizer parameters.
public struct ParametricEQBank: Sendable, Hashable {
  public let lowCut: EQLowCut
  /// Range is from -20 to 20 mapped to 0..40.
  public let lowGain: UInt8
  public let lowMidFreq: EQFrequency
  public let lowMidQ: EQQ
  /// Range is from -20 to 20 mapped to 0..40.
  public let lowMidGain: UInt8
  public let highMidFreq: EQFrequency
  public let highMidQ: EQQ
  /// Range is from -20 to 20 mapped to 0..40.
  public let highMidGain: UInt8
  /// Range is from -20 to 20 mapped to 0..40.
  public let highGain: UInt8
  public let highCut: EQHighCut
  /// Range is from -20 to 20 mapped to 0..40.
  public let level: UInt8

  public init(
    lowCut: EQLowCut, lowGain: UInt8, lowMidFreq: EQFrequency, lowMidQ: EQQ, lowMidGain: UInt8,
    highMidFreq: EQFrequency, highMidQ: EQQ, highMidGain: UInt8, highGain: UInt8,
    highCut: EQHighCut, level: UInt8
  ) {
    self.lowCut = lowCut
    self.lowGain = lowGain
    self.lowMidFreq = lowMidFreq
    self.lowMidQ = lowMidQ
    self.lowMidGain = lowMidGain
    self.highMidFreq = highMidFreq
    self.highMidQ = highMidQ
    self.highMidGain = highMidGain
    self.highGain = highGain
    self.highCut = highCut
    self.level = level
  }
}

/// The data bank representing the graphic equalizer parameters.
public struct GraphicEQBank: Sendable, Hashable {
  /// Range is from -12dB to 12dB mapped to 0..24..48 with steps of 0.5dB.
  public let band31Hz: UInt8
  public let band62Hz: UInt8
  public let band125Hz: UInt8
  public let band250Hz: UInt8
  public let band500Hz: UInt8
  public let band1kHz: UInt8
  public let band2kHz: UInt8
  public let band4kHz: UInt8
  public let band8kHz: UInt8
  public let band16kHz: UInt8
  public let level: UInt8

  public init(
    band31Hz: UInt8, band62Hz: UInt8, band125Hz: UInt8, band250Hz: UInt8, band500Hz: UInt8,
    band1kHz: UInt8, band2kHz: UInt8, band4kHz: UInt8, band8kHz: UInt8, band16kHz: UInt8,
    level: UInt8
  ) {
    self.band31Hz = band31Hz
    self.band62Hz = band62Hz
    self.band125Hz = band125Hz
    self.band250Hz = band250Hz
    self.band500Hz = band500Hz
    self.band1kHz = band1kHz
    self.band2kHz = band2kHz
    self.band4kHz = band4kHz
    self.band8kHz = band8kHz
    self.band16kHz = band16kHz
    self.level = level
  }
}

public enum EQType: UInt8, Sendable, Hashable, CaseIterable {
  case parametric = 0x00
  case graphic = 0x01
}

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

public enum EQHighCut: UInt8, Sendable, Hashable, CaseIterable {
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
  case freq1k25Hz = 0x12
  case freq1k6Hz = 0x13
  case freq2kHz = 0x14
  case freq2k5Hz = 0x15
  case freq3k15Hz = 0x16
  case freq4kHz = 0x17
  case freq5kHz = 0x18
  case freq6k3Hz = 0x19
  case freq8kHz = 0x1A
  case freq10kHz = 0x1B
}

public enum EQQ: UInt8, Sendable, Hashable, CaseIterable {
  case q05 = 0x00
  case q1 = 0x01
  case q2 = 0x02
  case q4 = 0x03
  case q8 = 0x04
  case q16 = 0x05
}

public enum EQPosition: UInt8, Sendable, Hashable, CaseIterable {
  case ampIn = 0x00
  case ampOut = 0x01
}
