import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct BankAutoInitMacro: MemberMacro {
  public static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {

    // 1. Find all properties (variables) in the struct
    let members = declaration.memberBlock.members
    let variables = members.compactMap { member -> VariableDeclSyntax? in
      member.decl.as(VariableDeclSyntax.self)
    }

    // 2. Extract names and types
    // We filter for stored properties that have a type annotation
    let propertyData = variables.flatMap { v -> [(name: String, type: String)] in
      v.bindings.compactMap { binding in
        guard let name = binding.pattern.as(IdentifierPatternSyntax.self)?.identifier.text,
          let type = binding.typeAnnotation?.type.description.trimmingCharacters(in: .whitespaces)
        else {
          return nil
        }
        return (name, type)
      }
    }

    // 3. Construct the initializer parameters: (name: Type? = nil)
    let parameters = propertyData.map { "\($0.name): \($0.type)? = nil" }.joined(separator: ", ")

    // 4. Construct the body: if let name { self.name = name }
    let body = propertyData.map {
      "if let \($0.name) { self.\($0.name) = \($0.name) }"
    }.joined(separator: "\n")

    // 5. Return the generated init
    return [
      """
      public init(\(raw: parameters)) {
        \(raw: body)
      }
      """
    ]
  }
}
