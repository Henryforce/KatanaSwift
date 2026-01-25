import KatanaCore
import KatanaMacros

// MARK: - Comp

/// The data bank representing the compressor parameters.
@KatanaFxBank
public struct CompBank: Sendable, Hashable {
  @FxParameter(id: .compType)
  public var type: CompType = .boss

  @FxIntegerParameter(id: .compSustain, range: 0...100)
  public var sustain: UInt8 = 50

  @FxIntegerParameter(id: .compAttack, range: 0...100)
  public var attack: UInt8 = 50

  @FxIntegerParameter(id: .compTone, range: 0...100)
  public var tone: UInt8 = 50

  @FxIntegerParameter(id: .compLevel, range: 0...100)
  public var level: UInt8 = 100
}

@KatanaUInt8RawBytes
public enum CompType: UInt8, Sendable, Hashable, CaseIterable {
  case boss = 0x00
  case hiBand = 0x01
  case light = 0x02
  case dComp = 0x03
  case orange = 0x04
  case fat = 0x05
  case mild = 0x06
}
