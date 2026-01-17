/// Parameters for the Noise Gate.
public enum NoiseGateParameter: Sendable {
  case enable(Bool)
  case threshold(UInt8)
  case release(UInt8)
}
