import KatanaCore
import KatanaMacros

// MARK: - WaveSynth

/// The data bank representing the wave synth parameters.
@KatanaBank
public struct WaveSynthBank: Sendable, Hashable {
  @Parameter(at: 0x00_01_00_71)
  public var type: WaveSynthType = .saw

  @IntegerParameter(at: 0x00_01_00_72, range: 0...100)
  public var cutoff: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_73, range: 0...100)
  public var resonance: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_74, range: 0...100)
  public var filterSens: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_75, range: 0...100)
  public var filterDecay: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_76, range: 0...100)
  public var filterDepth: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_77, range: 0...100)
  public var synthLevel: UInt8 = 100

  @IntegerParameter(at: 0x00_01_00_78, range: 0...100)
  public var directMix: UInt8 = 0
}

@KatanaUInt8RawBytes
public enum WaveSynthType: UInt8, Sendable, Hashable, CaseIterable {
  case saw = 0x00
  case square = 0x01
}
