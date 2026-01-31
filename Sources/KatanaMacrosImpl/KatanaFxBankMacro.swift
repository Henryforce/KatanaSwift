import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct KatanaFxBankMacro: MemberMacro, ExtensionMacro {
  public static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {

    // 1. Find all properties (variables) in the struct
    let members = declaration.memberBlock.members
    let variables = members.compactMap { member -> VariableDeclSyntax? in
      guard let varDecl = member.decl.as(VariableDeclSyntax.self) else { return nil }
      // Filter out static or class properties
      let isStatic = varDecl.modifiers.contains { modifier in
        modifier.name.tokenKind == .keyword(.static) || modifier.name.tokenKind == .keyword(.class)
      }
      return isStatic ? nil : varDecl
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
    // 1. Extract all variable names and types from the declaration
    let memberList = declaration.memberBlock.members
    let variables = memberList.compactMap { member -> VariableDeclSyntax? in
      guard let varDecl = member.decl.as(VariableDeclSyntax.self) else { return nil }
      // Filter out static or class properties
      let isStatic = varDecl.modifiers.contains { modifier in
        modifier.name.tokenKind == .keyword(.static) || modifier.name.tokenKind == .keyword(.class)
      }
      return isStatic ? nil : varDecl
    }

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

    // 2. Build the loadWriteData function body strings
    let writeLines = propertyData.map { data in
      """
      if self.$\(data.name).updated {
          var address = baseAddress + self.$\(data.name).address
          if (address & 0x80) != 0 { address += 0x80 }
          if (address & 0x8000) != 0 { address += 0x8000 }
          if (address & 0x800000) != 0 { address += 0x800000 }

          writeData.append(WriteData(address: address, data: self.$\(data.name).value.bytes))
      }
      """
    }.joined(separator: "\n")

    // 3. Build the buildFromByteArray function arguments
    let buildArguments = propertyData.map { data in
      "\(data.name): \(data.type).decodeFromByteArray(array, offset: Int(template.$\(data.name).address))"
    }.joined(separator: ",\n        ")

    // 4. Construct the final method
    let fxBankExtension: DeclSyntax = """
      extension \(type.trimmed) {
        public func loadWriteData(baseAddress: UInt32) -> [WriteData] {
            var writeData = [WriteData]()
            \(raw: writeLines)
            return writeData
        }

        public static func buildFromByteArray(_ array: [UInt8]) -> Self {
            let template = Self()
            return Self(
                \(raw: buildArguments)
            )
        }
      }
      """

    guard let extensionDecl = fxBankExtension.as(ExtensionDeclSyntax.self) else {
      throw WritableBankExtensionError.invalidSyntax
    }

    return [extensionDecl]
  }
}

enum WritableBankExtensionError: Error {
  case invalidSyntax
}
