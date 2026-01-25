import KatanaFx
import KatanaGoData

struct KatanaGoState: Sendable, Hashable {
  var amp: AmpBank
  var boost: BoostBank
  var mod: ModFxBank
  var fx: ModFxBank
  var delay1: DelayBank
  var delay2: DelayBank
  var reverb: ReverbBank
  var solo: SoloBank
  var eq1: EQBank
  var eq2: EQBank
  var noiseGate: NoiseGateBank
}
