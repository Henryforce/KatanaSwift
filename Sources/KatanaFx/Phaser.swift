import KatanaCore
import KatanaMacros

// MARK: - Phaser

/// The data bank representing the phaser parameters.
@KatanaFxBank
public struct PhaserBank: Sendable, Hashable {
  @FxParameter(id: .phaserType)
  public var type: PhaserType = .fourStage

  @FxIntegerParameter(id: .phaserRate, range: 0...100)
  public var rate: UInt8 = 50

  @FxIntegerParameter(id: .phaserDepth, range: 0...100)
  public var depth: UInt8 = 50

  @FxIntegerParameter(id: .phaserManual, range: 0...100)
  public var manual: UInt8 = 50

  @FxIntegerParameter(id: .phaserResonance, range: 0...100)
  public var resonance: UInt8 = 50

  @FxIntegerParameter(id: .phaserStepRate, range: 0...100)
  public var stepRate: UInt8 = 0

  @FxIntegerParameter(id: .phaserEffectLevel, range: 0...100)
  public var effectLevel: UInt8 = 100

  @FxIntegerParameter(id: .phaserDirectLevel, range: 0...100)
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
@KatanaFxBank
public struct Phaser90EBank: Sendable, Hashable {
  @FxParameter(id: .phaser90EScriptStatus)
  public var scriptStatus: Bool = false

  @FxIntegerParameter(id: .phaser90ESpeed, range: 0...100)
  public var speed: UInt8 = 50
}
