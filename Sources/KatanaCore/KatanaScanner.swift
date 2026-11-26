import Foundation

/// Responsible for discovering Katana devices.
public protocol KatanaScanner: Sendable {
  /// Scans for available Katana devices.
  /// - Returns: An `AsyncStream` of discovered devices.
  func scan() -> AsyncStream<any KatanaDevice>
}
