import KatanaCore
import KatanaMacros

/// The data bank representing the noise gate parameters.
@KatanaBank
public struct NoiseGateBank: Sendable, Hashable {
  @Parameter(at: 0x00)
  public var status: Bool = false

  @IntegerParameter(at: 0x01, range: 0...100)
  public var threshold: UInt8 = 50

  @IntegerParameter(at: 0x02, range: 0...100)
  public var release: UInt8 = 50

  public static let address: UInt32 = 0x20_03_40_00

  public static let size: UInt32 = 3
}
