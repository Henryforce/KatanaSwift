import KatanaCore
import KatanaMacros

/// A bank representing the operating mode of the device (Guitar or Bass).
@KatanaBank
public struct ModeBank: KatanaGoBank, Sendable, Hashable {
  /// The current operating mode.
  @Parameter(at: 0x00)
  public var mode: KatanaGoMode = .guitar

  public static let katanaGoAddress: UInt32 = 0x7F_01_00_04

  public static let size: UInt32 = 1
}

/// The available operating modes for the Katana GO.
@KatanaUInt8RawBytes
public enum KatanaGoMode: UInt8, Sendable, Hashable, CaseIterable {
  /// Optimized for guitar features and effects.
  case guitar = 0
  /// Optimized for bass features and effects.
  case bass = 1
}
