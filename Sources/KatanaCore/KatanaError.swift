import Foundation

public enum KatanaError: Error, Sendable, Hashable, LocalizedError {
  case notConnected
  case connectionFailed(String)
  case encodingFailed
  case decodingFailed
  case cacheMissing
  case timeout

  public var errorDescription: String? {
    switch self {
    case .notConnected:
      return "The device is not connected."
    case .connectionFailed(let message):
      return "Connection failed: \(message)"
    case .encodingFailed:
      return "Failed to encode data for the device."
    case .decodingFailed:
      return "Failed to decode data from the device."
    case .cacheMissing:
      return "The requested data was not found in the cache."
    case .timeout:
      return "The operation timed out waiting for a response from the device."
    }
  }
}
