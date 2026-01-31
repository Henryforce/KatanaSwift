import KatanaCore
import KatanaMacros

// MARK: - Slicer

/// The data bank representing the slicer parameters.
@KatanaFxBank
public struct SlicerBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00_00_00_00, range: 0...19)
  public var pattern: UInt8 = 0

  @IntegerParameter(at: 0x00_00_00_01, range: 0...100)
  public var rate: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_02, range: 0...100)
  public var triggerSens: UInt8 = 50

  @IntegerParameter(at: 0x00_00_00_03, range: 0...100)
  public var effectLevel: UInt8 = 100

  @IntegerParameter(at: 0x00_00_00_04, range: 0...100)
  public var directMix: UInt8 = 0

  public static let size: UInt32 = 5
}
