import Foundation

public enum KatanaError: Error, Sendable {
  case notConnected
  case connectionFailed(String)
  case encodingFailed
  case decodingFailed
  case cacheMissing
}
