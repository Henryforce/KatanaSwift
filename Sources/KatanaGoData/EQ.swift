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
public struct EQBank: WritableBank, Sendable, Hashable {
  @Parameter(at: 0x00_02_60_01)
  public var status: Bool = false

  @Parameter(at: 0x00_02_60_00)
  public var position: EQPosition = .ampIn

  @Parameter(at: 0x00_02_60_02)
  public var type: EQType = .parametric

  public var parametric: ParametricEQBank

  public var graphic: GraphicEQBank

  package var writeData = [WriteData]()

  init(
    status: Bool, position: EQPosition, type: EQType, parametric: ParametricEQBank,
    graphic: GraphicEQBank
  ) {
    self.status = status
    self.position = position
    self.type = type
    self.parametric = parametric
    self.graphic = graphic
  }

  public init(
    status: Bool? = nil, position: EQPosition? = nil, type: EQType? = nil,
    parametric: ParametricEQBank? = nil, graphic: GraphicEQBank? = nil
  ) {
    let baseParametric = parametric ?? ParametricEQBank()
    let baseGraphic = graphic ?? GraphicEQBank()

    self.status = status ?? false
    self.position = position ?? .ampIn
    self.type = type ?? .parametric
    self.parametric = baseParametric
    self.graphic = baseGraphic

    if let status {
      self.writeData.append(WriteData(address: self.$status.address, data: status.bytes))
    }
    if let position {
      self.writeData.append(
        WriteData(address: self.$position.address, data: position.rawValue.bytes))
    }
    if let type {
      self.writeData.append(WriteData(address: self.$type.address, data: type.rawValue.bytes))
    }
    if let parametric {
      self.writeData.append(contentsOf: parametric.loadWriteData())
    }
    if let graphic {
      self.writeData.append(contentsOf: graphic.loadWriteData())
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$status.address, data: status.bytes),
        WriteData(address: self.$position.address, data: position.rawValue.bytes),
        WriteData(address: self.$type.address, data: type.rawValue.bytes),
      ] + parametric.loadWriteData() + graphic.loadWriteData()
    }
    return self.writeData
  }
}

/// The data bank representing the parametric equalizer parameters.
public struct ParametricEQBank: WritableBank, Sendable, Hashable {
  @Parameter(at: 0x00_03_00_00)
  public var lowCut: EQLowCut = .flat

  /// Range is from -20 to 20 mapped to 0..40.
  @IntegerParameter(at: 0x00_03_00_01, range: 0...40)
  public var lowGain: UInt8 = 20

  @Parameter(at: 0x00_03_00_02)
  public var lowMidFreq: EQFrequency = .freq200Hz

  @Parameter(at: 0x00_03_00_03)
  public var lowMidQ: EQQ = .q1

  /// Range is from -20 to 20 mapped to 0..40.
  @IntegerParameter(at: 0x00_03_00_04, range: 0...40)
  public var lowMidGain: UInt8 = 20

  @Parameter(at: 0x00_03_00_05)
  public var highMidFreq: EQFrequency = .freq2kHz

  @Parameter(at: 0x00_03_00_06)
  public var highMidQ: EQQ = .q1

  /// Range is from -20 to 20 mapped to 0..40.
  @IntegerParameter(at: 0x00_03_00_07, range: 0...40)
  public var highMidGain: UInt8 = 20

  /// Range is from -20 to 20 mapped to 0..40.
  @IntegerParameter(at: 0x00_03_00_08, range: 0...40)
  public var highGain: UInt8 = 20

  @Parameter(at: 0x00_03_00_09)
  public var highCut: EQHighCut = .flat

  /// Range is from -20 to 20 mapped to 0..40.
  @IntegerParameter(at: 0x00_03_00_0A, range: 0...40)
  public var level: UInt8 = 20

  package var writeData = [WriteData]()

  init(
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

  public init(
    lowCut: EQLowCut? = nil, lowGain: UInt8? = nil, lowMidFreq: EQFrequency? = nil,
    lowMidQ: EQQ? = nil, lowMidGain: UInt8? = nil, highMidFreq: EQFrequency? = nil,
    highMidQ: EQQ? = nil, highMidGain: UInt8? = nil, highGain: UInt8? = nil,
    highCut: EQHighCut? = nil, level: UInt8? = nil
  ) {
    if let lowCut {
      self.lowCut = lowCut
      self.writeData.append(WriteData(address: self.$lowCut.address, data: lowCut.rawValue.bytes))
    }
    if let lowGain {
      self.lowGain = lowGain
      self.writeData.append(WriteData(address: self.$lowGain.address, data: lowGain.bytes))
    }
    if let lowMidFreq {
      self.lowMidFreq = lowMidFreq
      self.writeData.append(
        WriteData(address: self.$lowMidFreq.address, data: lowMidFreq.rawValue.bytes))
    }
    if let lowMidQ {
      self.lowMidQ = lowMidQ
      self.writeData.append(WriteData(address: self.$lowMidQ.address, data: lowMidQ.rawValue.bytes))
    }
    if let lowMidGain {
      self.lowMidGain = lowMidGain
      self.writeData.append(WriteData(address: self.$lowMidGain.address, data: lowMidGain.bytes))
    }
    if let highMidFreq {
      self.highMidFreq = highMidFreq
      self.writeData.append(
        WriteData(address: self.$highMidFreq.address, data: highMidFreq.rawValue.bytes))
    }
    if let highMidQ {
      self.highMidQ = highMidQ
      self.writeData.append(
        WriteData(address: self.$highMidQ.address, data: highMidQ.rawValue.bytes))
    }
    if let highMidGain {
      self.highMidGain = highMidGain
      self.writeData.append(WriteData(address: self.$highMidGain.address, data: highMidGain.bytes))
    }
    if let highGain {
      self.highGain = highGain
      self.writeData.append(WriteData(address: self.$highGain.address, data: highGain.bytes))
    }
    if let highCut {
      self.highCut = highCut
      self.writeData.append(WriteData(address: self.$highCut.address, data: highCut.rawValue.bytes))
    }
    if let level {
      self.level = level
      self.writeData.append(WriteData(address: self.$level.address, data: level.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$lowCut.address, data: lowCut.rawValue.bytes),
        WriteData(address: self.$lowGain.address, data: lowGain.bytes),
        WriteData(address: self.$lowMidFreq.address, data: lowMidFreq.rawValue.bytes),
        WriteData(address: self.$lowMidQ.address, data: lowMidQ.rawValue.bytes),
        WriteData(address: self.$lowMidGain.address, data: lowMidGain.bytes),
        WriteData(address: self.$highMidFreq.address, data: highMidFreq.rawValue.bytes),
        WriteData(address: self.$highMidQ.address, data: highMidQ.rawValue.bytes),
        WriteData(address: self.$highMidGain.address, data: highMidGain.bytes),
        WriteData(address: self.$highGain.address, data: highGain.bytes),
        WriteData(address: self.$highCut.address, data: highCut.rawValue.bytes),
        WriteData(address: self.$level.address, data: level.bytes),
      ]
    }
    return self.writeData
  }
}

/// The data bank representing the graphic equalizer parameters.
public struct GraphicEQBank: WritableBank, Sendable, Hashable {
  /// Range is from -12dB to 12dB mapped to 0..24..48 with steps of 0.5dB.
  @IntegerParameter(at: 0x00_03_20_00, range: 0...48)
  public var band31Hz: UInt8 = 24

  @IntegerParameter(at: 0x00_03_20_01, range: 0...48)
  public var band62Hz: UInt8 = 24

  @IntegerParameter(at: 0x00_03_20_02, range: 0...48)
  public var band125Hz: UInt8 = 24

  @IntegerParameter(at: 0x00_03_20_03, range: 0...48)
  public var band250Hz: UInt8 = 24

  @IntegerParameter(at: 0x00_03_20_04, range: 0...48)
  public var band500Hz: UInt8 = 24

  @IntegerParameter(at: 0x00_03_20_05, range: 0...48)
  public var band1kHz: UInt8 = 24

  @IntegerParameter(at: 0x00_03_20_06, range: 0...48)
  public var band2kHz: UInt8 = 24

  @IntegerParameter(at: 0x00_03_20_07, range: 0...48)
  public var band4kHz: UInt8 = 24

  @IntegerParameter(at: 0x00_03_20_08, range: 0...48)
  public var band8kHz: UInt8 = 24

  @IntegerParameter(at: 0x00_03_20_09, range: 0...48)
  public var band16kHz: UInt8 = 24

  @IntegerParameter(at: 0x00_03_20_0A, range: 0...48)
  public var level: UInt8 = 24

  package var writeData = [WriteData]()

  init(
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

  public init(
    band31Hz: UInt8? = nil, band62Hz: UInt8? = nil, band125Hz: UInt8? = nil,
    band250Hz: UInt8? = nil, band500Hz: UInt8? = nil, band1kHz: UInt8? = nil,
    band2kHz: UInt8? = nil, band4kHz: UInt8? = nil, band8kHz: UInt8? = nil,
    band16kHz: UInt8? = nil, level: UInt8? = nil
  ) {
    if let band31Hz {
      self.band31Hz = band31Hz
      self.writeData.append(WriteData(address: self.$band31Hz.address, data: band31Hz.bytes))
    }
    if let band62Hz {
      self.band62Hz = band62Hz
      self.writeData.append(WriteData(address: self.$band62Hz.address, data: band62Hz.bytes))
    }
    if let band125Hz {
      self.band125Hz = band125Hz
      self.writeData.append(WriteData(address: self.$band125Hz.address, data: band125Hz.bytes))
    }
    if let band250Hz {
      self.band250Hz = band250Hz
      self.writeData.append(WriteData(address: self.$band250Hz.address, data: band250Hz.bytes))
    }
    if let band500Hz {
      self.band500Hz = band500Hz
      self.writeData.append(WriteData(address: self.$band500Hz.address, data: band500Hz.bytes))
    }
    if let band1kHz {
      self.band1kHz = band1kHz
      self.writeData.append(WriteData(address: self.$band1kHz.address, data: band1kHz.bytes))
    }
    if let band2kHz {
      self.band2kHz = band2kHz
      self.writeData.append(WriteData(address: self.$band2kHz.address, data: band2kHz.bytes))
    }
    if let band4kHz {
      self.band4kHz = band4kHz
      self.writeData.append(WriteData(address: self.$band4kHz.address, data: band4kHz.bytes))
    }
    if let band8kHz {
      self.band8kHz = band8kHz
      self.writeData.append(WriteData(address: self.$band8kHz.address, data: band8kHz.bytes))
    }
    if let band16kHz {
      self.band16kHz = band16kHz
      self.writeData.append(WriteData(address: self.$band16kHz.address, data: band16kHz.bytes))
    }
    if let level {
      self.level = level
      self.writeData.append(WriteData(address: self.$level.address, data: level.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$band31Hz.address, data: band31Hz.bytes),
        WriteData(address: self.$band62Hz.address, data: band62Hz.bytes),
        WriteData(address: self.$band125Hz.address, data: band125Hz.bytes),
        WriteData(address: self.$band250Hz.address, data: band250Hz.bytes),
        WriteData(address: self.$band500Hz.address, data: band500Hz.bytes),
        WriteData(address: self.$band1kHz.address, data: band1kHz.bytes),
        WriteData(address: self.$band2kHz.address, data: band2kHz.bytes),
        WriteData(address: self.$band4kHz.address, data: band4kHz.bytes),
        WriteData(address: self.$band8kHz.address, data: band8kHz.bytes),
        WriteData(address: self.$band16kHz.address, data: band16kHz.bytes),
        WriteData(address: self.$level.address, data: level.bytes),
      ]
    }
    return self.writeData
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
