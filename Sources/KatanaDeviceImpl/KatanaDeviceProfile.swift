import KatanaCore

/// Hardware-specific MIDI profile for a Katana device model.
struct KatanaDeviceProfile: Sendable {
  let deviceType: KatanaDeviceType
  let modelIDBytes: [UInt8]
  let startupPackets: [[UInt8]]
  let connectionTagPrefix: String
  let endpointNameFilter: String

  func matches(endpoint: any MIDIEndpointProtocol) -> Bool {
    endpoint.displayName.localizedCaseInsensitiveContains(endpointNameFilter)
      || endpoint.name.localizedCaseInsensitiveContains(endpointNameFilter)
  }

  static func profile(for deviceType: KatanaDeviceType) -> KatanaDeviceProfile {
    switch deviceType {
    case .go:
      return KatanaDeviceProfile(
        deviceType: .go,
        modelIDBytes: [0x01, 0x05, 0x0D],
        startupPackets: KatanaGoStartupData.data,
        connectionTagPrefix: "KatanaGo",
        endpointNameFilter: "KATANA"
      )
    }
  }
}
