import CoreMIDI
import Foundation
import KatanaCore
import SwiftMIDIIO

/// MIDI implementation of the KatanaGoScanner protocol.
public actor KatanaScannerImpl: KatanaScanner {
  private var midiManager: MIDIManagerProtocol
  private let retryInterval: UInt64
  private let bleScanner: KatanaBLEScanner
  private let bleScanEnabled: Bool
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
    self.bleScanner = KatanaBLEScanner()
    self.bleScanEnabled = true
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
    bleScanEnabled: Bool = false,
    katanaGoFactory:
      @Sendable @escaping (any MIDIEndpointProtocol, MIDIManagerProtocol) -> KatanaDevice? = {
        _, _ in
        nil
      }
  ) {
    self.midiManager = midiManager
    self.retryInterval = retryInterval
    self.bleScanEnabled = bleScanEnabled
    self.bleScanner = KatanaBLEScanner()
    self.katanaGoFactory = katanaGoFactory
  }

  /// Maximum number of polling attempts after BLE-MIDI activation to wait for the
  /// MIDI endpoint to appear. Each attempt waits `retryInterval` nanoseconds.
  private let maxRetries: Int = 10

  public func scan() async -> AsyncStream<KatanaDevice> {
    AsyncStream { continuation in
      let taskReference = Task {
        do {
          try await startMIDIManagerIfNeeded()

          let endpoints = midiManager.outputEndpoints
          var foundKatana = false

          for endpoint in endpoints {
            guard
              endpoint.displayName.localizedCaseInsensitiveContains("KATANA")
                || endpoint.name.localizedCaseInsensitiveContains("KATANA")
            else {
              continue
            }
            if let device = katanaGoFactory(endpoint, midiManager) {
              continuation.yield(device)
              foundKatana = true
            }
          }

          if !foundKatana && bleScanEnabled {
            print("DEBUG: BLE scan enabled, searching for Katana device")
            let activated = await bleScanner.scanAndActivate()
            if activated {
              print("DEBUG: BLE-MIDI mode activated, restarting MIDI session...")
              await self.restartMIDIManager()
              print("DEBUG: MIDI session restarted, polling for MIDI endpoint...")
              let device = await self.pollForKatanaEndpoint()
              if let device {
                continuation.yield(device)
              } else {
                print("DEBUG: Katana MIDI endpoint did not appear after polling")
              }
            }
          }

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

  /// Polls `midiManager.outputEndpoints` with retries, waiting for a Katana MIDI endpoint
  /// to appear after BLE-MIDI activation.
  ///
  /// After `MIDIBluetoothDriverActivateAllConnections()`, CoreMIDI may take several seconds
  /// to create the BLE-MIDI endpoint. This method polls repeatedly (up to `maxRetries`
  /// attempts, each separated by `retryInterval`) so that we don't miss the endpoint if it
  /// takes longer than a single sleep cycle.
  private func pollForKatanaEndpoint() async -> KatanaDevice? {
    for attempt in 1...maxRetries {
      try? await Task.sleep(nanoseconds: retryInterval)
      print("DEBUG: Poll attempt \(attempt)/\(maxRetries)")

      let currentEndpoints = midiManager.outputEndpoints
      print("DEBUG: Endpoints available: \(currentEndpoints.count)")

      for endpoint in currentEndpoints {
        print("DEBUG: Endpoint: \(endpoint.displayName), \(endpoint.name)")
        guard
          endpoint.displayName.localizedCaseInsensitiveContains("KATANA")
            || endpoint.name.localizedCaseInsensitiveContains("KATANA")
        else {
          continue
        }
        if let device = katanaGoFactory(endpoint, midiManager) {
          print("DEBUG: Found Katana endpoint on attempt \(attempt)")
          return device
        }
      }
    }
    return nil
  }

  /// Recreates and restarts the MIDI manager to force a refresh of the MIDI setup.
  private func restartMIDIManager() async {
    print("DEBUG: Recreating MIDI manager...")
    
    // Explicitly tell CoreMIDI to dispose of the old client and its connections
    if let oldManager = self.midiManager as? MIDIManager, oldManager.coreMIDIClientRef != 0 {
      print("DEBUG: Disposing old CoreMIDI client to stop all connections...")
      MIDIClientDispose(oldManager.coreMIDIClientRef)
    }

    let newManager = MIDIManager(
      clientName: "KatanaSwift",
      model: "KatanaScanner",
      manufacturer: "Henryforce"
    )
    self.midiManager = newManager
    self.isMIDIManagerStarted = false
    try? await startMIDIManagerIfNeeded()
  }

  /// Starts the MIDI manager if it is not already started.
  private func startMIDIManagerIfNeeded() async throws {
    guard !isMIDIManagerStarted else { return }
    let manager = self.midiManager
    let startTask = Task { @MainActor in
      // Starting the MIDI manager must be done on the main thread to make sure that the MIDI
      // notifications are correctly received.
      try manager.start()
    }
    try await startTask.value
    isMIDIManagerStarted = true
  }
}
