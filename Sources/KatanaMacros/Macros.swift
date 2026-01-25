import KatanaCore

@attached(extension, conformances: WritableBank, names: named(loadWriteData))
@attached(member, names: named(init))
public macro KatanaBank() =
  #externalMacro(
    module: "KatanaMacrosImpl",
    type: "KatanaBankMacro"
  )

@attached(member, names: named(bytes))
public macro KatanaUInt8RawBytes() =
  #externalMacro(
    module: "KatanaMacrosImpl",
    type: "KatanaUInt8RawBytesMacro"
  )
