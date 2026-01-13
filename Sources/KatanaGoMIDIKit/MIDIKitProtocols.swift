import Foundation
import MIDIKit

/// A protocol abstraction for MIDI endpoints (both input and output).
/// This allows for mocking MIDI endpoints in unit tests.
public protocol MIDIEndpointProtocol: Sendable {
  /// The name of the endpoint.
  var name: String { get }

  /// The display name of the endpoint, if available.
  var displayName: String? { get }

  /// The unique identifier for the endpoint.
  var uniqueID: MIDIIdentifier { get }
}

extension MIDIOutputEndpoint: MIDIEndpointProtocol {}
extension MIDIInputEndpoint: MIDIEndpointProtocol {}

/// A protocol abstraction for MIDI output connections.
/// Defines the capabilities of a connection that can send MIDI events.
public protocol MIDIOutputConnectionProtocol {
  /// Sends a MIDI event through the connection.
  /// - Parameter event: The `MIDIEvent` to send.
  /// - Throws: An error if the event could not be sent.
  func send(event: MIDIEvent) throws
}

/// A protocol abstraction for MIDI input connections.
/// Currently used as a marker protocol for type-safe connection management.
public protocol MIDIInputConnectionProtocol {

}

extension MIDIOutputConnection: MIDIOutputConnectionProtocol {
  /// Sends a MIDI event through the managed connection.
  /// This implementation explicitly casts to `MIDIManagedSendsMessages` to access the `send` method.
  /// - Parameter event: The `MIDIEvent` to send.
  /// - Throws: An error if the event could not be sent.
  public func send(event: MIDIEvent) throws {
    // Explicitly calling the method from MIDIManagedSendsMessages
    try (self as MIDIManagedSendsMessages).send(event: event)
  }
}

extension MIDIInputConnection: MIDIInputConnectionProtocol {

}

/// A protocol abstraction for the `MIDIManager`.
/// This provides a testable interface for managing MIDI connections and endpoints.
public protocol MIDIManagerProtocol: Sendable {
  /// Starts the MIDI manager.
  /// - Throws: An error if the MIDI system could not be initialized.
  func start() throws

  /// A list of available MIDI output endpoints.
  var outputEndpoints: [MIDIEndpointProtocol] { get }

  /// A list of available MIDI input endpoints.
  var inputEndpoints: [MIDIEndpointProtocol] { get }

  /// Retrieves the current managed output connections.
  /// - Returns: A dictionary of output connections keyed by their tag.
  func loadManagedOutputConnections() -> [String: MIDIOutputConnectionProtocol]

  /// Retrieves the current managed input connections.
  /// - Returns: A dictionary of input connections keyed by their tag.
  func loadManagedInputConnections() -> [String: MIDIInputConnectionProtocol]

  /// Adds a new output connection to the specified inputs.
  /// - Parameters:
  ///   - inputs: The MIDI endpoints to connect to.
  ///   - tag: A unique identifier for the connection.
  /// - Throws: An error if the connection could not be established.
  func addOutputConnection(
    to inputs: [MIDIEndpointProtocol],
    tag: String
  ) throws

  /// Adds a new input connection to the specified outputs.
  /// - Parameters:
  ///   - outputs: The MIDI endpoints to receive from.
  ///   - tag: A unique identifier for the connection.
  ///   - receiver: The `MIDIReceiver` that will handle incoming events.
  /// - Throws: An error if the connection could not be established.
  func addInputConnection(
    to outputs: [MIDIEndpointProtocol],
    tag: String,
    receiver: MIDIReceiver
  ) throws

  /// Removes managed elements (connections) from the manager.
  /// - Parameters:
  ///   - type: The type of managed element to remove.
  ///   - tagSelection: The tags identifying which elements to remove.
  func remove(_ type: MIDIManager.ManagedType, _ tagSelection: MIDIManager.TagSelection)
}

extension MIDIManager: MIDIManagerProtocol {
  /// All available MIDI output endpoints in the system.
  public var outputEndpoints: [MIDIEndpointProtocol] {
    endpoints.outputs
  }

  /// All available MIDI input endpoints in the system.
  public var inputEndpoints: [MIDIEndpointProtocol] {
    endpoints.inputs
  }

  /// Returns all currently managed output connections, cast to `MIDIOutputConnectionProtocol`.
  public func loadManagedOutputConnections() -> [String: MIDIOutputConnectionProtocol] {
    return self.managedOutputConnections.compactMapValues { $0 as MIDIOutputConnectionProtocol }
  }

  /// Returns all currently managed input connections, cast to `MIDIInputConnectionProtocol`.
  public func loadManagedInputConnections() -> [String: MIDIInputConnectionProtocol] {
    return self.managedInputConnections.compactMapValues { $0 as MIDIInputConnectionProtocol }
  }

  /// Conformance to `MIDIManagerProtocol`.
  /// Filters the input protocol array for real `MIDIInputEndpoint` instances.
  public func addOutputConnection(
    to inputs: [MIDIEndpointProtocol],
    tag: String
  ) throws {
    let realInputs = inputs.compactMap { $0 as? MIDIInputEndpoint }
    try self.addOutputConnection(to: .inputs(realInputs), tag: tag)
  }

  /// Conformance to `MIDIManagerProtocol`.
  /// Filters the output protocol array for real `MIDIOutputEndpoint` instances.
  public func addInputConnection(
    to outputs: [MIDIEndpointProtocol],
    tag: String,
    receiver: MIDIReceiver
  ) throws {
    let realOutputs = outputs.compactMap { $0 as? MIDIOutputEndpoint }
    try self.addInputConnection(to: .outputs(realOutputs), tag: tag, receiver: receiver)
  }
}
