import KatanaMacros

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

@BankAutoInit
public struct AmpBank: WritableBank, Sendable, Hashable {
  @Parameter(at: 0x00_00_20_0C)
  public var type: AmpType = .clean

  @IntegerParameter(at: 0x00_00_20_00, range: 0...100)
  public var gain: UInt8 = 50

  @IntegerParameter(at: 0x00_00_20_01, range: 0...100)
  public var volume: UInt8 = 50

  @IntegerParameter(at: 0x00_00_20_03, range: 0...100)
  public var bass: UInt8 = 50

  @IntegerParameter(at: 0x00_00_20_04, range: 0...100)
  public var middle: UInt8 = 50

  @IntegerParameter(at: 0x00_00_20_05, range: 0...100)
  public var treble: UInt8 = 50

  @IntegerParameter(at: 0x00_00_20_0A, range: 0...100)
  public var presence: UInt8 = 50

  @Parameter(at: 0x00_00_20_0D)
  public var variation: Bool = false

  public func loadWriteData() -> [WriteData] {
    var writeData = [WriteData]()
    if self.$type.updated {
      writeData.append(
        WriteData(address: self.$type.address, data: self.$type.value.rawValue.bytes))
    }
    if self.$gain.updated {
      writeData.append(WriteData(address: self.$gain.address, data: self.$gain.value.bytes))
    }
    if self.$volume.updated {
      writeData.append(WriteData(address: self.$volume.address, data: self.$volume.value.bytes))
    }
    if self.$bass.updated {
      writeData.append(WriteData(address: self.$bass.address, data: self.$bass.value.bytes))
    }
    if self.$middle.updated {
      writeData.append(WriteData(address: self.$middle.address, data: self.$middle.value.bytes))
    }
    if self.$treble.updated {
      writeData.append(WriteData(address: self.$treble.address, data: self.$treble.value.bytes))
    }
    if self.$presence.updated {
      writeData.append(WriteData(address: self.$presence.address, data: self.$presence.value.bytes))
    }
    if self.$variation.updated {
      writeData.append(
        WriteData(address: self.$variation.address, data: self.$variation.value.bytes))
    }
    return writeData
  }
}

/// The data bank representing the amplifier parameters.
// public struct AmpBank: WritableBank, Sendable, Hashable {
//   @Parameter(at: 0x00_00_20_0C)
//   public var type: AmpType = .clean

//   @IntegerParameter(at: 0x00_00_20_00, range: 0...100)
//   public var gain: UInt8 = 50

//   @IntegerParameter(at: 0x00_00_20_01, range: 0...100)
//   public var volume: UInt8 = 50

//   @IntegerParameter(at: 0x00_00_20_03, range: 0...100)
//   public var bass: UInt8 = 50

//   @IntegerParameter(at: 0x00_00_20_04, range: 0...100)
//   public var middle: UInt8 = 50

//   @IntegerParameter(at: 0x00_00_20_05, range: 0...100)
//   public var treble: UInt8 = 50

//   @IntegerParameter(at: 0x00_00_20_0A, range: 0...100)
//   public var presence: UInt8 = 50

//   @Parameter(at: 0x00_00_20_0D)
//   public var variation: Bool = false

//   package var writeData = [WriteData]()

//   init(
//     type: AmpType, gain: UInt8, volume: UInt8, bass: UInt8, middle: UInt8,
//     treble: UInt8, presence: UInt8, variation: Bool
//   ) {
//     self.type = type
//     self.gain = gain
//     self.volume = volume
//     self.bass = bass
//     self.middle = middle
//     self.treble = treble
//     self.presence = presence
//     self.variation = variation
//   }

//   public init(
//     type: AmpType? = nil, gain: UInt8? = nil, volume: UInt8? = nil, bass: UInt8? = nil,
//     middle: UInt8? = nil, treble: UInt8? = nil, presence: UInt8? = nil, variation: Bool? = nil
//   ) {
//     if let type {
//       self.type = type
//       self.writeData.append(WriteData(address: self.$type.address, data: type.rawValue.bytes))
//     }
//     if let gain {
//       self.gain = gain
//       self.writeData.append(WriteData(address: self.$gain.address, data: gain.bytes))
//     }
//     if let volume {
//       self.volume = volume
//       self.writeData.append(WriteData(address: self.$volume.address, data: volume.bytes))
//     }
//     if let bass {
//       self.bass = bass
//       self.writeData.append(WriteData(address: self.$bass.address, data: bass.bytes))
//     }
//     if let middle {
//       self.middle = middle
//       self.writeData.append(WriteData(address: self.$middle.address, data: middle.bytes))
//     }
//     if let treble {
//       self.treble = treble
//       self.writeData.append(WriteData(address: self.$treble.address, data: treble.bytes))
//     }
//     if let presence {
//       self.presence = presence
//       self.writeData.append(WriteData(address: self.$presence.address, data: presence.bytes))
//     }
//     if let variation {
//       self.variation = variation
//       self.writeData.append(WriteData(address: self.$variation.address, data: variation.bytes))
//     }
//   }

//   public func loadWriteData() -> [WriteData] {
//     if writeData.isEmpty {
//       return [
//         WriteData(address: self.$type.address, data: type.rawValue.bytes),
//         WriteData(address: self.$gain.address, data: gain.bytes),
//         WriteData(address: self.$volume.address, data: volume.bytes),
//         WriteData(address: self.$bass.address, data: bass.bytes),
//         WriteData(address: self.$middle.address, data: middle.bytes),
//         WriteData(address: self.$treble.address, data: treble.bytes),
//         WriteData(address: self.$presence.address, data: presence.bytes),
//         WriteData(address: self.$variation.address, data: variation.bytes),
//       ]
//     }
//     return self.writeData
//   }
// }

/// Available amplifier types for the Katana GO.
public enum AmpType: UInt8, Sendable, Hashable, CaseIterable {
  case acoustic = 0x00
  case clean = 0x01
  case crunch = 0x02
  case lead = 0x03
  case brown = 0x04
}
