import KatanaEQ
import KatanaFx
import KatanaGoData

extension DataBank {
  func buildReverbBank() -> ReverbBank {
    return ReverbBank(
      type: ReverbType(rawValue: reverbBank[0x00]) ?? .room,
      time: reverbBank[0x02],
      preDelay: UInt16.decodeFromByteArray([
        reverbBank[0x03], reverbBank[0x04], reverbBank[0x05], reverbBank[0x06],
      ]),
      lowCut: EQLowCut(rawValue: reverbBank[0x07]) ?? .flat,
      highCut: EQHighCut(rawValue: reverbBank[0x08]) ?? .freq630Hz,
      density: reverbBank[0x09],
      effectLevel: reverbBank[0x0A],
      directMix: reverbBank[0x0B],
      springSensitivity: reverbBank[0x0C]
    )
  }
}
