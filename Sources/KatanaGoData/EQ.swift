import KatanaCore
import KatanaEQ
import KatanaMacros

// MARK - EQ

/// The data bank representing the equalizer parameters.
public struct EQBank: WritableBank, Sendable, Hashable {
  @Parameter(at: 0x20_02_60_01)
  public var status: Bool = false

  @Parameter(at: 0x20_02_60_00)
  public var position: EQPosition = .ampIn

  @Parameter(at: 0x20_02_60_02)
  public var type: EQType = .parametric

  public var parametric: ParametricEQBank

  public var graphic: GraphicEQBank

  package var writeData = [WriteData]()

  // TODO
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
