import KatanaCore
import KatanaMacros

// MARK: - Phaser

/// The data bank representing the phaser parameters.
@KatanaBank
public struct PhaserBank: Sendable, Hashable {
  @Parameter(at: 0x00_01_00_11)
  public var type: PhaserType = .fourStage

  @IntegerParameter(at: 0x00_01_00_12, range: 0...100)
  public var rate: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_13, range: 0...100)
  public var depth: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_14, range: 0...100)
  public var manual: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_15, range: 0...100)
  public var resonance: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_16, range: 0...100)
  public var stepRate: UInt8 = 0

  @IntegerParameter(at: 0x00_01_00_17, range: 0...100)
  public var effectLevel: UInt8 = 100

  @IntegerParameter(at: 0x00_01_00_18, range: 0...100)
  public var directLevel: UInt8 = 0
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
  @Parameter(at: 0x00_01_01_41)
  public var scriptStatus: Bool = false

  @IntegerParameter(at: 0x00_01_01_42, range: 0...100)
  public var speed: UInt8 = 50
}
