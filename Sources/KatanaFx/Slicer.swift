import KatanaCore
import KatanaMacros

// MARK: - Slicer

/// The data bank representing the slicer parameters.
@KatanaBank
public struct SlicerBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00_01_00_2D, range: 0...19)
  public var pattern: UInt8 = 0

  @IntegerParameter(at: 0x00_01_00_2E, range: 0...100)
  public var rate: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_2F, range: 0...100)
  public var triggerSens: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_30, range: 0...100)
  public var effectLevel: UInt8 = 100

  @IntegerParameter(at: 0x00_01_00_31, range: 0...100)
  public var directMix: UInt8 = 0
}
