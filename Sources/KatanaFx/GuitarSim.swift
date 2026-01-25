import KatanaCore
import KatanaMacros

// MARK: - GuitarSim

public enum GuitarSimParameter: Sendable, Hashable {
  case type(GuitarSimType)
  /// Range is from -50 to 50 mapped to 0..100.
  case low(UInt8)
  /// Range is from -50 to 50 mapped to 0..100.
  case high(UInt8)
  case body(UInt8)
  case level(UInt8)
}

/// The data bank representing the guitar simulation parameters.
@KatanaBank
public struct GuitarSimBank: Sendable, Hashable {
  @Parameter(at: 0x00_01_00_61)
  public var type: GuitarSimType = .sToH

  @IntegerParameter(at: 0x00_01_00_62, range: 0...100)
  public var low: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_63, range: 0...100)
  public var high: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_64, range: 0...100)
  public var body: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_65, range: 0...100)
  public var level: UInt8 = 100
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
