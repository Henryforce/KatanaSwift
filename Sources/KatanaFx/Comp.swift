import KatanaCore
import KatanaMacros

// MARK: - Comp

/// The data bank representing the compressor parameters.
@KatanaBank
public struct CompBank: Sendable, Hashable {
  @Parameter(at: 0x00_00_00_00)
  public var type: CompType = .boss

  @IntegerParameter(at: 0x00_00_00_01, range: 0...100)
  public var sustain: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_02, range: 0...100)
  public var attack: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_03, range: 0...100)
  public var tone: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_04, range: 0...100)
  public var level: UInt8 = 100

  public static let size: UInt32 = 5
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
