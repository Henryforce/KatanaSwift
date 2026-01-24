/// Parameters for the Noise Gate.
public enum NoiseGateParameter: Sendable, Hashable {
  case enable(Bool)
  case threshold(UInt8)
  case release(UInt8)
}

/// The data bank representing the noise gate parameters.
public struct NoiseGateBank: Sendable, Hashable {
  @Parameter(at: 0x00_03_40_00)
  public var status: Bool = false

  @IntegerParameter(at: 0x00_03_40_01, range: 0...100)
  public var threshold: UInt8 = 50

  @IntegerParameter(at: 0x00_03_40_02, range: 0...100)
  public var release: UInt8 = 50

  public init(status: Bool, threshold: UInt8, release: UInt8) {
    self.status = status
    self.threshold = threshold
    self.release = release
  }
}
