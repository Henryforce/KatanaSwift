import Foundation
import KatanaCore
import KatanaFx
import KatanaGoData

/// A parser for Katana Go SysEx messages.
public enum KatanaGoSysExParser {

  /// Parses an address and data and returns the corresponding bank updates.
  /// - Parameters:
  ///   - address: The UInt32 address of the data.
  ///   - data: The raw bytes received from the MIDI device.
  /// - Returns: An array of KatanaGoDataBank enum cases.
  public static func parse(address: UInt32, data: [UInt8]) -> [KatanaGoDataBank] {
    var banks: [KatanaGoDataBank] = []

    // 1. Standard banks (Static Addresses)
    func check<T: KatanaGoBank>(_ type: T.Type, mapper: (T) -> KatanaGoDataBank) {
      checkAddress(T.katanaGoAddress, type, mapper)
    }

    func checkAddress<T: WritableBank>(
      _ bankAddress: UInt32, _ type: T.Type, _ mapper: (T) -> KatanaGoDataBank
    ) {
      if let slice = sliceData(
        bankAddress: bankAddress, bankSize: Int(T.size), incomingAddress: address,
        incomingData: data)
      {
        banks.append(mapper(T.buildFromByteArray(slice)))
      }
    }

    // System and Tone Settings
    check(SignalChainBank.self) { .signalChainBank($0) }
    check(AmpBank.self) { .ampBank($0) }
    check(EffectStatusBank.self) { .effectStatusBank($0) }
    check(BoostBank.self) { .boostBank($0) }
    check(BassCompLimBank.self) { .bassBank($0) }
    check(ModSelectionBank.self) { .modSelectionBank($0) }
    check(FxSelectionBank.self) { .fxSelectionBank($0) }

    // Multi-address banks
    checkAddress(0x2001_2000, DelayBank.self) { .delay1Bank($0) }
    checkAddress(0x2001_3000, DelayBank.self) { .delay2Bank($0) }

    check(ReverbBank.self) { .reverbBank($0) }
    check(SoloSwitchLevelBank.self) { .soloSwitchLevelBank($0) }
    check(SoloBank.self) { .soloBank($0) }
    check(ContourBank.self) { .contourBank($0) }
    check(SignalChainPedalFxBank.self) { .signalChainPedalFxBank($0) }
    check(PedalFxBanks.self) { .pedalFxBank($0) }

    checkAddress(0x2002_6000, EQSelectionBank.self) { .eq1SelectionBank($0) }
    checkAddress(0x2002_7000, EQSelectionBank.self) { .eq2SelectionBank($0) }

    checkAddress(0x2003_0000, ParametricEQBank.self) { .eq1ParametricBank($0) }
    checkAddress(0x2003_1000, ParametricEQBank.self) { .eq2ParametricBank($0) }

    checkAddress(0x2003_2000, GraphicEQBank.self) { .eq1GraphicBank($0) }
    checkAddress(0x2003_3000, GraphicEQBank.self) { .eq2GraphicBank($0) }

    check(NoiseGateBank.self) { .noiseGateBank($0) }

    // Tuner and Global
    check(TunerBank.self) { .tunerBank($0) }
    check(GlobalEQSwitchBank.self) { .globalEQSwitchBank($0) }
    check(GlobalEQBank.self) { .globalEQBank($0) }
    check(StageFeelBank.self) { .stageFeelBank($0) }
    check(StageFeelCustomBank.self) { .stageFeelCustomBank($0) }
    check(USBSettingsBank.self) { .usbSettingsBank($0) }

    // Preset and Mode (Roland System Range)
    if let slice = sliceData(
      bankAddress: 0x7F01_0004, bankSize: 1, incomingAddress: address, incomingData: data)
    {
      banks.append(.modeBank(ModeBank.buildFromByteArray(slice)))
    }
    if let slice = sliceData(
      bankAddress: 0x7F00_0100, bankSize: 2, incomingAddress: address, incomingData: data),
      let preset = Preset(rawValue: slice[1])
    {
      banks.append(.preset(preset))
    }

    // Preset Name (Address 0x20000000)
    if let slice = sliceData(
      bankAddress: 0x2000_0000, bankSize: 20, incomingAddress: address, incomingData: data)
    {
      banks.append(.presetName(buildPresetName(from: slice)))
    }

    // 2. MOD/FX section banks
    banks.append(contentsOf: parseFxBank(address: address, data: data))

    return banks
  }

  /// Parses a raw MIDI SysEx message.
  /// This is kept for compatibility with callers that receive raw messages.
  public static func parse(_ message: [UInt8]) -> [KatanaGoDataBank] {
    // Minimum valid message length: Header(5) + Address(4) + Checksum(1) = 10 bytes
    guard message.count >= 10 else {
      return []
    }

    // Validate the DT1 command byte (0x12, which is 18)
    guard message[4] == 18 else {
      return []
    }

    // Extract Address (4 bytes starting at index 5)
    let addressBytes = Array(message[5...8])
    let address = addressBytes.reduce(0) { ($0 << 8) | UInt32($1) }

    // Extract Data (Payload between address and checksum)
    let data = Array(message[9..<(message.count - 1)])

    return parse(address: address, data: data)
  }

  // MARK: - Private Helpers

  /// Parses all possible FX banks from a potentially large data block.
  private static func parseFxBank(address: UInt32, data: [UInt8]) -> [KatanaGoDataBank] {
    var banks: [KatanaGoDataBank] = []

    func processChannel(channelOffset: UInt32, isFx: Bool) {
      func addIfOverlap<T: KatanaGoFxBank>(_ type: T.Type, builder: (T) -> KatanaGoFxReadData) {
        let bankAddress = T.katanaGoAddress + channelOffset
        if let slice = sliceData(
          bankAddress: bankAddress, bankSize: Int(T.size), incomingAddress: address,
          incomingData: data)
        {
          let bank = T.buildFromByteArray(slice)
          banks.append(isFx ? .fxSingleEffect(builder(bank)) : .modSingleEffect(builder(bank)))
        }
      }

      // TODO: we might be able to do an early return here if we find that the address belongs to the either fx or mod bank.

      addIfOverlap(ChorusBank.self) { .chorus($0) }
      addIfOverlap(FlangerBank.self) { .flanger($0) }
      addIfOverlap(PhaserBank.self) { .phaser($0) }
      addIfOverlap(UniVibeBank.self) { .univibe($0) }
      addIfOverlap(TremoloBank.self) { .tremolo($0) }
      addIfOverlap(VibratoBank.self) { .vibrato($0) }
      addIfOverlap(RotaryBank.self) { .rotary($0) }
      addIfOverlap(RingModBank.self) { .ringMod($0) }
      addIfOverlap(SlowGearBank.self) { .slowGear($0) }
      addIfOverlap(SlicerBank.self) { .slicer($0) }
      addIfOverlap(CompBank.self) { .comp($0) }
      addIfOverlap(TWahBank.self) { .tWah($0) }
      addIfOverlap(AutoWahBank.self) { .autoWah($0) }
      addIfOverlap(ModFxGraphicEQBank.self) { .modFxGraphicEQ($0) }
      addIfOverlap(ModFxParametricEQBank.self) { .modFxParametricEQ($0) }
      addIfOverlap(GuitarSimBank.self) { .guitarSim($0) }
      addIfOverlap(ACSimBank.self) { .acSim($0) }
      addIfOverlap(AcousticProBank.self) { .acousticPro($0) }
      addIfOverlap(WaveSynthBank.self) { .waveSynth($0) }
      addIfOverlap(OctaverBank.self) { .octaver($0) }
      addIfOverlap(HeavyOctaveBank.self) { .heavyOctave($0) }
      addIfOverlap(PitchShifterBank.self) { .pitchShifter($0) }
      addIfOverlap(HarmonistBank.self) { .harmonist($0) }
      addIfOverlap(Phaser90EBank.self) { .phase90($0) }
      addIfOverlap(Flanger117EBank.self) { .flanger117E($0) }
      addIfOverlap(DC30Bank.self) { .dc30($0) }
      addIfOverlap(BassEnhancerBank.self) { .bassEnhancer($0) }
      addIfOverlap(BassSimulatorBank.self) { .bassSimulator($0) }
      addIfOverlap(BassDeFretterBank.self) { .bassDeFretter($0) }
      addIfOverlap(BassOctaveBank.self) { .bassOctave($0) }
      addIfOverlap(BassTWahBank.self) { .bassTWah($0) }
      addIfOverlap(BassSynthBank.self) { .bassSynth($0) }
    }

    processChannel(channelOffset: 0, isFx: false)
    processChannel(channelOffset: 0x1000, isFx: true)

    return banks
  }

  /// Slices a large data block if it covers the target bank's address range.
  /// This method correctly handles Roland/Boss 7-bit address carry-overs.
  private static func sliceData(
    bankAddress: UInt32,
    bankSize: Int,
    incomingAddress: UInt32,
    incomingData: [UInt8]
  ) -> [UInt8]? {
    let bankStart = rolandLinear(bankAddress)
    let bankEnd = bankStart + bankSize
    let incomingStart = rolandLinear(incomingAddress)
    let incomingEnd = incomingStart + incomingData.count

    let overlapStart = max(bankStart, incomingStart)
    let overlapEnd = min(bankEnd, incomingEnd)

    // We only return a slice if it covers the WHOLE bank.
    // This assumes contiguous blocks in a single MIDI response are complete.
    if overlapStart < overlapEnd && (overlapEnd - overlapStart) == bankSize {
      let offsetInIncoming = overlapStart - incomingStart
      return Array(incomingData[offsetInIncoming..<(offsetInIncoming + bankSize)])
    }
    return nil
  }

  /// Converts a Roland 7-bit address (where each byte is 0-127) to a linear integer.
  private static func rolandLinear(_ address: UInt32) -> Int {
    let b1 = (address >> 24) & 0x7F
    let b2 = (address >> 16) & 0x7F
    let b3 = (address >> 8) & 0x7F
    let b4 = address & 0x7F
    return Int(b1) << 21 | Int(b2) << 14 | Int(b3) << 7 | Int(b4)
  }

  private static func buildPresetName(from data: [UInt8]) -> String {
    // Preset name usually starts after some preamble or at a specific offset.
    // We filter out null bytes and trim whitespaces to be robust.
    return String(bytes: data.filter { $0 != 0 }, encoding: .ascii)?
      .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
  }
}
