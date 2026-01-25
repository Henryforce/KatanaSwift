import KatanaCore
import KatanaMacros
import KatanaEQ

// MARK: - AcousticPro

/// The data bank representing the acoustic pro parameters.
@KatanaFxBank
public struct AcousticProBank: Sendable, Hashable {
  @FxParameter(id: .acousticProType)
  public var type: AcousticProType = .small

  @FxIntegerParameter(id: .acousticProBass, range: 0...100)
  public var bass: UInt8 = 50

  @FxIntegerParameter(id: .acousticProMiddle, range: 0...100)
  public var middle: UInt8 = 50

  @FxParameter(id: .acousticProMidFrequency)
  public var midFrequency: EQFrequency = .freq500Hz

  @FxIntegerParameter(id: .acousticProTreble, range: 0...100)
  public var treble: UInt8 = 50

  @FxIntegerParameter(id: .acousticProPresence, range: 0...100)
  public var presence: UInt8 = 50

  @FxIntegerParameter(id: .acousticProLevel, range: 0...100)
  public var level: UInt8 = 100
}

@KatanaUInt8RawBytes
public enum AcousticProType: UInt8, Sendable, Hashable, CaseIterable {
  case small = 0x00
  case medium = 0x01
  case bright = 0x02
  case power = 0x03
}
