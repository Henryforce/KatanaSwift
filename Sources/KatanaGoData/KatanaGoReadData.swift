import Foundation

/// Data received from the Katana GO device.
public enum KatanaGoReadData: Sendable {
  // MARK: - Status Updates

  /// Occurs when the tuner is toggled.
  case tunerChanged(on: Bool)

  /// Occurs when the active preset changes.
  case presetChanged(index: Int)

  // MARK: - Raw Data

  /// Fallback for raw MIDI commands or unhandled data.
  case midiCommand(command: UInt8, data: [UInt8])
}
