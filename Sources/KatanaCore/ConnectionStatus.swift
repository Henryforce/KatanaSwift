/// The connection status of the Katana GO device.
public enum ConnectionStatus: Sendable {
  /// The device is connected.
  case connected
  /// The device is not connected.
  case disconnected
  /// The device is currently connecting.
  case connecting
  /// The device is currently disconnecting.
  case disconnecting
}
