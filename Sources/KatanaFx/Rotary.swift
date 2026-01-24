import KatanaCore
import KatanaMacros

// MARK: - Rotary

/// The data bank representing the rotary parameters.
public struct RotaryBank: WritableBank, Sendable, Hashable {
  @IntegerParameter(at: 0x00_01_00_23, range: 0...100)
  public var rate: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_24, range: 0...100)
  public var depth: UInt8 = 50

  @IntegerParameter(at: 0x00_01_00_25, range: 0...100)
  public var level: UInt8 = 100

  package var writeData = [WriteData]()

  init(rate: UInt8, depth: UInt8, level: UInt8) {
    self.rate = rate
    self.depth = depth
    self.level = level
  }

  public init(rate: UInt8? = nil, depth: UInt8? = nil, level: UInt8? = nil) {
    if let rate {
      self.rate = rate
      self.writeData.append(WriteData(address: self.$rate.address, data: rate.bytes))
    }
    if let depth {
      self.depth = depth
      self.writeData.append(WriteData(address: self.$depth.address, data: depth.bytes))
    }
    if let level {
      self.level = level
      self.writeData.append(WriteData(address: self.$level.address, data: level.bytes))
    }
  }

  public func loadWriteData() -> [WriteData] {
    if writeData.isEmpty {
      return [
        WriteData(address: self.$rate.address, data: rate.bytes),
        WriteData(address: self.$depth.address, data: depth.bytes),
        WriteData(address: self.$level.address, data: level.bytes),
      ]
    }
    return self.writeData
  }
}
