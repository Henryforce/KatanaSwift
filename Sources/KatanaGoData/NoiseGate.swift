/// Parameters for the Noise Gate.
public enum NoiseGateParameter: Sendable, Hashable {
  case enable(Bool)
  case threshold(UInt8)
  case release(UInt8)
}

/// The data bank representing the noise gate parameters.
public struct NoiseGateBank: WritableBank, Sendable, Hashable {
  @Parameter(at: 0x00_03_40_00)
  public var status: Bool = false

  @IntegerParameter(at: 0x00_03_40_01, range: 0...100)
  public var threshold: UInt8 = 50

  @IntegerParameter(at: 0x00_03_40_02, range: 0...100)
  public var release: UInt8 = 50

  package var writeData = [WriteData]()

  init(status: Bool, threshold: UInt8, release: UInt8) {
    self.status = status
    self.threshold = threshold
    self.release = release
  }

  public init(status: Bool? = nil, threshold: UInt8? = nil, release: UInt8? = nil) {
    if let status {
      self.status = status
      self.writeData.append(WriteData(address: self.$status.address, data: status.bytes))
    }
    if let threshold {
      self.threshold = threshold
      self.writeData.append(WriteData(address: self.$threshold.address, data: threshold.bytes))
    }
    if let release {
      self.release = release
      self.writeData.append(WriteData(address: self.$release.address, data: release.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$status.address, data: status.bytes),
        WriteData(address: self.$threshold.address, data: threshold.bytes),
        WriteData(address: self.$release.address, data: release.bytes),
      ]
    }
    return self.writeData
  }
}
