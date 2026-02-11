import KatanaCore
import KatanaMacros

/// The bank ID address modifier for the bank index.
public enum DelayBankChannel: UInt32, Sendable, Hashable {
  case one = 0x0000
  case two = 0x1000
}

/// The data bank representing the delay parameters.
@KatanaBank
public struct DelayBank: KatanaGoChannelAddressableBank, Sendable, Hashable {
  @Parameter(at: 0x00)
  public var type: DelayType = .digital

  @IntegerParameter(at: 0x01, range: 1...2000)
  public var time: UInt16 = 100

  @IntegerParameter(at: 0x05, range: 0...100)
  public var feedback: UInt8 = 50

  @Parameter(at: 0x06)
  public var highCut: DelayHighCutFrequency = .flat

  @IntegerParameter(at: 0x07, range: 0...100)
  public var effectLevel: UInt8 = 50

  @IntegerParameter(at: 0x08, range: 0...100)
  public var directMix: UInt8 = 0

  @IntegerParameter(at: 0x0A, range: 0...100)
  public var modulationRate: UInt8 = 50

  @IntegerParameter(at: 0x0B, range: 0...100)
  public var modulationDepth: UInt8 = 50

  @Parameter(at: 0x10)
  public var modulationSwitchStatus: Bool = false

  @IntegerParameter(at: 0x09, range: 0...100)
  public var tapTimePercentage: UInt8 = 100

  @Parameter(at: 0x0C)
  public var filterStatus: Bool = false

  @Parameter(at: 0x0D)
  public var filter: DelayFilterRange = .freq8kHz

  @Parameter(at: 0x0F)
  public var delayPhase: DelayPhase = .normal

  @Parameter(at: 0x0E)
  public var feedbackPhase: DelayPhase = .normal

  public static let katanaGoAddress: UInt32 = 0x20_01_20_00

  public static let size: UInt32 = 17

  public static let channelType = DelayBankChannel.self
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
