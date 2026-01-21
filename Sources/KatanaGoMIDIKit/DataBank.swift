/// The bank of data received from the Katana GO device.
struct DataBank: Sendable, Hashable {
  var presetBank = [UInt8](repeating: 0x00, count: 1)
  var presetNameBank = [UInt8](repeating: 0x00, count: 23)
  var signalChainBank = [UInt8](repeating: 0x00, count: 3)
  var preampBank = [UInt8](repeating: 0x00, count: 14)
  var effectsOnOffBank = [UInt8](repeating: 0x00, count: 7)
  var boosterBank = [UInt8](repeating: 0x00, count: 8)
  var bassBank = [UInt8](repeating: 0x00, count: 12)
  var modTypeBank = [UInt8](repeating: 0x00, count: 1)
  var fxTypeBank = [UInt8](repeating: 0x00, count: 1)
  var modBank = [UInt8](repeating: 0x00, count: 245)
  var fxBank = [UInt8](repeating: 0x00, count: 245)
  var delay1Bank = [UInt8](repeating: 0x00, count: 17)
  var delay2Bank = [UInt8](repeating: 0x00, count: 17)
  var reverbBank = [UInt8](repeating: 0x00, count: 13)
  var soloSwitchLevelBank = [UInt8](repeating: 0x00, count: 2)
  var soloBank = [UInt8](repeating: 0x00, count: 10)
  var contourBank = [UInt8](repeating: 0x00, count: 1)
  var countour1Bank = [UInt8](repeating: 0x00, count: 2)
  var countour2Bank = [UInt8](repeating: 0x00, count: 2)
  var countour3Bank = [UInt8](repeating: 0x00, count: 2)
  var signalChainPedalFXBank = [UInt8](repeating: 0x00, count: 7)
  var pfxWahBank = [UInt8](repeating: 0x00, count: 15)
  var eq1Bank = [UInt8](repeating: 0x00, count: 3)
  var eq2Bank = [UInt8](repeating: 0x00, count: 3)
  var peq1Bank = [UInt8](repeating: 0x00, count: 11)
  var peq2Bank = [UInt8](repeating: 0x00, count: 11)
  var geq1Bank = [UInt8](repeating: 0x00, count: 11)
  var geq2Bank = [UInt8](repeating: 0x00, count: 11)
  var nsBank = [UInt8](repeating: 0x00, count: 3)

  /// Updates the data bank with the given data.
  /// - Parameters:
  ///   - data: The data to update the bank with.
  ///   - address: The address to start the update at.
  mutating func update(using data: [UInt8], startingAt address: [UInt8]) -> DataBankParseStatus {
    let incomingStart = DataBank.staticAddressToInt(address)

    // The following parsing is simple but it basically goes through all available banks and
    // tries to update them only if there is any overlap. It makes no assumptions on whether
    // the whole data is only for a bank or if there might be data for multiple banks.
    // There might be a more efficient way to do it but this is simple and it works.
    //
    // Note for future work:
    // A future update could include counting the number of bytes copied and after all the data
    // has been copied, it could then perform an early return instead of going through all the
    // remaining banks.

    // Bank base address: 7F000100
    if incomingStart == DataBank.staticAddressToInt([127, 0, 1, 0]) {
      DataBank.applyUpdate(
        &presetBank, bankBase: [127, 0, 1, 0], incomingData: data, incomingStart: incomingStart)
      return .start
    } else if incomingStart == DataBank.staticAddressToInt([0, 0, 0, 0]) {
      return .end
    }
    
    // Bank base address: 20000000
    DataBank.applyUpdate(
      &presetNameBank, bankBase: [32, 0, 0, 0], incomingData: data, incomingStart: incomingStart)
    // Bank base address: 20001000
    DataBank.applyUpdate(
      &signalChainBank, bankBase: [32, 0, 16, 0], incomingData: data, incomingStart: incomingStart)
    // Bank base address: 20002000
    DataBank.applyUpdate(
      &preampBank, bankBase: [32, 0, 32, 0], incomingData: data, incomingStart: incomingStart)
    // Bank base address: 20003000
    DataBank.applyUpdate(
      &effectsOnOffBank, bankBase: [32, 0, 48, 0], incomingData: data, incomingStart: incomingStart)
    // Bank base address: 20004000
    DataBank.applyUpdate(
      &boosterBank, bankBase: [32, 0, 64, 0], incomingData: data, incomingStart: incomingStart)
    // Bank base address: 20005000
    DataBank.applyUpdate(
      &bassBank, bankBase: [32, 0, 80, 0], incomingData: data, incomingStart: incomingStart)
    // Bank base address: 20006000
    DataBank.applyUpdate(
      &modTypeBank, bankBase: [32, 0, 96, 0], incomingData: data, incomingStart: incomingStart)
    // Bank base address: 20007000
    DataBank.applyUpdate(
      &fxTypeBank, bankBase: [32, 0, 112, 0], incomingData: data, incomingStart: incomingStart)
    // Bank base address: 20010000
    DataBank.applyUpdate(
      &modBank, bankBase: [32, 1, 0, 0], incomingData: data, incomingStart: incomingStart)
    // Bank base address: 20011000
    DataBank.applyUpdate(
      &fxBank, bankBase: [32, 1, 16, 0], incomingData: data, incomingStart: incomingStart)
    // Bank base address: 20012000
    DataBank.applyUpdate(
      &delay1Bank, bankBase: [32, 1, 32, 0], incomingData: data, incomingStart: incomingStart)
    // Bank base address: 20013000
    DataBank.applyUpdate(
      &delay2Bank, bankBase: [32, 1, 48, 0], incomingData: data, incomingStart: incomingStart)
    // Bank base address: 20014000
    DataBank.applyUpdate(
      &reverbBank, bankBase: [32, 1, 64, 0], incomingData: data, incomingStart: incomingStart)
    // Bank base address: 20015000
    DataBank.applyUpdate(
      &soloSwitchLevelBank, bankBase: [32, 1, 80, 0], incomingData: data,
      incomingStart: incomingStart)
    // Bank base address: 20016000
    DataBank.applyUpdate(
      &soloBank, bankBase: [32, 1, 96, 0], incomingData: data, incomingStart: incomingStart)
    // Bank base address: 20020000
    DataBank.applyUpdate(
      &contourBank, bankBase: [32, 2, 0, 0], incomingData: data, incomingStart: incomingStart)
    // Bank base address: 20021000
    DataBank.applyUpdate(
      &countour1Bank, bankBase: [32, 2, 16, 0], incomingData: data, incomingStart: incomingStart)
    // Bank base address: 20022000
    DataBank.applyUpdate(
      &countour2Bank, bankBase: [32, 2, 32, 0], incomingData: data, incomingStart: incomingStart)
    // Bank base address: 20023000
    DataBank.applyUpdate(
      &countour3Bank, bankBase: [32, 2, 48, 0], incomingData: data, incomingStart: incomingStart)
    // Bank base address: 20024000
    DataBank.applyUpdate(
      &signalChainPedalFXBank, bankBase: [32, 2, 64, 0], incomingData: data,
      incomingStart: incomingStart)
    // Bank base address: 20025000
    DataBank.applyUpdate(
      &pfxWahBank, bankBase: [32, 2, 80, 0], incomingData: data, incomingStart: incomingStart)
    // Bank base address: 20026000
    DataBank.applyUpdate(
      &eq1Bank, bankBase: [32, 2, 96, 0], incomingData: data, incomingStart: incomingStart)
    // Bank base address: 20027000
    DataBank.applyUpdate(
      &eq2Bank, bankBase: [32, 2, 112, 0], incomingData: data, incomingStart: incomingStart)
    // Bank base address: 20030000
    DataBank.applyUpdate(
      &peq1Bank, bankBase: [32, 3, 0, 0], incomingData: data, incomingStart: incomingStart)
    // Bank base address: 20031000
    DataBank.applyUpdate(
      &peq2Bank, bankBase: [32, 3, 16, 0], incomingData: data, incomingStart: incomingStart)
    // Bank base address: 20032000
    DataBank.applyUpdate(
      &geq1Bank, bankBase: [32, 3, 32, 0], incomingData: data, incomingStart: incomingStart)
    // Bank base address: 20033000
    DataBank.applyUpdate(
      &geq2Bank, bankBase: [32, 3, 48, 0], incomingData: data, incomingStart: incomingStart)
    // Bank base address: 20034000
    DataBank.applyUpdate(
      &nsBank, bankBase: [32, 3, 64, 0], incomingData: data, incomingStart: incomingStart)

    return .processed
  }

  /// Applies an update to a data bank.
  /// - Parameters:
  ///   - bank: The bank to update.
  ///   - bankBase: The base address of the bank.
  ///   - incomingData: The data to update the bank with.
  ///   - incomingStart: The start address of the incoming data.
  private static func applyUpdate(
    _ bank: inout [UInt8],
    bankBase: [UInt8],
    incomingData: [UInt8],
    incomingStart: Int
  ) {
    let base = staticAddressToInt(bankBase)
    let end = incomingStart + incomingData.count
    let bankEnd = base + bank.count

    // Check if there is overlap between the incoming data and the target bank
    let overlapStart = max(base, incomingStart)
    let overlapEnd = min(bankEnd, end)

    if overlapStart < overlapEnd {
      let offsetInBank = overlapStart - base
      let offsetInData = overlapStart - incomingStart
      let length = overlapEnd - overlapStart

      for i in 0..<length {
        bank[offsetInBank + i] = incomingData[offsetInData + i]
      }
    }
  }

  /// Converts a static address to an integer.
  /// - Parameter address: The static address to convert.
  /// - Returns: The integer representation of the address.
  private static func staticAddressToInt(_ address: [UInt8]) -> Int {
    guard address.count == 4 else { return 0 }
    // Roland addresses are base-128 (7-bit bytes)
    return (Int(address[0]) << 21) | (Int(address[1]) << 14) | (Int(address[2]) << 7)
      | Int(address[3])
  }
}
