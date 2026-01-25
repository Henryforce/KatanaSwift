import KatanaCore
import KatanaMacros

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

  // TODO
  public init(status: Bool, position: EQPosition, type: EQType, parametric: ParametricEQBank, graphic: GraphicEQBank) {
    self.status = status
    self.position = position
    self.type = type
    self.parametric = parametric
    self.graphic = graphic
  }

  public func loadWriteData() -> [WriteData] {
    var writeData: [WriteData] = []
    if self.$status.updated {
      writeData.append(WriteData(address: self.$status.address, data: self.$status.value.bytes))
    }
    if self.$position.updated {
      writeData.append(WriteData(address: self.$position.address, data: self.$position.value.bytes))
    }
    if self.$type.updated {
      writeData.append(WriteData(address: self.$type.address, data: self.$type.value.bytes))
    }
    // if self.$parametric.updated {
    //   writeData.append(WriteData(address: self.$parametric.address, data: self.$parametric.value.bytes))
    // }
    // if self.$graphic.updated {
    //   writeData.append(WriteData(address: self.$graphic.address, data: self.$graphic.value.bytes))
    // }
    return writeData
  }
}

/// The data bank representing the parametric equalizer parameters.
@KatanaBank
public struct ParametricEQBank: Sendable, Hashable {
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
}

/// The data bank representing the graphic equalizer parameters.
@KatanaBank
public struct GraphicEQBank: Sendable, Hashable {
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
}

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
