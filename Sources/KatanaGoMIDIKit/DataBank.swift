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

  }
}
