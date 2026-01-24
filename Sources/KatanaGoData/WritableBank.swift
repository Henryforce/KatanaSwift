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

/// The bank ID for the bank index.
public enum BankID: Sendable, Hashable {
  case id1
  case id2
  case id3
  case id4
}
