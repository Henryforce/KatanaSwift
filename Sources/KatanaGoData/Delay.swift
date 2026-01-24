import KatanaBank
import KatanaMacros

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

/// The data bank representing the delay parameters.
public struct DelayBank: WritableBank, Sendable, Hashable {
  @Parameter(at: 0x00_00_30_03)
  public var status: Bool = false

  @Parameter(at: 0x00_01_20_00)
  public var type: DelayType = .digital

  @IntegerParameter(at: 0x00_01_20_01, range: 1...2000)
  public var time: UInt16 = 100

  @IntegerParameter(at: 0x00_01_20_05, range: 0...100)
  public var feedback: UInt8 = 50

  @Parameter(at: 0x00_01_20_06)
  public var highCut: DelayHighCutFrequency = .flat

  @IntegerParameter(at: 0x00_01_20_07, range: 0...100)
  public var effectLevel: UInt8 = 50

  @IntegerParameter(at: 0x00_01_20_08, range: 0...100)
  public var directMix: UInt8 = 0

  @IntegerParameter(at: 0x00_01_20_0A, range: 0...100)
  public var modulationRate: UInt8 = 50

  @IntegerParameter(at: 0x00_01_20_0B, range: 0...100)
  public var modulationDepth: UInt8 = 50

  @Parameter(at: 0x00_01_20_10)
  public var modulationSwitchStatus: Bool = false

  @IntegerParameter(at: 0x00_01_20_09, range: 0...100)
  public var tapTimePercentage: UInt8 = 100

  @Parameter(at: 0x00_01_20_0C)
  public var filterStatus: Bool = false

  @Parameter(at: 0x00_01_20_0D)
  public var filter: DelayFilterRange = .freq8kHz

  @Parameter(at: 0x00_01_20_0F)
  public var delayPhase: DelayPhase = .normal

  @Parameter(at: 0x00_01_20_0E)
  public var feedbackPhase: DelayPhase = .normal

  package var writeData = [WriteData]()

  init(
    status: Bool, type: DelayType, time: UInt16, feedback: UInt8, highCut: DelayHighCutFrequency,
    effectLevel: UInt8, directMix: UInt8, modulationRate: UInt8, modulationDepth: UInt8,
    modulationSwitchStatus: Bool, tapTimePercentage: UInt8, filterStatus: Bool,
    filter: DelayFilterRange, delayPhase: DelayPhase, feedbackPhase: DelayPhase
  ) {
    self.status = status
    self.type = type
    self.time = time
    self.feedback = feedback
    self.highCut = highCut
    self.effectLevel = effectLevel
    self.directMix = directMix
    self.modulationRate = modulationRate
    self.modulationDepth = modulationDepth
    self.modulationSwitchStatus = modulationSwitchStatus
    self.tapTimePercentage = tapTimePercentage
    self.filterStatus = filterStatus
    self.filter = filter
    self.delayPhase = delayPhase
    self.feedbackPhase = feedbackPhase
  }

  public init(
    status: Bool? = nil, type: DelayType? = nil, time: UInt16? = nil, feedback: UInt8? = nil,
    highCut: DelayHighCutFrequency? = nil, effectLevel: UInt8? = nil, directMix: UInt8? = nil,
    modulationRate: UInt8? = nil, modulationDepth: UInt8? = nil,
    modulationSwitchStatus: Bool? = nil, tapTimePercentage: UInt8? = nil,
    filterStatus: Bool? = nil, filter: DelayFilterRange? = nil, delayPhase: DelayPhase? = nil,
    feedbackPhase: DelayPhase? = nil
  ) {
    if let status {
      self.status = status
      self.writeData.append(WriteData(address: self.$status.address, data: status.bytes))
    }
    if let type {
      self.type = type
      self.writeData.append(WriteData(address: self.$type.address, data: type.rawValue.bytes))
    }
    if let time {
      self.time = time
      self.writeData.append(WriteData(address: self.$time.address, data: time.bytes))
    }
    if let feedback {
      self.feedback = feedback
      self.writeData.append(WriteData(address: self.$feedback.address, data: feedback.bytes))
    }
    if let highCut {
      self.highCut = highCut
      self.writeData.append(WriteData(address: self.$highCut.address, data: highCut.rawValue.bytes))
    }
    if let effectLevel {
      self.effectLevel = effectLevel
      self.writeData.append(WriteData(address: self.$effectLevel.address, data: effectLevel.bytes))
    }
    if let directMix {
      self.directMix = directMix
      self.writeData.append(WriteData(address: self.$directMix.address, data: directMix.bytes))
    }
    if let modulationRate {
      self.modulationRate = modulationRate
      self.writeData.append(
        WriteData(address: self.$modulationRate.address, data: modulationRate.bytes))
    }
    if let modulationDepth {
      self.modulationDepth = modulationDepth
      self.writeData.append(
        WriteData(address: self.$modulationDepth.address, data: modulationDepth.bytes))
    }
    if let modulationSwitchStatus {
      self.modulationSwitchStatus = modulationSwitchStatus
      self.writeData.append(
        WriteData(
          address: self.$modulationSwitchStatus.address, data: modulationSwitchStatus.bytes))
    }
    if let tapTimePercentage {
      self.tapTimePercentage = tapTimePercentage
      self.writeData.append(
        WriteData(address: self.$tapTimePercentage.address, data: tapTimePercentage.bytes))
    }
    if let filterStatus {
      self.filterStatus = filterStatus
      self.writeData.append(
        WriteData(address: self.$filterStatus.address, data: filterStatus.bytes))
    }
    if let filter {
      self.filter = filter
      self.writeData.append(WriteData(address: self.$filter.address, data: filter.rawValue.bytes))
    }
    if let delayPhase {
      self.delayPhase = delayPhase
      self.writeData.append(
        WriteData(address: self.$delayPhase.address, data: delayPhase.rawValue.bytes))
    }
    if let feedbackPhase {
      self.feedbackPhase = feedbackPhase
      self.writeData.append(
        WriteData(address: self.$feedbackPhase.address, data: feedbackPhase.rawValue.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$status.address, data: status.bytes),
        WriteData(address: self.$type.address, data: type.rawValue.bytes),
        WriteData(address: self.$time.address, data: time.bytes),
        WriteData(address: self.$feedback.address, data: feedback.bytes),
        WriteData(address: self.$highCut.address, data: highCut.rawValue.bytes),
        WriteData(address: self.$effectLevel.address, data: effectLevel.bytes),
        WriteData(address: self.$directMix.address, data: directMix.bytes),
        WriteData(address: self.$modulationRate.address, data: modulationRate.bytes),
        WriteData(address: self.$modulationDepth.address, data: modulationDepth.bytes),
        WriteData(
          address: self.$modulationSwitchStatus.address, data: modulationSwitchStatus.bytes),
        WriteData(address: self.$tapTimePercentage.address, data: tapTimePercentage.bytes),
        WriteData(address: self.$filterStatus.address, data: filterStatus.bytes),
        WriteData(address: self.$filter.address, data: filter.rawValue.bytes),
        WriteData(address: self.$delayPhase.address, data: delayPhase.rawValue.bytes),
        WriteData(address: self.$feedbackPhase.address, data: feedbackPhase.rawValue.bytes),
      ]
    }
    return self.writeData
  }
}

/// Available delay types for the Katana GO.
public enum DelayType: UInt8, Sendable, Hashable, CaseIterable {
  case digital = 0x00
  case pan = 0x01
  case stereo = 0x02
  case analog = 0x03
  case tapeEcho = 0x04
  case reverse = 0x05
  case modulate = 0x06
  case sde3000 = 0x07
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
