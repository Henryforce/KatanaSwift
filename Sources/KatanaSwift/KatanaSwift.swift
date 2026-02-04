@_exported import KatanaCore
import KatanaDeviceImpl

public enum KatanaSwift {
  public static func buildScanner() async -> KatanaScanner {
    return KatanaGoScannerMIDIKit()
  }
}
