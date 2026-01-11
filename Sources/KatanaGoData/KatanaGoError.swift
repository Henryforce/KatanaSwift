import Foundation

public enum KatanaGoError: Error, Sendable {
  case notConnected
  case connectionFailed(String)
  case encodingFailed
  case decodingFailed
}
