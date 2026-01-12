//
//  ContentView.swift
//  KatanaGoExample
//
//  Created by Henry Javier Serrano Echeverria on 2026/01/11.
//

import KatanaGoSwift
import Observation
import SwiftUI

@Observable
@MainActor
final class ContentViewModel {

  var scanner: KatanaGoScannerMIDIKit?
  var device: KatanaGo?

  func connect() async {
    try? await Task.sleep(for: .seconds(2))

    let scanner = KatanaGoScannerMIDIKit()
    self.scanner = scanner

    print("Waiting for powered state")

    print("🔍 Scanning for Katana GO devices (make sure yours is on and in pairing mode)...")

    var count = 0

    for await device in scanner.scan() {
      guard count == 0 else { break }
      count += 1
      print("✅ Found Katana GO!")
      self.device = device

      do {
        try await device.connect()
        print("🔗 Connected!")

        // Example: Switch to Preset 1A
        print("🎸 Switching to Preset 1A...")
        try await device.write(.changePreset(.preset1A))

        try await Task.sleep(for: .seconds(5))

        await device.disconnect()

        print("🔗 Disconnected!")
      } catch {
        print("❌ Error: \(error)")
      }
    }
  }

}

struct ContentView: View {
  @State var viewModel = ContentViewModel()

  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text("Hello, world!")
    }
    .task {
      await viewModel.connect()
    }
    .padding()
  }
}

//#Preview {
//    ContentView()
//}
