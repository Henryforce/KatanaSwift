import Foundation

public struct WriteData: Sendable, Hashable {
  public let address: UInt32
  public let data: [UInt8]

  public init(address: UInt32, data: [UInt8]) {
    self.address = address
    self.data = data
  }
}

public protocol WritableBank {
  func loadWriteData() -> [WriteData]
}
