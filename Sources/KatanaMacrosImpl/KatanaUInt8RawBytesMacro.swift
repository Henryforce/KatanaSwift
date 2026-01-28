import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct KatanaUInt8RawBytesMacro: MemberMacro {
  public static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    return [
      """
      public var bytes: [UInt8] {
        return [self.rawValue]
      }
      """,
      """
      package static func decodeFromByteArray(_ array: [UInt8], offset: Int = 0) -> Self {
        return Self(rawValue: array[offset])!
      }
      """,
    ]
  }
}
