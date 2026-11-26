import Foundation
import KatanaCore
import SwiftMIDIIO

/// MIDI implementation of the KatanaScanner protocol.
public actor KatanaScannerImpl: KatanaScanner {
  private let midiManager: MIDIManagerProtocol
  private let profile: KatanaDeviceProfile
  private let deviceFactory:
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
    self.profile = KatanaDeviceProfile.profile(for: .go)
    self.deviceFactory = { endpoint, midiManager in
      guard let manager = midiManager as? MIDIManager,
        let realEndpoint = endpoint as? MIDIOutputEndpoint
      else { return nil }
      return KatanaDeviceImpl(deviceType: .go, endpoint: realEndpoint, midiManager: manager)
    }
  }

  /// Internal initializer for testing.
  init(
    midiManager: MIDIManagerProtocol,
    profile: KatanaDeviceProfile = .profile(for: .go),
    deviceFactory:
      @Sendable @escaping (any MIDIEndpointProtocol, MIDIManagerProtocol) -> KatanaDevice? = {
        _, _ in
        nil
      }
  ) {
    self.midiManager = midiManager
    self.profile = profile
    self.deviceFactory = deviceFactory
  }

  public nonisolated func scan() -> AsyncStream<any KatanaDevice> {
    AsyncStream { continuation in
      let taskReference = Task {
        await self.performScan(continuation: continuation)
      }

      continuation.onTermination = { _ in
        taskReference.cancel()
      }
    }
  }

  private func performScan(continuation: AsyncStream<any KatanaDevice>.Continuation) async {
    do {
      try await startMIDIManagerIfNeeded()

      let endpoints = midiManager.outputEndpoints

      for endpoint in endpoints {
        guard profile.matches(endpoint: endpoint) else {
          continue
        }
        if let device = deviceFactory(endpoint, midiManager) {
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
