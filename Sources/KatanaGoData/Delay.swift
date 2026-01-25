import KatanaCore
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
@KatanaBank
public struct DelayBank: Sendable, Hashable {
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
}

/// Available delay types for the Katana GO.
@KatanaUInt8RawBytes
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

@KatanaUInt8RawBytes
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

@KatanaUInt8RawBytes
public enum DelayFilterRange: UInt8, Sendable, Hashable, CaseIterable {
  case freq8kHz = 0x00
  case freq17kHz = 0x01
}

@KatanaUInt8RawBytes
public enum DelayPhase: UInt8, Sendable, Hashable, CaseIterable {
  case normal = 0x00
  case inverted = 0x01
}
