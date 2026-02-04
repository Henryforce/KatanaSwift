import Foundation
import KatanaCore
import KatanaGoData

extension KatanaDevice {
  /// Write a bank of parameters to the device.
  /// - Parameter bank: The bank of parameters to send to the device.
  public func writeBank<T: KatanaGoBank>(_ bank: T) async throws {
    let baseAddress = T.katanaGoAddress
    for writeData in bank.loadWriteData(baseAddress: baseAddress) {
      let data = writeData.data
      let address = writeData.address
      try await write(at: address, data: data)
    }
  }

  /// Write a bank of parameters to the device.
  /// - Parameter bank: The bank of parameters to send to the device.
  /// - Parameter channel: The channel to send the bank to.
  public func writeFxBank<T: KatanaGoFxBank>(_ bank: T, channel: KatanaGoFxChannel) async throws {
    let baseAddress = T.katanaGoAddress | (channel == .fx ? 0x00_00_10_00 : 0x00)
    for writeData in bank.loadWriteData(baseAddress: baseAddress) {
      let data = writeData.data
      let address = writeData.address
      try await write(at: address, data: data)
    }
  }

  /// Write a bank of parameters to the device.
  /// - Parameter bank: The bank of parameters to send to the device.
  /// - Parameter channel: The channel to send the bank to.
  public func writeChannelAddressableBank<T: KatanaGoChannelAddressableBank>(
    _ bank: T, channel: T.BankChannel
  ) async throws {
    let baseAddress: UInt32 = T.katanaGoAddress + channel.rawValue
    for writeData in bank.loadWriteData(baseAddress: baseAddress) {
      let data = writeData.data
      let address = writeData.address
      try await write(at: address, data: data)
    }
  }

  /// Enable or disable the FX bank.
  /// - Parameter enabled: The bank of parameters to send to the device.
  public func enableFx(_ enabled: Bool, channel: KatanaGoFxChannel) async throws {
    let address: UInt32 = channel == .fx ? 0x20_00_30_02 : 0x20_00_30_01
    try await write(at: address, data: [enabled ? 0x01 : 0x00])
  }

  /// Select the FX type.
  /// - Parameter type: The FX type to select.
  /// - Parameter channel: The channel to send the bank to.
  public func selectFxType(_ type: ModFxType, channel: KatanaGoFxChannel) async throws {
    let address: UInt32 = channel == .fx ? 0x20_00_70_00 : 0x20_00_60_00
    try await write(at: address, data: [type.rawValue])
  }

  /// Read a bank of parameters from the device.
  /// - Parameter type: The type of bank to read.
  public func readBank<T: KatanaGoBank>(_ type: T.Type) async throws -> T {
    let baseAddress = T.katanaGoAddress
    let data = try await readData(at: baseAddress, length: UInt16(T.size))
    return T.buildFromByteArray(data)
  }

  /// Read a bank of parameters from the device.
  /// - Parameter type: The type of bank to read.
  /// - Parameter channel: The channel to read the bank from.
  public func readFxBank<T: KatanaGoFxBank>(_ type: T.Type, channel: KatanaGoFxChannel) async throws
    -> T
  {
    let baseAddress = T.katanaGoAddress | (channel == .fx ? 0x00_00_10_00 : 0x00)
    let data = try await readData(at: baseAddress, length: UInt16(T.size))
    return T.buildFromByteArray(data)
  }

  /// Provides a stream of data received from the device.
  /// - Returns: An AsyncStream of KatanaGoDataBank.
  public func subscribeToKatanaGoBanks() -> AsyncStream<KatanaGoDataBank> {
    return AsyncStream { continuation in
      let stream = subscribeToData()
      Task {
        var katanaGoRawDataBank = KatanaGoRawDataBank()
        for await data in stream {
          let banks = KatanaGoMIDIParser.parse(data, into: &katanaGoRawDataBank)
          for bank in banks {
            continuation.yield(bank)
          }
        }
      }
    }
  }
}
