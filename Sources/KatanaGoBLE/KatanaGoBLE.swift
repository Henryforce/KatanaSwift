import BLECombineKit
@preconcurrency import Combine
@preconcurrency import CoreBluetooth
import Foundation
import KatanaGoAPI
import KatanaGoData

public actor KatanaGoBLE: KatanaGo {
  private let peripheral: BLEPeripheral

  private let serviceUUID = CBUUID(string: "03B80E5A-EDE8-4B33-A751-6CE34EC4C700")
  private let characteristicUUID = CBUUID(string: "7772E5DB-3868-4112-A1A9-F2669D106BF3")

  private var connectedCharacteristic: BLECharacteristic?
  private var status: ConnectionStatus = .disconnected

  public init(peripheral: BLEPeripheral) {
    self.peripheral = peripheral
  }

  public func connectionStatus() async -> ConnectionStatus {
    return status
  }

  public func connect() async throws {
    guard status == .disconnected else { return }
    status = .connecting

    do {
      let connectedPeripheral = try await peripheral.connectAsync(with: [:])
      let services = try await connectedPeripheral.discoverServicesAsync(serviceUUIDs: [serviceUUID]
      )

      guard let service = services.first(where: { $0.value.uuid == serviceUUID }) else {
        throw KatanaGoError.connectionFailed("Service not found")
      }

      let characteristics = try await connectedPeripheral.discoverCharacteristicsAsync(
        characteristicUUIDs: [characteristicUUID],
        for: service.value
      )

      guard
        let characteristic = characteristics.first(where: { $0.value.uuid == characteristicUUID })
      else {
        throw KatanaGoError.connectionFailed("Characteristic not found")
      }

      self.connectedCharacteristic = characteristic
      self.status = .connected
      print("KatanaGoBLE: Connected to \(characteristic.value.uuid)")

      // Send the startup data to enable edit mode.
      for bytes in KatanaGoStartupData.data {
        let data = Data(bytes)
        try await writeRawData(data, to: characteristic)
      }
    } catch {
      self.status = .disconnected
      print("KatanaGoBLE: Connection failed with error \(error.localizedDescription)")
      throw error
    }
  }

  public func disconnect() async {
    guard status == .connected || status == .connecting else { return }
    status = .disconnecting

    peripheral.disconnect()
    connectedCharacteristic = nil
    status = .disconnected
  }

  public func write(_ command: KatanaGoWriteData) async throws {
    guard let characteristic = connectedCharacteristic else {
      throw KatanaGoError.notConnected
    }

    let data = try encode(command)

    // Using peripheral.writeValue because BLECharacteristic doesn't have writeValueAsync extension yet
    try await peripheral.writeValueAsync(
      data,
      for: characteristic.value,
      type: .withoutResponse
    )
  }

  public func read() -> AsyncStream<KatanaGoReadData> {
    AsyncStream { continuation in
      Task {
        guard let characteristic = self.connectedCharacteristic else {
          continuation.finish()
          return
        }

        do {
          let stream = characteristic.observeValueStream()
          for try await bleData in stream {
            if let decoded = self.decode(bleData.value) {
              continuation.yield(decoded)
            }
          }
          continuation.finish()
        } catch {
          continuation.finish()
        }
      }
    }
  }

  // MARK: - Private Helpers

  private func writeRawData(_ data: Data, to characteristic: BLECharacteristic) async throws {
    try await peripheral.writeValueAsync(
      data,
      for: characteristic.value,
      type: .withoutResponse
    )
  }

  private func encode(_ command: KatanaGoWriteData) throws -> Data {
    // TODO: Implement the rest of commands.
    switch command {
    case .changePreset(let preset):
      return preset.data
    default:
      return Data()
    }
  }

  private func decode(_ data: Data) -> KatanaGoReadData? {
    // TODO: Implement actual MIDI/SysEx decoding for Katana GO
    return nil
  }
}

extension UInt8 {
  static let rolandID = 0x41
  static let rolandDeviceID = 0x10
  static let commandID = 0x12
}

extension Array where Element == UInt8 {
  static let katanaModelID = [0x01, 0x05, 0x0D]
}

enum MainData {
  func checksum(_ bytes: [UInt8]) -> UInt8 {
    var checksum: UInt = 0
    for byte in bytes {
      checksum += UInt(byte)
    }
    checksum = checksum % 128
    return UInt8((128 - checksum) % 128)
  }
}
