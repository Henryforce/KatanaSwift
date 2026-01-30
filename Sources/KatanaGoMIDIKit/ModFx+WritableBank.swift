import KatanaCore
import KatanaFx

extension AcousticProBank: WritableBank {
  public static let address: UInt32 = 0x20_01_00_6A

  public func loadWriteData() -> [WriteData] {
    return loadWriteData(baseAddress: Self.address)
  }
}
