import KatanaCore
import KatanaMacros

// MARK: - WaveSynth

/// The data bank representing the wave synth parameters.
@KatanaFxBank
public struct WaveSynthBank: Sendable, Hashable {
  @Parameter(at: 0x00_00_00_00)
  public var type: WaveSynthType = .saw

  @IntegerParameter(at: 0x00_00_00_01, range: 0...100)
  public var cutoff: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_02, range: 0...100)
  public var resonance: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_03, range: 0...100)
  public var filterSens: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_04, range: 0...100)
  public var filterDecay: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_05, range: 0...100)
  public var filterDepth: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_06, range: 0...100)
  public var synthLevel: UInt8 = 100

  @IntegerParameter(at: 0x00_00_00_07, range: 0...100)
  public var directMix: UInt8 = 0

  public static let size: UInt32 = 8
}

@KatanaUInt8RawBytes
public enum WaveSynthType: UInt8, Sendable, Hashable, CaseIterable {
  case saw = 0x00
  case square = 0x01
}
