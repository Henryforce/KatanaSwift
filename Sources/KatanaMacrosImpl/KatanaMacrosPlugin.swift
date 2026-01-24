import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct KatanaMacrosPlugin: CompilerPlugin {
  let providingMacros: [Macro.Type] = [
    BankAutoInitMacro.self
  ]
}
