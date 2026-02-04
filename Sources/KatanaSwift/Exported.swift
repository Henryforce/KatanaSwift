@_exported import KatanaCore
import KatanaDeviceImpl
@_exported import KatanaGoAPI

public enum KatanaSwift {
  public static func buildScanner() async -> KatanaGoScanner {
    return KatanaGoScannerMIDIKit()
  }
}
