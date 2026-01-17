/// Parameters for the Amplifier block and front panel.
public enum AmpParameter: Sendable {
  case ampType(AmpType)
  case gain(UInt8)
  case volume(UInt8)
  case bass(UInt8)
  case middle(UInt8)
  case treble(UInt8)
  case presence(UInt8)
  case variation(Bool)
}

/// Available amplifier types for the Katana GO.
public enum AmpType: UInt8, Sendable, CaseIterable {
  case acoustic = 0x00
  case clean = 0x01
  case crunch = 0x02
  case lead = 0x03
  case brown = 0x04
}
