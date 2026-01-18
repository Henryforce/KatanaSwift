/// Parameters for the Noise Gate.
public enum NoiseGateParameter: Sendable, Hashable {
  case enable(Bool)
  case threshold(UInt8)
  case release(UInt8)
}
