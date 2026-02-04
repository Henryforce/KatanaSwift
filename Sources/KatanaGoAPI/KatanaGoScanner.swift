import Foundation
import KatanaGoData

/// Responsible for discovering Katana GO devices.
public protocol KatanaGoScanner: Sendable {
  /// Scans for available Katana GO devices.
  /// Returns an AsyncStream of discovered devices.
  func scan() -> AsyncStream<KatanaDevice>
}
