/// Parameters for the Amplifier block and front panel.
public enum AmpParameter: Sendable, Hashable {
  case ampType(AmpType)
  case gain(UInt8)
  case volume(UInt8)
  case bass(UInt8)
  case middle(UInt8)
  case treble(UInt8)
  case presence(UInt8)
  case variation(Bool)
}

/// The data bank representing the amplifier parameters.
public struct AmpBank: Sendable, Hashable {
  @Parameter(at: 0x20_00_00_0C)
  public var type: AmpType = .clean

  @IntegerParameter(at: 0x20_00_00_00, range: 0...100)
  public var gain: UInt8 = 50

  @IntegerParameter(at: 0x20_00_00_01, range: 0...100)
  public var volume: UInt8 = 50

  @IntegerParameter(at: 0x20_00_00_03, range: 0...100)
  public var bass: UInt8 = 50

  @IntegerParameter(at: 0x20_00_00_03, range: 0...100)
  public var middle: UInt8 = 50

  @IntegerParameter(at: 0x20_00_00_04, range: 0...100)
  public var treble: UInt8 = 50

  @IntegerParameter(at: 0x20_00_00_0A, range: 0...100)
  public var presence: UInt8 = 50

  @Parameter(at: 0x20_00_00_0D)
  public var variation: Bool = false

  public init(
    type: AmpType, gain: UInt8, volume: UInt8, bass: UInt8, middle: UInt8, treble: UInt8,
    presence: UInt8, variation: Bool
  ) {
    self.type = type
    self.gain = gain
    self.volume = volume
    self.bass = bass
    self.middle = middle
    self.treble = treble
    self.presence = presence
    self.variation = variation
  }
}

/// Available amplifier types for the Katana GO.
public enum AmpType: UInt8, Sendable, Hashable, CaseIterable {
  case acoustic = 0x00
  case clean = 0x01
  case crunch = 0x02
  case lead = 0x03
  case brown = 0x04
}
