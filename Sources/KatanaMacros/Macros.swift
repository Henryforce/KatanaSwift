import KatanaCore

@attached(
  extension, conformances: WritableBank, names: named(loadWriteData), named(buildFromByteArray))
@attached(member, names: named(init))
public macro KatanaBank() =
  #externalMacro(
    module: "KatanaMacrosImpl",
    type: "KatanaBankMacro"
  )
