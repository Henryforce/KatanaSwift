import Foundation
import KatanaFx

public struct KatanaGoReadOptions: OptionSet, Sendable, Hashable {
  public let rawValue: Int

  public static let preset = KatanaGoReadOptions(rawValue: 1 << 0)
  public static let amp = KatanaGoReadOptions(rawValue: 1 << 1)
  public static let boost = KatanaGoReadOptions(rawValue: 1 << 2)
  public static let mod = KatanaGoReadOptions(rawValue: 1 << 3)
  public static let fx = KatanaGoReadOptions(rawValue: 1 << 4)
  public static let delay1 = KatanaGoReadOptions(rawValue: 1 << 5)
  public static let delay2 = KatanaGoReadOptions(rawValue: 1 << 6)
  public static let reverb = KatanaGoReadOptions(rawValue: 1 << 7)
  public static let solo = KatanaGoReadOptions(rawValue: 1 << 8)
  public static let eq1 = KatanaGoReadOptions(rawValue: 1 << 9)
  public static let eq2 = KatanaGoReadOptions(rawValue: 1 << 10)
  public static let noiseGate = KatanaGoReadOptions(rawValue: 1 << 11)

  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
}

/// Data received from the Katana GO device.
public enum KatanaGoReadData: Sendable {
  case preset(Preset)
  case ampBank(AmpBank)
  case boostBank(BoostBank)
  case modBank(ModFxBank)
  case fxBank(ModFxBank)
  case delay1Bank(DelayBank)
  case delay2Bank(DelayBank)
  case reverbBank(ReverbBank)
  case soloBank(SoloBank)
  case eq1Bank(EQBank)
  case eq2Bank(EQBank)
  case noiseGateBank(NoiseGateBank)
}
