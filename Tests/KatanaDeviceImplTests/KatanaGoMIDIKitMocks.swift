import Foundation
import MIDIKit

@testable import KatanaDeviceImpl

final class MockMIDIEndpoint: MIDIEndpointProtocol, @unchecked Sendable {
  var name: String
  var displayName: String?
  var uniqueID: MIDIIdentifier

  init(name: String, displayName: String?, uniqueID: MIDIIdentifier = 12345) {
    self.name = name
    self.displayName = displayName
    self.uniqueID = uniqueID
  }
}

final class MockMIDIOutputConnection: MIDIOutputConnectionProtocol, @unchecked Sendable {
  var sentEvents: [MIDIEvent] = []

  func send(event: MIDIEvent) throws {
    sentEvents.append(event)
  }
}

final class MockMIDIManager: MIDIManagerProtocol, @unchecked Sendable {
  var started = false
  var outputEndpoints: [MIDIEndpointProtocol] = []
  var inputEndpoints: [MIDIEndpointProtocol] = []

  var managedOutputConnections: [String: MIDIOutputConnectionProtocol] = [:]
  var managedInputConnections: [String: MIDIInputConnectionProtocol] = [:]

  var addedOutputConnections: [(inputs: [MIDIEndpointProtocol], tag: String)] = []
  var addedInputConnections:
    [(outputs: [MIDIEndpointProtocol], tag: String, receiver: MIDIReceiver)] = []
  var removedSelections: [(type: MIDIManager.ManagedType, selection: MIDIManager.TagSelection)] = []

  func start() throws {
    started = true
  }

  func loadManagedOutputConnections() -> [String: MIDIOutputConnectionProtocol] {
    return managedOutputConnections
  }

  func loadManagedInputConnections() -> [String: MIDIInputConnectionProtocol] {
    return managedInputConnections
  }

  func addOutputConnection(to inputs: [MIDIEndpointProtocol], tag: String) throws {
    addedOutputConnections.append((inputs: inputs, tag: tag))
    managedOutputConnections[tag] = MockMIDIOutputConnection()
  }

  func addInputConnection(
    to outputs: [MIDIEndpointProtocol], tag: String, receiver: MIDIReceiver
  ) throws {
    addedInputConnections.append((outputs: outputs, tag: tag, receiver: receiver))
  }

  func remove(_ type: MIDIManager.ManagedType, _ selection: MIDIManager.TagSelection) {
    removedSelections.append((type: type, selection: selection))
    if case .withTag(let tag) = selection {
      if type == .inputConnection {
        managedInputConnections.removeValue(forKey: tag)
      } else if type == .outputConnection {
        managedOutputConnections.removeValue(forKey: tag)
      }
    }
  }
}
