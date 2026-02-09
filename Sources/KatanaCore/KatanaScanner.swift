import Foundation

/// Responsible for discovering Katana devices.
public protocol KatanaScanner: Sendable {
  /// Scans for available Katana devices.
  /// Returns an AsyncStream of discovered devices.
  func scan() async -> AsyncStream<KatanaDevice>
}
