import Foundation
import KatanaCore
import MIDIKit

/// MIDI implementation of the KatanaGoScanner protocol.
public final class KatanaGoScannerMIDIKit: KatanaScanner {
  private let midiManager: MIDIManagerProtocol
  private let retryInterval: UInt64
  // TODO: Add support for other Katana devices.
  private let katanaGoFactory:
    @Sendable (any MIDIEndpointProtocol, MIDIManagerProtocol) -> KatanaDevice?

  public init() {
    let manager = MIDIManager(
      clientName: "KatanaSwift",
      model: "KatanaScanner",
      manufacturer: "Henryforce"
    )
    self.midiManager = manager
    self.retryInterval = 1_500_000_000
    self.katanaGoFactory = { endpoint, midiManager in
      guard let manager = midiManager as? MIDIManager,
        let realEndpoint = endpoint as? MIDIOutputEndpoint
      else { return nil }
      // TODO: Add support for other Katana devices.
      return KatanaGoMIDIKit(deviceType: .go, endpoint: realEndpoint, midiManager: manager)
    }
  }

  /// Internal initializer for testing.
  init(
    midiManager: MIDIManagerProtocol,
    retryInterval: UInt64 = 1_500_000_000,
    katanaGoFactory:
      @Sendable @escaping (any MIDIEndpointProtocol, MIDIManagerProtocol) -> KatanaDevice? = {
        _, _ in
        nil
      }
  ) {
    self.midiManager = midiManager
    self.retryInterval = retryInterval
    self.katanaGoFactory = katanaGoFactory
  }

  public func scan() -> AsyncStream<KatanaDevice> {
    AsyncStream { continuation in
      let taskReference = Task {
        do {
          try midiManager.start()

          let endpoints = midiManager.outputEndpoints

          for endpoint in endpoints {
            guard
              (endpoint.displayName ?? "").localizedCaseInsensitiveContains("KATANA:GO MIDI")
                || endpoint.name.localizedCaseInsensitiveContains("KATANA:GO MIDI")
            else {
              continue
            }

            print(
              "Found KATANA with name: \(endpoint.displayName ?? endpoint.name), \(endpoint.name)"
            )
            if let device = katanaGoFactory(endpoint, midiManager) {
              continuation.yield(device)
            }
          }

          // For now, we finish the stream after the initial scan.

          // In the future, we could observe MIDI changes.
          continuation.finish()
        } catch {
          print("Failed to start MIDIManager: \(error)")
          continuation.finish()
        }
      }

      continuation.onTermination = { _ in
        taskReference.cancel()
      }
    }
  }
}
