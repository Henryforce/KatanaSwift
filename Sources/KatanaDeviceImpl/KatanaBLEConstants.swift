@preconcurrency import CoreBluetooth

/// BLE constants for Katana device discovery.
enum KatanaBLEConstants {
  /// BLE MIDI Service UUID advertised by Katana devices.
  nonisolated(unsafe) static let midiServiceUUID = CBUUID(string: "03B80E5A-EDE8-4B33-A751-6CE34EC4C700")
  
  /// BLE MIDI I/O Characteristic UUID.
  nonisolated(unsafe) static let midiCharacteristicUUID = CBUUID(string: "7772E5DB-3868-4112-A1A9-F2669D106BF3")
  
  /// The substring that must appear in the peripheral's advertised name.
  static let deviceNameFilter = "Katana"
}
