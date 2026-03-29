import Foundation

public enum KatanaError: Error, Sendable, LocalizedError {
  case notConnected
  case connectionFailed(String)
  case encodingFailed
  case decodingFailed
  case cacheMissing

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
    }
  }
}
