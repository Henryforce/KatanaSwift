import Foundation

/// Data received from the Katana GO device.
public enum KatanaGoReadData: Sendable {
  // MARK: - Status Updates

  /// Occurs when the tuner is toggled.
  case tunerChanged(on: Bool)

  /// Occurs when the active preset changes.
  case presetChanged(index: Int)

  // MARK: - Raw Data

  /// Fallback for raw MIDI commands or unhandled data.
  case midiCommand(command: UInt8, data: [UInt8])
}

public struct KatanaGoState: Sendable, Hashable {
  public var amp: AmpBank
  public var boost: BoostBank
  public var mod: ModFxBank
  public var fx: ModFxBank
  public var delay1: DelayBank
  public var delay2: DelayBank
  public var reverb: ReverbBank
  public var solo: SoloBank
  public var eq1: EQBank
  public var eq2: EQBank
  public var noiseGate: NoiseGateBank

  public init(
    amp: AmpBank, boost: BoostBank, mod: ModFxBank, fx: ModFxBank, delay1: DelayBank,
    delay2: DelayBank, reverb: ReverbBank, solo: SoloBank, eq1: EQBank, eq2: EQBank,
    noiseGate: NoiseGateBank
  ) {
    self.amp = amp
    self.boost = boost
    self.mod = mod
    self.fx = fx
    self.delay1 = delay1
    self.delay2 = delay2
    self.reverb = reverb
    self.solo = solo
    self.eq1 = eq1
    self.eq2 = eq2
    self.noiseGate = noiseGate
  }
}
