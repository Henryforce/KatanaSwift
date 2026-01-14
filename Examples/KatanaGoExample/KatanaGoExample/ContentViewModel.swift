//
//  ContentViewModel.swift
//  KatanaGoExample
//
//  Created by Henry Javier Serrano Echeverria on 2026/01/14.
//

import KatanaGoSwift
import Observation
import SwiftUI

@Observable
@MainActor
final class ContentViewModel {

  var scanner: KatanaGoScannerMIDIKit?
  var device: KatanaGo?

  func connect() {
    Task {
      try await Task.sleep(for: .seconds(2))

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
        } catch {
          print("❌ Error: \(error)")
        }
      }
    }
  }

  func changePreset1A() {
    guard let device else { return }
    Task {
      do {
        print("🎸 Switching to Preset 1A...")
        try await device.write(.changePreset(.preset1A))
      } catch {
        print("❌ Error: \(error)")
      }
    }
  }

  func changePreset3A() {
    guard let device else { return }
    Task {
      do {
        print("🎸 Switching to Preset 3A...")
        try await device.write(.changePreset(.preset3A))
      } catch {
        print("❌ Error: \(error)")
      }
    }
  }

  func updateVolume(_ value: Int) {
    guard let device else { return }
    Task {
      do {
        print("🔊 Updating Volume to \(value)...")
        try await device.write(.amp(.volume, value: value))
      } catch {
        print("❌ Error: \(error)")
      }
    }
  }

  func updateDeviceVolume(_ value: Int) {
    guard let device else { return }
    Task {
      do {
        print("🔊 Updating Volume to \(value)...")
        try await device.write(.volume(value: value))
      } catch {
        print("❌ Error: \(error)")
      }
    }
  }

}
