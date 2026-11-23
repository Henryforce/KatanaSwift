import KatanaMacrosImpl
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

@MainActor
final class KatanaMacrosTests: XCTestCase {
  static let testMacros: [String: Macro.Type] = [
    "KatanaBank": KatanaBankMacro.self
  ]

  func testKatanaBankMacro() {
    assertMacroExpansion(
      """
      @KatanaBank
      public struct TestBank: KatanaGoBank {
        @Parameter(at: 0x00)
        public var volume: UInt8 = 50

        @Parameter(at: 0x01)
        public var enabled: Bool = true
      }
      """,
      expandedSource: """
        public struct TestBank: KatanaGoBank {
          @Parameter(at: 0x00)
          public var volume: UInt8 = 50

          @Parameter(at: 0x01)
          public var enabled: Bool = true

            public init(volume: UInt8? = nil, enabled: Bool? = nil) {
              if let volume {
                  self.volume = volume
              }
              if let enabled {
                  self.enabled = enabled
              }
            }
        }

        extension TestBank: WritableBank {
          public func loadWriteData(baseAddress: UInt32) -> [WriteData] {
            var writeData = [WriteData]()
            if self.$volume.updated {
          let address = RolandAddress.adding(self.$volume.address, to: baseAddress)
          writeData.append(WriteData(address: address, data: self.$volume.value.bytes))
            }
            if self.$enabled.updated {
              let address = RolandAddress.adding(self.$enabled.address, to: baseAddress)
              writeData.append(WriteData(address: address, data: self.$enabled.value.bytes))
            }
            return writeData
          }

          public static func buildFromByteArray(_ array: [UInt8]) throws -> Self {
            var bank = Self()
            let decoded_volume = try UInt8.decodeFromByteArray(
          array, offset: Int(bank.$volume.address))
            bank.$volume.setDecodedValue(decoded_volume)
            let decoded_enabled = try Bool.decodeFromByteArray(
              array, offset: Int(bank.$enabled.address))
            bank.$enabled.setDecodedValue(decoded_enabled)
            return bank
          }
        }
        """,
      macros: Self.testMacros
    )
  }

  func testKatanaBankMacroIgnoresComputedProperties() {
    assertMacroExpansion(
      """
      @KatanaBank
      public struct ComputedBank: KatanaGoBank {
        @Parameter(at: 0x00)
        public var volume: UInt8 = 50

        public var doubledVolume: UInt8 { volume * 2 }
      }
      """,
      expandedSource: """
        public struct ComputedBank: KatanaGoBank {
          @Parameter(at: 0x00)
          public var volume: UInt8 = 50

          public var doubledVolume: UInt8 { volume * 2 }

            public init(volume: UInt8? = nil) {
              if let volume {
                  self.volume = volume
              }
            }
        }

        extension ComputedBank: WritableBank {
          public func loadWriteData(baseAddress: UInt32) -> [WriteData] {
            var writeData = [WriteData]()
            if self.$volume.updated {
          let address = RolandAddress.adding(self.$volume.address, to: baseAddress)
          writeData.append(WriteData(address: address, data: self.$volume.value.bytes))
            }
            return writeData
          }

          public static func buildFromByteArray(_ array: [UInt8]) throws -> Self {
            var bank = Self()
            let decoded_volume = try UInt8.decodeFromByteArray(
          array, offset: Int(bank.$volume.address))
            bank.$volume.setDecodedValue(decoded_volume)
            return bank
          }
        }
        """,
      macros: Self.testMacros
    )
  }
}
