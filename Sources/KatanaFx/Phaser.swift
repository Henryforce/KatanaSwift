import KatanaCore
import KatanaMacros

// MARK: - Phaser

/// The data bank representing the phaser parameters.
@KatanaBank
public struct PhaserBank: Sendable, Hashable {
  @Parameter(at: 0x00_00_00_00)
  public var type: PhaserType = .fourStage

  @IntegerParameter(at: 0x00_00_00_01, range: 0...100)
  public var rate: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_02, range: 0...100)
  public var depth: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_03, range: 0...100)
  public var manual: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_04, range: 0...100)
  public var resonance: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_05, range: 0...100)
  public var stepRate: UInt8 = 0

  @IntegerParameter(at: 0x00_00_00_06, range: 0...100)
  public var effectLevel: UInt8 = 100

  @IntegerParameter(at: 0x00_00_00_07, range: 0...100)
  public var directLevel: UInt8 = 0

  public static let size: UInt32 = 8
}

@KatanaUInt8RawBytes
public enum PhaserType: UInt8, Sendable, Hashable, CaseIterable {
  case fourStage = 0x00
  case eightStage = 0x01
  case twelveStage = 0x02
  case biStage = 0x03
}

// MARK: - Phaser90E

public enum Phaser90EParameter: Sendable, Hashable {
  case scriptEnable(Bool)
  case speed(UInt8)
}

/// The data bank representing the phaser 90E parameters.
@KatanaBank
public struct Phaser90EBank: Sendable, Hashable {
  @Parameter(at: 0x00_00_00_00)
  public var scriptStatus: Bool = false

  @IntegerParameter(at: 0x00_00_00_01, range: 0...100)
  public var speed: UInt8 = 50

  public static let size: UInt32 = 2
}
