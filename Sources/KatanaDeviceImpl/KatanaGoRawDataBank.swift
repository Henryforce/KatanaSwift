import KatanaGoData

/// The bank of data received from the Katana GO device.
struct KatanaGoRawDataBank: Sendable, Hashable {

  var modeBank = [UInt8](repeating: 0x00, count: 1)
  var presetBank = [UInt8](repeating: 0x00, count: 2)
  var presetNameBank = [UInt8](repeating: 0x00, count: 20)
  var signalChainBank = [UInt8](repeating: 0x00, count: 4)
  var ampBank = [UInt8](repeating: 0x00, count: 14)
  /// The bank of data for the effects on/off switch.
  /// The order is: BOOSTER, MOD, FX, DELAY1, DELAY2, REVERB, BASS
  var effectsOnOffBank = [UInt8](repeating: 0x00, count: 7)
  var boosterBank = [UInt8](repeating: 0x00, count: 8)
  var bassCompBank = [UInt8](repeating: 0x00, count: 12)
  var modTypeBank = [UInt8](repeating: 0x00, count: 1)
  var fxTypeBank = [UInt8](repeating: 0x00, count: 1)
  var modBank = [UInt8](repeating: 0x00, count: 245)
  var fxBank = [UInt8](repeating: 0x00, count: 245)
  var delay1Bank = [UInt8](repeating: 0x00, count: 17)
  var delay2Bank = [UInt8](repeating: 0x00, count: 17)
  var reverbBank = [UInt8](repeating: 0x00, count: 13)
  var soloSwitchLevelBank = [UInt8](repeating: 0x00, count: 2)
  var soloBank = [UInt8](repeating: 0x00, count: 10)
  var contourBank = [UInt8](repeating: 0x00, count: 2)
  var countour1Bank = [UInt8](repeating: 0x00, count: 2)
  var countour2Bank = [UInt8](repeating: 0x00, count: 2)
  var countour3Bank = [UInt8](repeating: 0x00, count: 2)
  var signalChainPedalFXBank = [UInt8](repeating: 0x00, count: 4)
  var pfxWahBank = [UInt8](repeating: 0x00, count: 15)
  var eq1SelectionBank = [UInt8](repeating: 0x00, count: 3)
  var eq2SelectionBank = [UInt8](repeating: 0x00, count: 3)
  var peq1Bank = [UInt8](repeating: 0x00, count: 11)
  var peq2Bank = [UInt8](repeating: 0x00, count: 11)
  var geq1Bank = [UInt8](repeating: 0x00, count: 11)
  var geq2Bank = [UInt8](repeating: 0x00, count: 11)
  var nsBank = [UInt8](repeating: 0x00, count: 3)
  var tunerBank = [UInt8](repeating: 0x00, count: 1)
  var globalEQSwitchBank = [UInt8](repeating: 0x00, count: 1)
  var globalEQBank = [UInt8](repeating: 0x00, count: 11)
  var stageFeelBank = [UInt8](repeating: 0x00, count: 1)
  var stageFeelCustomBank = [UInt8](repeating: 0x00, count: 4)
  var usbSettingsBank = [UInt8](repeating: 0x00, count: 3)

  init() {
  }

  /// Updates the data bank with the given data.
  /// - Parameters:
  ///   - data: The data to update the bank with.
  ///   - address: The address to start the update at.
  mutating func update(using data: [UInt8], startingAt address: [UInt8]) -> [KatanaGoDataBank] {
    var banks: [KatanaGoDataBank] = []

    let incomingStart = Self.staticAddressToInt(address)

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
    // if incomingStart == DataBank.staticAddressToInt([127, 0, 1, 0]) {
    //   DataBank.applyUpdate(
    //     &presetBank, bankBase: [127, 0, 1, 0], incomingData: data, incomingStart: incomingStart)
    //   return .start
    // } else if incomingStart == DataBank.staticAddressToInt([0, 0, 0, 0]) {
    //   return .end
    // }

    if Self.applyUpdate(
      &modeBank, bankBase: [0x7F, 0x01, 0x00, 0x04], incomingData: data,
      incomingStart: incomingStart)
    {
      let mode = ModeBank.buildFromByteArray(modeBank)
      banks.append(.modeBank(mode))
    }

    if Self.applyUpdate(
      &presetBank, bankBase: [0x7F, 0x00, 0x01, 0x00], incomingData: data,
      incomingStart: incomingStart),
      let preset = Preset(rawValue: presetBank[0x01])
    {
      banks.append(.preset(preset))
    }

    // Bank base address: 20000000
    if Self.applyUpdate(
      &presetNameBank, bankBase: [32, 0, 0, 0], incomingData: data, incomingStart: incomingStart)
    {
      banks.append(.presetName(buildPresetName()))
    }
    // Bank base address: 20001000
    if Self.applyUpdate(
      &signalChainBank, bankBase: [32, 0, 16, 0], incomingData: data, incomingStart: incomingStart)
    {
      let signalChain = SignalChainBank.buildFromByteArray(signalChainBank)
      banks.append(.signalChainBank(signalChain))
    }
    // Bank base address: 20002000
    if Self.applyUpdate(
      &ampBank, bankBase: [32, 0, 32, 0], incomingData: data, incomingStart: incomingStart)
    {
      let amp = AmpBank.buildFromByteArray(ampBank)
      banks.append(.ampBank(amp))
    }
    // Bank base address: 20003000
    if Self.applyUpdate(
      &effectsOnOffBank, bankBase: [32, 0, 48, 0], incomingData: data, incomingStart: incomingStart)
    {
      let effectStatus = EffectStatusBank.buildFromByteArray(effectsOnOffBank)
      banks.append(.effectStatusBank(effectStatus))
    }
    // Bank base address: 20004000
    if Self.applyUpdate(
      &boosterBank, bankBase: [32, 0, 64, 0], incomingData: data, incomingStart: incomingStart)
    {
      let boost = BoostBank.buildFromByteArray(boosterBank)
      banks.append(.boostBank(boost))
    }
    // Bank base address: 20005000
    if Self.applyUpdate(
      &bassCompBank, bankBase: [32, 0, 80, 0], incomingData: data, incomingStart: incomingStart)
    {
      let bassComp = BassCompLimBank.buildFromByteArray(bassCompBank)
      banks.append(.bassBank(bassComp))
    }
    // Bank base address: 20006000
    if Self.applyUpdate(
      &modTypeBank, bankBase: [32, 0, 96, 0], incomingData: data, incomingStart: incomingStart)
    {
      let modType = ModSelectionBank.buildFromByteArray(modTypeBank)
      banks.append(.modSelectionBank(modType))
    }
    // Bank base address: 20007000
    if Self.applyUpdate(
      &fxTypeBank, bankBase: [32, 0, 112, 0], incomingData: data, incomingStart: incomingStart)
    {
      let fxType = FxSelectionBank.buildFromByteArray(fxTypeBank)
      banks.append(.fxSelectionBank(fxType))
    }
    // // Bank base address: 20010000
    // if DataBank.applyUpdate(
    //   &modBank, bankBase: [32, 1, 0, 0], incomingData: data, incomingStart: incomingStart)
    // {
    //   banks.append(.modAllEffects(buildModBank()))
    // }
    // // Bank base address: 20011000
    // if DataBank.applyUpdate(
    //   &fxBank, bankBase: [32, 1, 16, 0], incomingData: data, incomingStart: incomingStart)
    // {
    //   banks.append(.fxAllEffects(buildFxBank()))
    // }
    // Bank base address: 20012000
    if Self.applyUpdate(
      &delay1Bank, bankBase: [32, 1, 32, 0], incomingData: data, incomingStart: incomingStart)
    {
      let delay1 = DelayBank.buildFromByteArray(delay1Bank)
      banks.append(.delay1Bank(delay1))
    }
    // Bank base address: 20013000
    if Self.applyUpdate(
      &delay2Bank, bankBase: [32, 1, 48, 0], incomingData: data, incomingStart: incomingStart)
    {
      let delay2 = DelayBank.buildFromByteArray(delay2Bank)
      banks.append(.delay2Bank(delay2))
    }
    // Bank base address: 20014000
    if Self.applyUpdate(
      &reverbBank, bankBase: [32, 1, 64, 0], incomingData: data, incomingStart: incomingStart)
    {
      let reverb = ReverbBank.buildFromByteArray(reverbBank)
      banks.append(.reverbBank(reverb))
    }
    // Bank base address: 20015000
    if Self.applyUpdate(
      &soloSwitchLevelBank, bankBase: [32, 1, 80, 0], incomingData: data,
      incomingStart: incomingStart)
    {
      let soloSwitchLevel = SoloSwitchLevelBank.buildFromByteArray(soloSwitchLevelBank)
      banks.append(.soloSwitchLevelBank(soloSwitchLevel))
    }
    // Bank base address: 20016000
    if Self.applyUpdate(
      &soloBank, bankBase: [32, 1, 96, 0], incomingData: data, incomingStart: incomingStart)
    {
      let solo = SoloBank.buildFromByteArray(soloBank)
      banks.append(.soloBank(solo))
    }
    // Bank base address: 20020000
    if Self.applyUpdate(
      &contourBank, bankBase: [32, 2, 0, 0], incomingData: data, incomingStart: incomingStart)
    {
      let contour = ContourBank.buildFromByteArray(contourBank)
      banks.append(.contourBank(contour))
    }
    // // Bank base address: 20021000
    // if DataBank.applyUpdate(&countour1Bank, bankBase: [32, 2, 16, 0], incomingData: data, incomingStart: incomingStart) {
    //   options.insert(.contour1)
    // }
    // // Bank base address: 20022000
    // if DataBank.applyUpdate(&countour2Bank, bankBase: [32, 2, 32, 0], incomingData: data, incomingStart: incomingStart) {
    //   options.insert(.contour2)
    // }
    // // Bank base address: 20023000
    // if DataBank.applyUpdate(&countour3Bank, bankBase: [32, 2, 48, 0], incomingData: data, incomingStart: incomingStart) {
    //   options.insert(.contour3)
    // }
    // Bank base address: 20024000
    if Self.applyUpdate(
      &signalChainPedalFXBank, bankBase: [32, 2, 64, 0], incomingData: data,
      incomingStart: incomingStart)
    {
      let signalChainPedalFX = SignalChainPedalFxBank.buildFromByteArray(signalChainPedalFXBank)
      banks.append(.signalChainPedalFxBank(signalChainPedalFX))
    }
    // Bank base address: 20025000
    if Self.applyUpdate(
      &pfxWahBank, bankBase: [32, 2, 80, 0], incomingData: data, incomingStart: incomingStart)
    {
      let pedalFx = PedalFxBanks.buildFromByteArray(pfxWahBank)
      banks.append(.pedalFxBank(pedalFx))
    }
    // Bank base address: 20026000
    if Self.applyUpdate(
      &eq1SelectionBank, bankBase: [32, 2, 96, 0], incomingData: data, incomingStart: incomingStart)
    {
      let eq1Selection = EQSelectionBank.buildFromByteArray(eq1SelectionBank)
      banks.append(.eq1SelectionBank(eq1Selection))
    }
    // Bank base address: 20027000
    if Self.applyUpdate(
      &eq2SelectionBank, bankBase: [32, 2, 112, 0], incomingData: data, incomingStart: incomingStart
    ) {
      let eq2Selection = EQSelectionBank.buildFromByteArray(eq2SelectionBank)
      banks.append(.eq2SelectionBank(eq2Selection))
    }
    // Bank base address: 20030000
    if Self.applyUpdate(
      &peq1Bank, bankBase: [32, 3, 0, 0], incomingData: data, incomingStart: incomingStart)
    {
      let eq1Parametric = ParametricEQBank.buildFromByteArray(peq1Bank)
      banks.append(.eq1ParametricBank(eq1Parametric))
    }
    // Bank base address: 20031000
    if Self.applyUpdate(
      &peq2Bank, bankBase: [32, 3, 16, 0], incomingData: data, incomingStart: incomingStart)
    {
      let eq2Parametric = ParametricEQBank.buildFromByteArray(peq2Bank)
      banks.append(.eq2ParametricBank(eq2Parametric))
    }
    // Bank base address: 20032000
    if Self.applyUpdate(
      &geq1Bank, bankBase: [32, 3, 32, 0], incomingData: data, incomingStart: incomingStart)
    {
      let eq1Graphic = GraphicEQBank.buildFromByteArray(geq1Bank)
      banks.append(.eq1GraphicBank(eq1Graphic))
    }
    // Bank base address: 20033000
    if Self.applyUpdate(
      &geq2Bank, bankBase: [32, 3, 48, 0], incomingData: data, incomingStart: incomingStart)
    {
      let eq2Graphic = GraphicEQBank.buildFromByteArray(geq2Bank)
      banks.append(.eq2GraphicBank(eq2Graphic))
    }
    // Bank base address: 20034000
    if Self.applyUpdate(
      &nsBank, bankBase: [32, 3, 64, 0], incomingData: data, incomingStart: incomingStart)
    {
      let noiseGate = NoiseGateBank.buildFromByteArray(nsBank)
      banks.append(.noiseGateBank(noiseGate))
    }

    // Bank base address: 10000000
    if Self.applyUpdate(
      &tunerBank, bankBase: [0x10, 0x00, 0x00, 0x00], incomingData: data,
      incomingStart: incomingStart)
    {
      let tuner = TunerBank.buildFromByteArray(tunerBank)
      banks.append(.tunerBank(tuner))
    }

    // Bank base address: 10001000
    if Self.applyUpdate(
      &globalEQSwitchBank, bankBase: [0x10, 0x00, 0x10, 0x00], incomingData: data,
      incomingStart: incomingStart)
    {
      let switchBank = GlobalEQSwitchBank.buildFromByteArray(globalEQSwitchBank)
      banks.append(.globalEQSwitchBank(switchBank))
    }

    // Bank base address: 10002000
    if Self.applyUpdate(
      &globalEQBank, bankBase: [0x10, 0x00, 0x20, 0x00], incomingData: data,
      incomingStart: incomingStart)
    {
      let globalEQ = GlobalEQBank.buildFromByteArray(globalEQBank)
      banks.append(.globalEQBank(globalEQ))
    }

    // Bank base address: 10003000
    if Self.applyUpdate(
      &stageFeelBank, bankBase: [0x10, 0x00, 0x30, 0x00], incomingData: data,
      incomingStart: incomingStart)
    {
      let stageFeel = StageFeelBank.buildFromByteArray(stageFeelBank)
      banks.append(.stageFeelBank(stageFeel))
    }

    // Bank base address: 10006000
    if Self.applyUpdate(
      &stageFeelCustomBank, bankBase: [0x10, 0x00, 0x60, 0x00], incomingData: data,
      incomingStart: incomingStart)
    {
      let custom = StageFeelCustomBank.buildFromByteArray(stageFeelCustomBank)
      banks.append(.stageFeelCustomBank(custom))
    }

    // Bank base address: 10007000
    if Self.applyUpdate(
      &usbSettingsBank, bankBase: [0x10, 0x00, 0x70, 0x00], incomingData: data,
      incomingStart: incomingStart)
    {
      let usb = USBSettingsBank.buildFromByteArray(usbSettingsBank)
      banks.append(.usbSettingsBank(usb))
    }

    return banks
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
  ) -> Bool {
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
      return true
    }
    return false
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
