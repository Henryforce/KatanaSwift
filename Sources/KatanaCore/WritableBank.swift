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
  static var address: UInt32 { get }
  static var size: UInt32 { get }

  func loadWriteData() -> [WriteData]

  static func buildFromByteArray(_ array: [UInt8]) -> Self
}
