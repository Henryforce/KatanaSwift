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
    let propertyData = extractParameterProperties(from: declaration)

    let parameters = propertyData.map { "\($0.name): \($0.type)? = nil" }.joined(separator: ", ")

    let body = propertyData.map {
      "if let \($0.name) { self.\($0.name) = \($0.name) }"
    }.joined(separator: "\n")

    let initDecl: DeclSyntax = """
      public init(\(raw: parameters)) {
        \(raw: body)
      }
      """
    return [initDecl]
  }

  public static func expansion(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [ExtensionDeclSyntax] {
    let propertyData = extractParameterProperties(from: declaration)

    let writeLines = propertyData.map { data in
      """
      if self.$\(data.name).updated {
        let address = RolandAddress.adding(self.$\(data.name).address, to: baseAddress)
        writeData.append(WriteData(address: address, data: self.$\(data.name).value.bytes))
      }
      """
    }.joined(separator: "\n")

    let decodeLines = propertyData.map { data in
      """
      let decoded_\(data.name): \(data.type)? = \(data.type).decodeFromByteArray(
        array, offset: Int(bank.$\(data.name).address))
      if let decoded_\(data.name) {
        bank.$\(data.name).setDecodedValue(decoded_\(data.name))
      }
      """
    }.joined(separator: "\n")

    let writableBankExtension: DeclSyntax = """
      extension \(type.trimmed): WritableBank {
        public func loadWriteData(baseAddress: UInt32) -> [WriteData] {
          var writeData = [WriteData]()
          \(raw: writeLines)
          return writeData
        }

        public static func buildFromByteArray(_ array: [UInt8]) -> Self {
          var bank = Self()
          \(raw: decodeLines)
          return bank
        }
      }
      """

    guard let extensionDecl = writableBankExtension.as(ExtensionDeclSyntax.self) else {
      throw WritableBankExtensionError.invalidSyntax
    }

    return [extensionDecl]
  }

  private static func extractParameterProperties(from declaration: some DeclGroupSyntax)
    -> [(name: String, type: String)]
  {
    let members = declaration.memberBlock.members
    let variables = members.compactMap { member -> VariableDeclSyntax? in
      guard let varDecl = member.decl.as(VariableDeclSyntax.self) else { return nil }
      let isStatic = varDecl.modifiers.contains { modifier in
        modifier.name.tokenKind == .keyword(.static) || modifier.name.tokenKind == .keyword(.class)
      }
      guard !isStatic else { return nil }

      let hasParameterAttribute = varDecl.attributes.contains { element in
        guard let attr = element.as(AttributeSyntax.self),
          let name = attr.attributeName.as(IdentifierTypeSyntax.self)?.name.text
        else {
          return false
        }
        return name == "Parameter" || name == "IntegerParameter"
      }
      return hasParameterAttribute ? varDecl : nil
    }

    return variables.flatMap { v -> [(name: String, type: String)] in
      v.bindings.compactMap { binding in
        guard binding.accessorBlock == nil,
          let name = binding.pattern.as(IdentifierPatternSyntax.self)?.identifier.text,
          let type = binding.typeAnnotation?.type.description.trimmingCharacters(in: .whitespaces)
        else {
          return nil
        }
        return (name, type)
      }
    }
  }
}

enum WritableBankExtensionError: Error {
  case invalidSyntax
}
