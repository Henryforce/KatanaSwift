import KatanaCore

@attached(
  extension, conformances: WritableBank, names: named(loadWriteData), named(buildFromByteArray))
@attached(member, names: named(init))
public macro KatanaBank() =
  #externalMacro(
    module: "KatanaMacrosImpl",
    type: "KatanaBankMacro"
  )

@attached(
  extension, names: named(loadWriteData), named(buildFromByteArray))
@attached(member, names: named(init))
public macro KatanaFxBank() =
  #externalMacro(
    module: "KatanaMacrosImpl",
    type: "KatanaFxBankMacro"
  )

@attached(member, names: named(bytes), named(decodeFromByteArray))
public macro KatanaUInt8RawBytes() =
  #externalMacro(
    module: "KatanaMacrosImpl",
    type: "KatanaUInt8RawBytesMacro"
  )
