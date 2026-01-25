import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct KatanaBankMacro: MemberMacro, ExtensionMacro {
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

  public static func expansion(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [ExtensionDeclSyntax] {
    // 1. Extract all variable names from the declaration
    let memberList = declaration.memberBlock.members
    let variableNames = memberList.compactMap { member -> String? in
      guard let varDecl = member.decl.as(VariableDeclSyntax.self),
        let identifier = varDecl.bindings.first?.pattern.as(IdentifierPatternSyntax.self)
      else {
        return nil
      }
      return identifier.identifier.text
    }

    // 2. Build the function body strings
    let lines = variableNames.map { name in
      """
      if self.$\(name).updated {
          writeData.append(WriteData(address: self.$\(name).address, data: self.$\(name).value.bytes))
      }
      """
    }.joined(separator: "\n")

    // 3. Construct the final method
    let writableBankExtension: DeclSyntax = """
      extension \(type.trimmed): WritableBank {
        public func loadWriteData() -> [WriteData] {
            var writeData = [WriteData]()
            \(raw: lines)
            return writeData
        }
      }
      """

    guard let extensionDecl = writableBankExtension.as(ExtensionDeclSyntax.self) else {
      throw WritableBankExtensionError.invalidSyntax
    }

    return [extensionDecl]
  }
}
