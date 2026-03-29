import Foundation
import KatanaCore
import MIDIKit

/// MIDI implementation of the KatanaGoScanner protocol.
public actor KatanaScannerImpl: KatanaScanner {
  private let midiManager: MIDIManagerProtocol
  private let retryInterval: UInt64
  // TODO: Add support for other Katana devices.
  private let katanaGoFactory:
    @Sendable (any MIDIEndpointProtocol, MIDIManagerProtocol) -> KatanaDevice?

  /// Flag to prevent starting the MIDI manager more than once.
  private var isMIDIManagerStarted: Bool = false

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
      return KatanaDeviceImpl(deviceType: .go, endpoint: realEndpoint, midiManager: manager)
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

  public func scan() async -> AsyncStream<KatanaDevice> {
    AsyncStream { continuation in
      let taskReference = Task {
        do {
          try await startMIDIManagerIfNeeded()

          let endpoints = midiManager.outputEndpoints

          for endpoint in endpoints {
            guard
              (endpoint.displayName ?? "").localizedCaseInsensitiveContains("KATANA")
                || endpoint.name.localizedCaseInsensitiveContains("KATANA")
            else {
              continue
            }
            if let device = katanaGoFactory(endpoint, midiManager) {
              continuation.yield(device)
            }
          }

          // For now, we finish the stream after the initial scan.

          // In the future, we could observe MIDI changes.
          continuation.finish()
        } catch {
          continuation.finish()
        }
      }

      continuation.onTermination = { _ in
        taskReference.cancel()
      }
    }
  }

  /// Starts the MIDI manager if it is not already started.
  private func startMIDIManagerIfNeeded() async throws {
    guard !isMIDIManagerStarted else { return }
    let startTask = Task { @MainActor in
      // Starting the MIDI manager must be done on the main thread to make sure that the MIDI
      // notifications are correctly received.
      try midiManager.start()
    }
    try await startTask.value
    isMIDIManagerStarted = true
  }
}
