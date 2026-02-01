import KatanaCore
import KatanaEQ
import KatanaFx
import KatanaMacros

/// The data bank representing the reverb parameters.
@KatanaBank
public struct ReverbBank: KatanaGoBank, Sendable, Hashable {
  @Parameter(at: 0x00)
  public var type: ReverbType = .room

  @IntegerParameter(at: 0x02, range: 1...100, offsetFromMin: true)
  public var time: UInt8 = 50

  @IntegerParameter(at: 0x03, range: 0...500)
  public var preDelay: UInt16 = 0

  @Parameter(at: 0x07)
  public var lowCut: EQLowCut = .flat

  @Parameter(at: 0x08)
  public var highCut: EQHighCut = .freq630Hz

  @IntegerParameter(at: 0x09, range: 0...100)
  public var density: UInt8 = 5

  @IntegerParameter(at: 0x0A, range: 0...100)
  public var effectLevel: UInt8 = 50

  @IntegerParameter(at: 0x0B, range: 0...100)
  public var directMix: UInt8 = 0

  @IntegerParameter(at: 0x0C, range: 0...100)
  public var springSensitivity: UInt8 = 50

  public static let katanaGoAddress: UInt32 = 0x20_01_40_00

  public static let size: UInt32 = 13
}

/// Available reverb types.
@KatanaUInt8RawBytes
public enum ReverbType: UInt8, Sendable, Hashable, CaseIterable {
  case plate = 0x00
  case room = 0x01
  case hall = 0x02
  case spring = 0x03
  case modulate = 0x04
}
