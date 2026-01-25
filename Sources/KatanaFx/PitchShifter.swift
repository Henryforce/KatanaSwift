import KatanaCore
import KatanaMacros

// MARK: - PitchShifter

/// The data bank representing the pitch shifter parameters.
@KatanaFxBank
public struct PitchShifterBank: Sendable, Hashable {
  @FxParameter(id: .pitchShifterVoice)
  public var voice: PitchShifterVoice = .oneVoice

  @FxParameter(id: .pitchShifterPs1Mode)
  public var ps1Mode: PitchShifterMode = .fast

  @FxIntegerParameter(id: .pitchShifterPs1Pitch, range: 0...100)
  public var ps1Pitch: UInt8 = 50

  @FxIntegerParameter(id: .pitchShifterPs1Fine, range: 0...100)
  public var ps1Fine: UInt8 = 50

  @FxIntegerParameter(id: .pitchShifterPs1PreDelay, range: 0...300)
  public var ps1PreDelay: UInt16 = 0

  @FxIntegerParameter(id: .pitchShifterPs1Level, range: 0...100)
  public var ps1Level: UInt8 = 100

  @FxParameter(id: .pitchShifterPs2Mode)
  public var ps2Mode: PitchShifterMode = .fast

  @FxIntegerParameter(id: .pitchShifterPs2Pitch, range: 0...100)
  public var ps2Pitch: UInt8 = 50

  @FxIntegerParameter(id: .pitchShifterPs2Fine, range: 0...100)
  public var ps2Fine: UInt8 = 50

  @FxIntegerParameter(id: .pitchShifterPs2PreDelay, range: 0...300)
  public var ps2PreDelay: UInt16 = 0

  @FxIntegerParameter(id: .pitchShifterPs2Level, range: 0...100)
  public var ps2Level: UInt8 = 100

  @FxIntegerParameter(id: .pitchShifterPs1Feedback, range: 0...100)
  public var ps1Feedback: UInt8 = 0

  @FxIntegerParameter(id: .pitchShifterDirectLevel, range: 0...100)
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
