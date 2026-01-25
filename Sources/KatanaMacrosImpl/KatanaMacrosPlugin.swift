import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct KatanaMacrosPlugin: CompilerPlugin {
  let providingMacros: [Macro.Type] = [
    KatanaBankMacro.self,
    KatanaFxBankMacro.self,
    KatanaUInt8RawBytesMacro.self,
  ]
}
