/// Parameters for the Noise Gate.
public enum NoiseGateParameter: Sendable, Hashable {
  case enable(Bool)
  case threshold(UInt8)
  case release(UInt8)
}

/// The data bank representing the noise gate parameters.
public struct NoiseGateBank: Sendable, Hashable {
  public let status: Bool
  public let threshold: UInt8
  public let release: UInt8

  public init(status: Bool, threshold: UInt8, release: UInt8) {
    self.status = status
    self.threshold = threshold
    self.release = release
  }
}
