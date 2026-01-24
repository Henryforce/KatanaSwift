import KatanaCore
import KatanaMacros

// MARK: - PitchShifter

/// The data bank representing the pitch shifter parameters.
@KatanaBank
public struct PitchShifterBank: Sendable, Hashable {
  @Parameter(at: 0x00_01_00_7F)
  public var voice: PitchShifterVoice = .oneVoice

  @Parameter(at: 0x00_01_01_00)
  public var ps1Mode: PitchShifterMode = .fast

  @IntegerParameter(at: 0x00_01_01_01, range: 0...100)
  public var ps1Pitch: UInt8 = 50

  @IntegerParameter(at: 0x00_01_01_02, range: 0...100)
  public var ps1Fine: UInt8 = 50

  @IntegerParameter(at: 0x00_01_01_03, range: 0...300)
  public var ps1PreDelay: UInt16 = 0

  @IntegerParameter(at: 0x00_01_01_07, range: 0...100)
  public var ps1Level: UInt8 = 100

  @Parameter(at: 0x00_01_01_08)
  public var ps2Mode: PitchShifterMode = .fast

  @IntegerParameter(at: 0x00_01_01_09, range: 0...100)
  public var ps2Pitch: UInt8 = 50

  @IntegerParameter(at: 0x00_01_01_0A, range: 0...100)
  public var ps2Fine: UInt8 = 50

  @IntegerParameter(at: 0x00_01_01_0B, range: 0...300)
  public var ps2PreDelay: UInt16 = 0

  @IntegerParameter(at: 0x00_01_01_0F, range: 0...100)
  public var ps2Level: UInt8 = 100

  @IntegerParameter(at: 0x00_01_01_10, range: 0...100)
  public var ps1Feedback: UInt8 = 0

  @IntegerParameter(at: 0x00_01_01_11, range: 0...100)
  public var directLevel: UInt8 = 0
}

@KatanaUInt8RawBytes
public enum PitchShifterVoice: UInt8, Sendable, Hashable, CaseIterable {
  case oneVoice = 0x00
  case twoVoice = 0x01
}

@KatanaUInt8RawBytes
public enum PitchShifterMode: UInt8, Sendable, Hashable, CaseIterable {
  case fast = 0x00
  case medium = 0x01
  case slow = 0x02
  case mono = 0x03
}
