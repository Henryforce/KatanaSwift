import KatanaCore
import KatanaMacros

// MARK: - WaveSynth

/// The data bank representing the wave synth parameters.
@KatanaFxBank
public struct WaveSynthBank: Sendable, Hashable {
  @FxParameter(id: .waveSynthType)
  public var type: WaveSynthType = .saw

  @FxIntegerParameter(id: .waveSynthCutoff, range: 0...100)
  public var cutoff: UInt8 = 50

  @FxIntegerParameter(id: .waveSynthResonance, range: 0...100)
  public var resonance: UInt8 = 50

  @FxIntegerParameter(id: .waveSynthFilterSens, range: 0...100)
  public var filterSens: UInt8 = 50

  @FxIntegerParameter(id: .waveSynthFilterDecay, range: 0...100)
  public var filterDecay: UInt8 = 50

  @FxIntegerParameter(id: .waveSynthFilterDepth, range: 0...100)
  public var filterDepth: UInt8 = 50

  @FxIntegerParameter(id: .waveSynthSynthLevel, range: 0...100)
  public var synthLevel: UInt8 = 100

  @FxIntegerParameter(id: .waveSynthDirectMix, range: 0...100)
  public var directMix: UInt8 = 0
}

@KatanaUInt8RawBytes
public enum WaveSynthType: UInt8, Sendable, Hashable, CaseIterable {
  case saw = 0x00
  case square = 0x01
}
