import KatanaCore
import KatanaMacros

// MARK: - GuitarSim

/// The data bank representing the guitar simulation parameters.
@KatanaFxBank
public struct GuitarSimBank: Sendable, Hashable {
  @FxParameter(id: .guitarSimType)
  public var type: GuitarSimType = .sToH

  @FxIntegerParameter(id: .guitarSimLow, range: 0...100)
  public var low: UInt8 = 50

  @FxIntegerParameter(id: .guitarSimHigh, range: 0...100)
  public var high: UInt8 = 50

  @FxIntegerParameter(id: .guitarSimBody, range: 0...100)
  public var body: UInt8 = 50

  @FxIntegerParameter(id: .guitarSimLevel, range: 0...100)
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
