import KatanaCore
import KatanaFx
import KatanaGoAPI
import KatanaGoData

extension AcousticProBank: KatanaGoFxBank {
  public static let address: UInt32 = 0x20_01_00_6A

  public func loadWriteData() -> [WriteData] {
    return loadWriteData(baseAddress: Self.address)
  }
}

extension ACSimBank: KatanaGoFxBank {
  public static let address: UInt32 = 0x20_01_00_66

  public func loadWriteData() -> [WriteData] {
    return loadWriteData(baseAddress: Self.address)
  }
}

extension AutoWahBank: KatanaGoFxBank {
  public static let address: UInt32 = 0x20_01_00_44

  public func loadWriteData() -> [WriteData] {
    return loadWriteData(baseAddress: Self.address)
  }
}

extension ChorusBank: KatanaGoFxBank {
  public static let address: UInt32 = 0x20_01_00_00

  public func loadWriteData() -> [WriteData] {
    return loadWriteData(baseAddress: Self.address)
  }
}

extension CompBank: KatanaGoFxBank {
  public static let address: UInt32 = 0x20_01_00_32

  public func loadWriteData() -> [WriteData] {
    return loadWriteData(baseAddress: Self.address)
  }
}

extension DC30Bank: KatanaGoFxBank {
  public static let address: UInt32 = 0x20_01_01_47

  public func loadWriteData() -> [WriteData] {
    return loadWriteData(baseAddress: Self.address)
  }
}

extension FlangerBank: KatanaGoFxBank {
  public static let address: UInt32 = 0x20_01_00_0A

  public func loadWriteData() -> [WriteData] {
    return loadWriteData(baseAddress: Self.address)
  }
}

extension Flanger117EBank: KatanaGoFxBank {
  public static let address: UInt32 = 0x20_01_01_43

  public func loadWriteData() -> [WriteData] {
    return loadWriteData(baseAddress: Self.address)
  }
}

extension GuitarSimBank: KatanaGoFxBank {
  public static let address: UInt32 = 0x20_01_00_61

  public func loadWriteData() -> [WriteData] {
    return loadWriteData(baseAddress: Self.address)
  }
}

extension HarmonistBank: KatanaGoFxBank {
  public static let address: UInt32 = 0x20_01_01_12

  public func loadWriteData() -> [WriteData] {
    return loadWriteData(baseAddress: Self.address)
  }
}

extension HeavyOctaveBank: KatanaGoFxBank {
  public static let address: UInt32 = 0x20_01_00_7C

  public func loadWriteData() -> [WriteData] {
    return loadWriteData(baseAddress: Self.address)
  }
}

extension HumanizerBank: KatanaGoFxBank {
  public static let address: UInt32 = 0x20_01_01_39

  public func loadWriteData() -> [WriteData] {
    return loadWriteData(baseAddress: Self.address)
  }
}

extension LimiterBank: KatanaGoFxBank {
  public static let address: UInt32 = 0x20_01_00_37

  public func loadWriteData() -> [WriteData] {
    return loadWriteData(baseAddress: Self.address)
  }
}

extension ModFxGraphicEQBank: KatanaGoFxBank {
  public static let address: UInt32 = 0x20_01_00_4B

  public func loadWriteData() -> [WriteData] {
    return loadWriteData(baseAddress: Self.address)
  }
}

extension ModFxParametricEQBank: KatanaGoFxBank {
  public static let address: UInt32 = 0x20_01_00_56

  public func loadWriteData() -> [WriteData] {
    return loadWriteData(baseAddress: Self.address)
  }
}

extension OctaverBank: KatanaGoFxBank {
  public static let address: UInt32 = 0x20_01_00_79

  public func loadWriteData() -> [WriteData] {
    return loadWriteData(baseAddress: Self.address)
  }
}

extension PhaserBank: KatanaGoFxBank {
  public static let address: UInt32 = 0x20_01_00_11

  public func loadWriteData() -> [WriteData] {
    return loadWriteData(baseAddress: Self.address)
  }
}

extension Phaser90EBank: KatanaGoFxBank {
  public static let address: UInt32 = 0x20_01_01_41

  public func loadWriteData() -> [WriteData] {
    return loadWriteData(baseAddress: Self.address)
  }
}

extension PitchShifterBank: KatanaGoFxBank {
  public static let address: UInt32 = 0x20_01_00_7F

  public func loadWriteData() -> [WriteData] {
    return loadWriteData(baseAddress: Self.address)
  }
}

extension RingModBank: KatanaGoFxBank {
  public static let address: UInt32 = 0x20_01_00_26

  public func loadWriteData() -> [WriteData] {
    return loadWriteData(baseAddress: Self.address)
  }
}

extension RotaryBank: KatanaGoFxBank {
  public static let address: UInt32 = 0x20_01_00_23

  public func loadWriteData() -> [WriteData] {
    return loadWriteData(baseAddress: Self.address)
  }
}

extension SlicerBank: KatanaGoFxBank {
  public static let address: UInt32 = 0x20_01_00_2D

  public func loadWriteData() -> [WriteData] {
    return loadWriteData(baseAddress: Self.address)
  }
}

extension SlowGearBank: KatanaGoFxBank {
  public static let address: UInt32 = 0x20_01_00_2A

  public func loadWriteData() -> [WriteData] {
    return loadWriteData(baseAddress: Self.address)
  }
}

extension TWahBank: KatanaGoFxBank {
  public static let address: UInt32 = 0x20_01_00_3D

  public func loadWriteData() -> [WriteData] {
    return loadWriteData(baseAddress: Self.address)
  }
}

extension TremoloBank: KatanaGoFxBank {
  public static let address: UInt32 = 0x20_01_00_1C

  public func loadWriteData() -> [WriteData] {
    return loadWriteData(baseAddress: Self.address)
  }
}

extension UniVibeBank: KatanaGoFxBank {
  public static let address: UInt32 = 0x20_01_00_19

  public func loadWriteData() -> [WriteData] {
    return loadWriteData(baseAddress: Self.address)
  }
}

extension VibratoBank: KatanaGoFxBank {
  public static let address: UInt32 = 0x20_01_00_20

  public func loadWriteData() -> [WriteData] {
    return loadWriteData(baseAddress: Self.address)
  }
}

extension WaveSynthBank: KatanaGoFxBank {
  public static let address: UInt32 = 0x20_01_00_71

  public func loadWriteData() -> [WriteData] {
    return loadWriteData(baseAddress: Self.address)
  }
}
