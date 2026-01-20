/// A bank of data received from the Katana GO device.
struct DataBank: Sendable, Hashable {
  private var presetBank = [UInt8](repeating: 0x00, count: 1)
  private var presetNameBank = [UInt8](repeating: 0x00, count: 20)
  private var signalChainBank = [UInt8](repeating: 0x00, count: 3)
  private var preampBank = [UInt8](repeating: 0x00, count: 14)
  private var effectsOnOffBank = [UInt8](repeating: 0x00, count: 7)
  private var boosterBank = [UInt8](repeating: 0x00, count: 8)
  private var bassBank = [UInt8](repeating: 0x00, count: 12)
  private var modTypeBank = [UInt8](repeating: 0x00, count: 1)
  private var fxTypeBank = [UInt8](repeating: 0x00, count: 1)
  private var modBank = [UInt8](repeating: 0x00, count: 245)
  private var fxBank = [UInt8](repeating: 0x00, count: 245)
  private var delay1Bank = [UInt8](repeating: 0x00, count: 17)
  private var delay2Bank = [UInt8](repeating: 0x00, count: 17)
  private var reverbBank = [UInt8](repeating: 0x00, count: 13)
  private var soloSwitchLevelBank = [UInt8](repeating: 0x00, count: 2)
  private var soloBank = [UInt8](repeating: 0x00, count: 10)
  private var contourBank = [UInt8](repeating: 0x00, count: 1)
  private var countour1Bank = [UInt8](repeating: 0x00, count: 2)
  private var countour2Bank = [UInt8](repeating: 0x00, count: 2)
  private var countour3Bank = [UInt8](repeating: 0x00, count: 2)
  private var signalChainPedalFXBank = [UInt8](repeating: 0x00, count: 7)
  private var pfxWahBank = [UInt8](repeating: 0x00, count: 15)
  private var eq1Bank = [UInt8](repeating: 0x00, count: 3)
  private var eq2Bank = [UInt8](repeating: 0x00, count: 3)
  private var peq1Bank = [UInt8](repeating: 0x00, count: 11)
  private var peq2Bank = [UInt8](repeating: 0x00, count: 11)
  private var geq1Bank = [UInt8](repeating: 0x00, count: 11)
  private var geq2Bank = [UInt8](repeating: 0x00, count: 11)
  private var nsBank = [UInt8](repeating: 0x00, count: 3)

  mutating func update(using data: [UInt8], startingAt address: [UInt8]) {
    let incomingStart = DataBank.staticAddressToInt(address)

    DataBank.applyUpdate(
      &presetBank, bankBase: [127, 0, 1, 0], incomingData: data, incomingStart: incomingStart)
    DataBank.applyUpdate(
      &presetNameBank, bankBase: [32, 0, 0, 0], incomingData: data, incomingStart: incomingStart)
    DataBank.applyUpdate(
      &signalChainBank, bankBase: [32, 0, 16, 0], incomingData: data, incomingStart: incomingStart)
    DataBank.applyUpdate(
      &preampBank, bankBase: [32, 0, 32, 0], incomingData: data, incomingStart: incomingStart)
    DataBank.applyUpdate(
      &effectsOnOffBank, bankBase: [32, 0, 48, 0], incomingData: data, incomingStart: incomingStart)
    DataBank.applyUpdate(
      &boosterBank, bankBase: [32, 0, 64, 0], incomingData: data, incomingStart: incomingStart)
    DataBank.applyUpdate(
      &bassBank, bankBase: [32, 0, 80, 0], incomingData: data, incomingStart: incomingStart)
    DataBank.applyUpdate(
      &modTypeBank, bankBase: [32, 0, 96, 0], incomingData: data, incomingStart: incomingStart)
    DataBank.applyUpdate(
      &fxTypeBank, bankBase: [32, 0, 112, 0], incomingData: data, incomingStart: incomingStart)
    DataBank.applyUpdate(
      &modBank, bankBase: [32, 1, 0, 0], incomingData: data, incomingStart: incomingStart)
    DataBank.applyUpdate(
      &fxBank, bankBase: [32, 1, 16, 0], incomingData: data, incomingStart: incomingStart)
    DataBank.applyUpdate(
      &delay1Bank, bankBase: [32, 1, 32, 0], incomingData: data, incomingStart: incomingStart)
    DataBank.applyUpdate(
      &delay2Bank, bankBase: [32, 1, 48, 0], incomingData: data, incomingStart: incomingStart)
    DataBank.applyUpdate(
      &reverbBank, bankBase: [32, 1, 64, 0], incomingData: data, incomingStart: incomingStart)
    DataBank.applyUpdate(
      &soloSwitchLevelBank, bankBase: [32, 1, 80, 0], incomingData: data,
      incomingStart: incomingStart)
    DataBank.applyUpdate(
      &soloBank, bankBase: [32, 1, 96, 0], incomingData: data, incomingStart: incomingStart)
    DataBank.applyUpdate(
      &contourBank, bankBase: [32, 2, 0, 0], incomingData: data, incomingStart: incomingStart)
    DataBank.applyUpdate(
      &countour1Bank, bankBase: [32, 2, 16, 0], incomingData: data, incomingStart: incomingStart)
    DataBank.applyUpdate(
      &countour2Bank, bankBase: [32, 2, 32, 0], incomingData: data, incomingStart: incomingStart)
    DataBank.applyUpdate(
      &countour3Bank, bankBase: [32, 2, 48, 0], incomingData: data, incomingStart: incomingStart)
    DataBank.applyUpdate(
      &signalChainPedalFXBank, bankBase: [32, 2, 64, 0], incomingData: data,
      incomingStart: incomingStart)
    DataBank.applyUpdate(
      &pfxWahBank, bankBase: [32, 2, 80, 0], incomingData: data, incomingStart: incomingStart)
    DataBank.applyUpdate(
      &eq1Bank, bankBase: [32, 2, 96, 0], incomingData: data, incomingStart: incomingStart)
    DataBank.applyUpdate(
      &eq2Bank, bankBase: [32, 2, 112, 0], incomingData: data, incomingStart: incomingStart)
    DataBank.applyUpdate(
      &peq1Bank, bankBase: [32, 3, 0, 0], incomingData: data, incomingStart: incomingStart)
    DataBank.applyUpdate(
      &peq2Bank, bankBase: [32, 3, 16, 0], incomingData: data, incomingStart: incomingStart)
    DataBank.applyUpdate(
      &geq1Bank, bankBase: [32, 3, 32, 0], incomingData: data, incomingStart: incomingStart)
    DataBank.applyUpdate(
      &geq2Bank, bankBase: [32, 3, 48, 0], incomingData: data, incomingStart: incomingStart)
    DataBank.applyUpdate(
      &nsBank, bankBase: [32, 3, 64, 0], incomingData: data, incomingStart: incomingStart)
  }

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

  private static func staticAddressToInt(_ address: [UInt8]) -> Int {
    guard address.count == 4 else { return 0 }
    // Roland addresses are base-128 (7-bit bytes)
    return (Int(address[0]) << 21) | (Int(address[1]) << 14) | (Int(address[2]) << 7)
      | Int(address[3])
  }
}
