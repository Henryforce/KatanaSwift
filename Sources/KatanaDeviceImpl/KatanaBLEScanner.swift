import CoreBluetooth
import CoreMIDI
import Foundation

/// Manages BLE scanning and connection for Katana devices.
/// This class bridges CoreBluetooth's delegate-based API and handles the BLE-MIDI mode switch.
final class KatanaBLEScanner: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate, @unchecked Sendable {
  private var centralManager: CBCentralManager!
  private var discoveredPeripheral: CBPeripheral?
  private var midiCharacteristic: CBCharacteristic?

  /// Tracks whether the BLE-MIDI mode switch SysEx was written successfully.
  /// When true, an intentional disconnect is in progress — the disconnect handler
  /// should treat it as success and activate the CoreMIDI BLE driver.
  private var modeSwitchCompleted: Bool = false

  /// Continuation for async/await bridging.
  private var scanContinuation: CheckedContinuation<Bool, Never>?
  
  private let queue = DispatchQueue(label: "com.katana.ble-scanner", qos: .userInitiated)

  override init() {
    super.init()
    print("[KatanaBLEScanner] Initializing Central Manager on background queue")
    centralManager = CBCentralManager(delegate: self, queue: queue)
  }

  // MARK: - Public API

  /// Scans for a Katana BLE device, connects, and switches it to BLE-MIDI mode.
  /// Returns `true` if a device was successfully switched, `false` otherwise.
  func scanAndActivate(timeout: TimeInterval = 10) async -> Bool {
    print("[KatanaBLEScanner] Starting scanAndActivate with timeout: \(timeout)s")
    return await withCheckedContinuation { continuation in
      self.scanContinuation = continuation
      
      // Start timeout timer to prevent indefinite scanning
      queue.asyncAfter(deadline: .now() + timeout) { [weak self] in
        guard let self = self, self.scanContinuation != nil else { return }
        print("[KatanaBLEScanner] Scan timed out after \(timeout)s")
        self.finishScan(success: false)
      }
      
      // Check state and scan
      if centralManager.state == .poweredOn {
        print("[KatanaBLEScanner] Central Manager is powered on, starting scan...")
        startScanning()
      } else {
        print("[KatanaBLEScanner] Waiting for Central Manager to power on (current state: \(centralManager.state.rawValue))")
      }
    }
  }

  /// Stops any active BLE scan and cleans up.
  func stop() {
    print("[KatanaBLEScanner] Stopping scan and cleaning up")
    queue.async {
      self.centralManager.stopScan()
      if let peripheral = self.discoveredPeripheral {
        print("[KatanaBLEScanner] Cancelling connection to \(peripheral.name ?? "Unknown Device")")
        self.centralManager.cancelPeripheralConnection(peripheral)
      }
      self.discoveredPeripheral = nil
      self.midiCharacteristic = nil
      self.scanContinuation = nil
    }
  }

  // MARK: - Internal

  private func startScanning() {
    print("[KatanaBLEScanner] Scanning for peripherals with service: \(KatanaBLEConstants.midiServiceUUID)")
    centralManager.scanForPeripherals(
      withServices: [KatanaBLEConstants.midiServiceUUID],
      options: [CBCentralManagerScanOptionAllowDuplicatesKey: false]
    )
  }

  private func finishScan(success: Bool) {
    print("[KatanaBLEScanner] Finishing scan session. Success: \(success)")
    if let continuation = scanContinuation {
      continuation.resume(returning: success)
      scanContinuation = nil
      centralManager.stopScan()
    }
    // Clean up references regardless of success/failure
    discoveredPeripheral = nil
    midiCharacteristic = nil
    modeSwitchCompleted = false
  }

  // MARK: - CBCentralManagerDelegate

  func centralManagerDidUpdateState(_ central: CBCentralManager) {
    print("[KatanaBLEScanner] Central Manager state updated: \(central.state.rawValue)")
    if central.state == .poweredOn {
      if scanContinuation != nil {
        print("[KatanaBLEScanner] State is poweredOn, starting scan")
        startScanning()
      }
    } else if central.state != .unknown && central.state != .resetting {
      print("[KatanaBLEScanner] Central Manager unavailable (state: \(central.state.rawValue))")
      finishScan(success: false)
    }
  }

  func centralManager(
    _ central: CBCentralManager,
    didDiscover peripheral: CBPeripheral,
    advertisementData: [String: Any],
    rssi RSSI: NSNumber
  ) {
    let name = peripheral.name
      ?? (advertisementData[CBAdvertisementDataLocalNameKey] as? String)
      ?? "Unknown"
    
    print("[KatanaBLEScanner] Discovered peripheral: \(name) (RSSI: \(RSSI))")
    
    guard name.localizedCaseInsensitiveContains(KatanaBLEConstants.deviceNameFilter) else {
      print("[KatanaBLEScanner] Peripheral '\(name)' does not match filter '\(KatanaBLEConstants.deviceNameFilter)', ignoring")
      return
    }

    print("[KatanaBLEScanner] Found matching Katana device: \(name). Stopping scan and connecting...")
    // Retain the peripheral and connect
    discoveredPeripheral = peripheral
    central.stopScan()
    central.connect(peripheral, options: nil)
  }

  func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
    print("[KatanaBLEScanner] Successfully connected to \(peripheral.name ?? "device"). Discovering MIDI service...")
    peripheral.delegate = self
    peripheral.discoverServices([KatanaBLEConstants.midiServiceUUID])
  }

  func centralManager(
    _ central: CBCentralManager,
    didFailToConnect peripheral: CBPeripheral,
    error: Error?
  ) {
    print("[KatanaBLEScanner] Failed to connect to \(peripheral.name ?? "device"): \(error?.localizedDescription ?? "Unknown error")")
    finishScan(success: false)
  }

  func centralManager(
    _ central: CBCentralManager,
    didDisconnectPeripheral peripheral: CBPeripheral,
    error: Error?
  ) {
    print("[KatanaBLEScanner] Disconnected from \(peripheral.name ?? "device"). Error: \(error?.localizedDescription ?? "None")")
    if modeSwitchCompleted {
      // Intentional disconnect after a successful mode switch.
      // Now that CoreBluetooth has released the peripheral, tell CoreMIDI's
      // BLE-MIDI driver to discover and connect to it.
      print("[KatanaBLEScanner] Mode switch done. Activating CoreMIDI BLE-MIDI driver...")
      MIDIBluetoothDriverActivateAllConnections()
      finishScan(success: true)
    } else if scanContinuation != nil {
      // Unexpected disconnect during scan/connect.
      finishScan(success: false)
    }
  }

  // MARK: - CBPeripheralDelegate

  func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
    if let error = error {
      print("[KatanaBLEScanner] Service discovery failed: \(error.localizedDescription)")
      finishScan(success: false)
      return
    }
    
    guard let services = peripheral.services else {
      print("[KatanaBLEScanner] No services found")
      finishScan(success: false)
      return
    }
    
    print("[KatanaBLEScanner] Discovered \(services.count) services")
    for service in services where service.uuid == KatanaBLEConstants.midiServiceUUID {
      print("[KatanaBLEScanner] Found MIDI service. Discovering characteristics...")
      peripheral.discoverCharacteristics([KatanaBLEConstants.midiCharacteristicUUID], for: service)
      return
    }
    
    print("[KatanaBLEScanner] Katana MIDI service not found in discovered services")
    finishScan(success: false)
  }

  func peripheral(
    _ peripheral: CBPeripheral,
    didDiscoverCharacteristicsFor service: CBService,
    error: Error?
  ) {
    if let error = error {
      print("[KatanaBLEScanner] Characteristic discovery failed: \(error.localizedDescription)")
      finishScan(success: false)
      return
    }
    
    guard let characteristics = service.characteristics else {
      print("[KatanaBLEScanner] No characteristics found for MIDI service")
      finishScan(success: false)
      return
    }
    
    print("[KatanaBLEScanner] Discovered \(characteristics.count) characteristics for MIDI service")
    for char in characteristics where char.uuid == KatanaBLEConstants.midiCharacteristicUUID {
      print("[KatanaBLEScanner] Found MIDI I/O characteristic. Sending mode switch SysEx...")
      midiCharacteristic = char
      writeBLEModeSwitch(to: peripheral, characteristic: char)
      return
    }
    
    print("[KatanaBLEScanner] Katana MIDI I/O characteristic not found")
    finishScan(success: false)
  }

  func peripheral(
    _ peripheral: CBPeripheral,
    didWriteValueFor characteristic: CBCharacteristic,
    error: Error?
  ) {
    if let error = error {
      print("[KatanaBLEScanner] Failed to write mode switch: \(error.localizedDescription)")
      finishScan(success: false)
    } else {
      print("[KatanaBLEScanner] Mode switch SysEx written successfully. Disconnecting to hand off to CoreMIDI...")
      // Mark the mode switch as complete so the disconnect handler knows this is intentional.
      modeSwitchCompleted = true
      // Disconnect from CoreBluetooth so CoreMIDI's BLE-MIDI driver can claim the peripheral.
      // CoreMIDI cannot connect to a device that CoreBluetooth already holds.
      centralManager.cancelPeripheralConnection(peripheral)
    }
  }

  // MARK: - Private

  private func writeBLEModeSwitch(to peripheral: CBPeripheral, characteristic: CBCharacteristic) {
    /// SysEx Identity Request: F0 7E 10 06 01 F7
    /// This is a standard MIDI message, but for the Katana, receiving this over BLE
    /// triggers a firmware behavior where it "promotes" itself to a full BLE-MIDI device
    /// that CoreMIDI can then recognize as a MIDI endpoint.
    let identityRequest: [UInt8] = [0xF0, 0x7E, 0x10, 0x06, 0x01, 0xF7]
    
    /// BLE-MIDI framing: [Header, TimestampLow, Data...]
    /// According to the Apple BLE-MIDI spec:
    /// - Header: 0x80 (Top bit set, low bits are high 7 bits of timestamp)
    /// - Timestamp Low: 0x80 (Top bit set, low 7 bits of timestamp)
    /// We use 0x80 for both to indicate a "now" or zero-relative timestamp.
    var framedData: [UInt8] = [0x80, 0x80]
    framedData.append(contentsOf: identityRequest)
    
    let data = Data(framedData)
    print("[KatanaBLEScanner] Writing \(framedData.count) bytes to characteristic (Mode Switch SysEx)")
    
    if characteristic.properties.contains(.write) {
      peripheral.writeValue(data, for: characteristic, type: .withResponse)
    } else if characteristic.properties.contains(.writeWithoutResponse) {
      print("[KatanaBLEScanner] Characteristic only supports writeWithoutResponse. Disconnecting to hand off to CoreMIDI...")
      peripheral.writeValue(data, for: characteristic, type: .withoutResponse)
      // For writeWithoutResponse, the didWriteValueFor delegate won't fire,
      // so we trigger the disconnect directly here.
      modeSwitchCompleted = true
      centralManager.cancelPeripheralConnection(peripheral)
    } else {
      print("[KatanaBLEScanner] Error: Characteristic does not support writing!")
      finishScan(success: false)
    }
  }
}
