@attached(member, names: named(init))
public macro BankAutoInit() =
  #externalMacro(
    module: "KatanaMacrosImpl",
    type: "BankAutoInitMacro"
  )
