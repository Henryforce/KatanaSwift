import KatanaCore
import KatanaMacros

// MARK: - Limiter

/// The data bank representing the limiter parameters.
@KatanaFxBank
public struct LimiterBank: Sendable, Hashable {
  @FxParameter(id: .limiterType)
  public var type: LimiterType = .boss

  @FxIntegerParameter(id: .limiterAttack, range: 0...100)
  public var attack: UInt8 = 50

  @FxIntegerParameter(id: .limiterThreshold, range: 0...100)
  public var threshold: UInt8 = 50

  @FxParameter(id: .limiterRatio)
  public var ratio: LimiterRatio = .twoToOne

  @FxIntegerParameter(id: .limiterRelease, range: 0...100)
  public var release: UInt8 = 50

  @FxIntegerParameter(id: .limiterLevel, range: 0...100)
  public var level: UInt8 = 100
}

@KatanaUInt8RawBytes
public enum LimiterType: UInt8, Sendable, Hashable, CaseIterable {
  case boss = 0x00
  case rack160D = 0x01
  case vtgRackU = 0x02
}

@KatanaUInt8RawBytes
public enum LimiterRatio: UInt8, Sendable, Hashable, CaseIterable {
  case oneToOne = 0x00
  case oneDotTwoToOne = 0x01
  case oneDotFourToOne = 0x02
  case oneDotSixToOne = 0x03
  case oneDotEightToOne = 0x04
  case twoToOne = 0x05
  case twoDotThreeToOne = 0x06
  case twoDotSixToOne = 0x07
  case threeToOne = 0x08
  case threeDotFiveToOne = 0x09
  case fourToOne = 0x0A
  case fiveToOne = 0x0B
  case sixToOne = 0x0C
  case eightToOne = 0x0D
  case tenToOne = 0x0E
  case twelveToOne = 0x0F
  case twentyToOne = 0x10
  case infiniteToOne = 0x11
}
