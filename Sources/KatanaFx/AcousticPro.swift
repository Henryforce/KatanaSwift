import KatanaCore
import KatanaEQ
import KatanaMacros

// MARK: - AcousticPro

/// The data bank representing the acoustic pro parameters.
@KatanaBank
public struct AcousticProBank: Sendable, Hashable {
  @Parameter(at: 0x00_00_00_00)
  public var type: AcousticProType = .small

  @IntegerParameter(at: 0x00_00_00_01, range: 0...100)
  public var bass: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_02, range: 0...100)
  public var middle: UInt8 = 50

  @Parameter(at: 0x00_00_00_03)
  public var midFrequency: EQFrequency = .freq500Hz

  @IntegerParameter(at: 0x00_00_00_04, range: 0...100)
  public var treble: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_05, range: 0...100)
  public var presence: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_06, range: 0...100)
  public var level: UInt8 = 100

  public static let size: UInt32 = 7
}

@KatanaUInt8RawBytes
public enum AcousticProType: UInt8, Sendable, Hashable, CaseIterable {
  case small = 0x00
  case medium = 0x01
  case bright = 0x02
  case power = 0x03
}
