import KatanaMacrosImpl
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

@MainActor
final class KatanaMacrosTests: XCTestCase {
  static let testMacros: [String: Macro.Type] = [
    "KatanaBank": KatanaBankMacro.self,
    "KatanaUInt8RawBytes": KatanaUInt8RawBytesMacro.self,
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
          var address = baseAddress + self.$volume.address
          if (address & 0x80) != 0 {
              address += 0x80
          }
          if (address & 0x8000) != 0 {
              address += 0x8000
          }
          if (address & 0x800000) != 0 {
              address += 0x800000
          }
          writeData.append(WriteData(address: address, data: self.$volume.value.bytes))
            }
            if self.$enabled.updated {
              var address = baseAddress + self.$enabled.address
              if (address & 0x80) != 0 {
              address += 0x80
          }
              if (address & 0x8000) != 0 {
              address += 0x8000
          }
              if (address & 0x800000) != 0 {
              address += 0x800000
          }
              writeData.append(WriteData(address: address, data: self.$enabled.value.bytes))
            }
            return writeData
          }

          public static func buildFromByteArray(_ array: [UInt8]) -> Self {
            let template = Self()
            return Self(
              volume: UInt8.decodeFromByteArray(array, offset: Int(template.$volume.address)),
              enabled: Bool.decodeFromByteArray(array, offset: Int(template.$enabled.address))
            )
          }
        }
        """,
      macros: Self.testMacros
    )
  }

  func testKatanaUInt8RawBytesMacro() {
    assertMacroExpansion(
      """
      @KatanaUInt8RawBytes
      public enum TestEnum: UInt8 {
        case off = 0x00
        case on = 0x01
      }
      """,
      expandedSource: """
        public enum TestEnum: UInt8 {
          case off = 0x00
          case on = 0x01

            public var bytes: [UInt8] {
              return [self.rawValue]
            }

            package static func decodeFromByteArray(_ array: [UInt8], offset: Int = 0) -> Self {
              return Self(rawValue: array[offset])!
            }
        }
        """,
      macros: Self.testMacros
    )
  }
}
