import Foundation

public struct FxWriteData: Sendable, Hashable {
  public let id: FxID
  public let data: [UInt8]

  public init(id: FxID, data: [UInt8]) {
    self.id = id
    self.data = data
  }
}

public protocol WritableFxBank {
  func loadWriteData() -> [FxWriteData]
}
