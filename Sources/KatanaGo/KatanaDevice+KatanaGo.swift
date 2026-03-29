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

  /// Write a bank of parameters to the device's MOD or FX channel.
  /// - Parameters:
  ///   - bank: The bank of parameters to send.
  ///   - channel: The target section (MOD or FX).
  public func writeFxBank<T: KatanaGoFxBank>(_ bank: T, channel: KatanaGoFxChannel) async throws {
    let baseAddress = T.katanaGoAddress | (channel == .fx ? 0x00_00_10_00 : 0x00)
    for writeData in bank.loadWriteData(baseAddress: baseAddress) {
      let data = writeData.data
      let address = writeData.address
      try await write(at: address, data: data)
    }
  }

  /// Write a bank that can be directed to a specific device-defined channel.
  /// - Parameters:
  ///   - bank: The bank of parameters to send.
  ///   - channel: The target channel.
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

  /// Enable or disable an effect section (MOD or FX).
  /// - Parameters:
  ///   - enabled: Whether to turn the section on.
  ///   - channel: The target section (MOD or FX).
  public func enableFx(_ enabled: Bool, channel: KatanaGoFxChannel) async throws {
    let address: UInt32 = channel == .fx ? 0x20_00_30_02 : 0x20_00_30_01
    try await write(at: address, data: [enabled ? 0x01 : 0x00])
  }

  /// Select the active effect type for a MOD or FX section.
  /// - Parameters:
  ///   - type: The effect model to use.
  ///   - channel: The target section (MOD or FX).
  public func selectFxType(_ type: ModFxType, channel: KatanaGoFxChannel) async throws {
    let address: UInt32 = channel == .fx ? 0x20_00_70_00 : 0x20_00_60_00
    try await write(at: address, data: [type.rawValue])
  }

  /// Read a bank of parameters from the device.
  /// - Parameters:
  ///   - type: The bank model to read into.
  ///   - options: Cache vs. Device read priority.
  /// - Returns: A hydrated bank instance.
  public func readBank<T: KatanaGoBank>(_ type: T.Type, options: ReadDataOptions = .deviceOnly)
    async throws -> T
  {
    let baseAddress = T.katanaGoAddress
    let data = try await readData(at: baseAddress, length: UInt16(T.size), options: options)
    return T.buildFromByteArray(data)
  }

  /// Read a MOD or FX section bank from the device.
  /// - Parameters:
  ///   - type: The bank model to read into.
  ///   - channel: The target section (MOD or FX).
  ///   - options: Cache vs. Device read priority.
  /// - Returns: A hydrated bank instance.
  public func readFxBank<T: KatanaGoFxBank>(
    _ type: T.Type, channel: KatanaGoFxChannel, options: ReadDataOptions = .deviceOnly
  ) async throws -> T {
    let baseAddress = T.katanaGoAddress | (channel == .fx ? 0x00_00_10_00 : 0x00)
    let data = try await readData(at: baseAddress, length: UInt16(T.size), options: options)
    return T.buildFromByteArray(data)
  }

  /// Read a bank from a specific device-defined channel.
  /// - Parameters:
  ///   - type: The bank model to read into.
  ///   - channel: The target channel.
  ///   - options: Cache vs. Device read priority.
  /// - Returns: A hydrated bank instance.
  public func readChannelAddressableBank<T: KatanaGoChannelAddressableBank>(
    _ type: T.Type, channel: T.BankChannel, options: ReadDataOptions = .deviceOnly
  ) async throws -> T {
    let baseAddress: UInt32 = T.katanaGoAddress + channel.rawValue
    let data = try await readData(at: baseAddress, length: UInt16(T.size), options: options)
    return T.buildFromByteArray(data)
  }

  /// Provides a stream of data received from the device.
  /// - Returns: An AsyncStream of KatanaGoDataBank.
  public func subscribeToKatanaGoBanks() -> AsyncStream<KatanaGoDataBank> {
    return AsyncStream { continuation in
      let stream = subscribeToData()
      Task {
        for await streamData in stream {
          var dataToParse = streamData.data
          var addressToParse = streamData.address

          let isModRange =
            streamData.address >= 0x20_01_00_00 && streamData.address <= 0x20_01_01_74
          let isFxRange = streamData.address >= 0x20_01_10_00 && streamData.address <= 0x20_01_11_74

          if (isModRange || isFxRange) && streamData.data.count != 245 {
            let baseAddress: UInt32 = isModRange ? 0x20_01_00_00 : 0x20_01_10_00
            if let readData = try? await self.readData(
              at: baseAddress, length: 245, options: .cacheOnly), readData.count == 245
            {
              dataToParse = readData
              addressToParse = baseAddress
            } else {
              continue
            }
          }

          let banks = KatanaGoSysExParser.parse(address: addressToParse, data: dataToParse)
          for bank in banks {
            continuation.yield(bank)
          }
        }
      }
    }
  }
}
