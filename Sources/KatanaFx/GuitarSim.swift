import KatanaCore
import KatanaMacros

// MARK: - GuitarSim

/// The data bank representing the guitar simulation parameters.
@KatanaBank
public struct GuitarSimBank: Sendable, Hashable {
  @Parameter(at: 0x00_00_00_00)
  public var type: GuitarSimType = .sToH

  @IntegerParameter(at: 0x00_00_00_01, range: 0...100)
  public var low: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_02, range: 0...100)
  public var high: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_03, range: 0...100)
  public var body: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_04, range: 0...100)
  public var level: UInt8 = 100

  public static let size: UInt32 = 5
}

@KatanaUInt8RawBytes
public enum GuitarSimType: UInt8, Sendable, Hashable, CaseIterable {
  case sToH = 0x00
  case hToS = 0x01
  case hToHF = 0x02
  case sToHollow = 0x03
  case hToHollow = 0x04
  case sToAc = 0x05
  case hToAc = 0x06
  case pToAc = 0x07
}
