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
  var contour: ContourBank
  var pedalFx: PedalFxBank
  var eq1Selection: EQSelectionBank
  var eq2Selection: EQSelectionBank
  var eq1Parametric: ParametricEQBank
  var eq2Parametric: ParametricEQBank
  var eq1Graphic: GraphicEQBank
  var eq2Graphic: GraphicEQBank
  var noiseGate: NoiseGateBank
}
