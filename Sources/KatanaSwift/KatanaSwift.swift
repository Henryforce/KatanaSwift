@_exported import KatanaCore
import KatanaDeviceImpl

/// Entry point for the KatanaSwift library.
public enum KatanaSwift {
  /// Builds a scanner for discovering Katana devices.
  /// - Returns: A `KatanaScanner` instance capable of finding supported devices.
  public static func buildScanner() async -> KatanaScanner {
    return KatanaScannerImpl()
  }
}
