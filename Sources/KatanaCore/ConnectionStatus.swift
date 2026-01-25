/// The connection status of the Katana GO device.
public enum ConnectionStatus: Sendable {
  case connected
  case disconnected
  case connecting
  case disconnecting
}
