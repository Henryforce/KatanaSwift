import KatanaCore
import KatanaMacros

// MARK: - PitchShifter

/// The data bank representing the pitch shifter parameters.
@KatanaFxBank
public struct PitchShifterBank: Sendable, Hashable {
  @Parameter(at: 0x00_00_00_00)
  public var voice: PitchShifterVoice = .oneVoice

  // TODO: update address modifier as this one can go above 0x00_00_00_7F, so it should not
  // 0x00_00_00_8F but 0x00_00_01_00.

  @Parameter(at: 0x00_00_00_01)
  public var ps1Mode: PitchShifterMode = .fast

  @IntegerParameter(at: 0x00_00_00_02, range: 0...100)
  public var ps1Pitch: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_03, range: 0...100)
  public var ps1Fine: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_04, range: 0...300)
  public var ps1PreDelay: UInt16 = 0

  @IntegerParameter(at: 0x00_00_00_08, range: 0...100)
  public var ps1Level: UInt8 = 100

  @Parameter(at: 0x00_00_00_09)
  public var ps2Mode: PitchShifterMode = .fast

  @IntegerParameter(at: 0x00_00_00_0A, range: 0...100)
  public var ps2Pitch: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_0B, range: 0...100)
  public var ps2Fine: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_0C, range: 0...300)
  public var ps2PreDelay: UInt16 = 0

  @IntegerParameter(at: 0x00_00_00_10, range: 0...100)
  public var ps2Level: UInt8 = 100

  @IntegerParameter(at: 0x00_00_00_11, range: 0...100)
  public var ps1Feedback: UInt8 = 0

  @IntegerParameter(at: 0x00_00_00_12, range: 0...100)
  public var directLevel: UInt8 = 0

  public static let size: UInt32 = 19
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
