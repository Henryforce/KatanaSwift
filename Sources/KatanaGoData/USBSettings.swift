import KatanaCore
import KatanaMacros

@KatanaBank
public struct USBSettingsBank: Sendable, Hashable {
  @IntegerParameter(at: 0x00, range: 0...100)
  public var inputLevel: UInt8 = 50

  @IntegerParameter(at: 0x01, range: 0...100)
  public var outputLevel: UInt8 = 50

  @Parameter(at: 0x02)
  public var loopback: Bool = false

  public static let address: UInt32 = 0x10_01_70_00

  public static let size: UInt32 = 3
}
