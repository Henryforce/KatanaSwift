import Foundation
import KatanaGoAPI
import KatanaGoData
import MIDIKit

/// MIDI implementation of the KatanaGoScanner protocol.
public final class KatanaGoScannerMIDIKit: KatanaGoScanner {
  private let midiManager: MIDIManager

  public init() {
    self.midiManager = MIDIManager(
      clientName: "KatanaGoSwift",
      model: "KatanaGoScanner",
      manufacturer: "Henryforce"
    )
  }

  public func scan() -> AsyncStream<KatanaGo> {
    AsyncStream { continuation in
      let taskReference = Task {
        do {
          try midiManager.start()

          for _ in 0...5 {
            try Task.checkCancellation()
            try await Task.sleep(nanoseconds: 1_500_000_000)
            try Task.checkCancellation()

            var katanaFound = false
            let endpoints = midiManager.endpoints.outputs

            for endpoint in endpoints {
              guard
                endpoint.displayName.localizedCaseInsensitiveContains("KATANA:GO MIDI")
                  || endpoint.name.localizedCaseInsensitiveContains("KATANA:GO MIDI")
              else {
                continue
              }

              print("Found KATANA with name: \(endpoint.displayName), \(endpoint.name)")
              continuation.yield(KatanaGoMIDIKit(endpoint: endpoint, midiManager: midiManager))
              katanaFound = true
              break
            }

            if katanaFound {
              break
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
