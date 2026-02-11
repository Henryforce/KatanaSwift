//
//  ContentViewModel.swift
//  KatanaGoExample
//
//  Created by Henry Javier Serrano Echeverria on 2026/01/14.
//

import KatanaGo
import KatanaGoData
import KatanaSwift
import Observation
import SwiftUI

@Observable
@MainActor
final class ContentViewModel {

  var scanner: KatanaScanner?
  var device: KatanaDevice?

  func connect() {
    Task {
      let scanner = await KatanaSwift.buildScanner()
      self.scanner = scanner

      print("Waiting for powered state")

      print("🔍 Scanning for Katana GO devices (make sure yours is on and in pairing mode)...")

      var count = 0

      for await device in await scanner.scan() {
        guard count == 0 else { break }
        count += 1
        print("✅ Found Katana GO!")
        self.device = device

        do {
          try await device.connect()

          let stream = await device.subscribeToKatanaGoBanks()
          for await bank in stream {
            print("Bank \(bank)")
          }
          print("🔗 Connected!")
        } catch {
          print("❌ Error: \(error)")
        }
      }
    }
  }

  func changePreset1A() {
    //    guard let device else { return }
    //    Task {
    //      do {
    //        print("🎸 Switching to Preset 1A...")
    //        //        try await device.write(.selectPreset(.preset1A))
    //      } catch {
    //        print("❌ Error: \(error)")
    //      }
    //    }
  }

  func changePreset3A() {
    //    guard let device else { return }
    //    Task {
    //      do {
    //        print("🎸 Switching to Preset 3A...")
    //        //        try await device.write(.selectPreset(.preset3A))
    //      } catch {
    //        print("❌ Error: \(error)")
    //      }
    //    }
  }

  func updateAmpBank(_ bank: AmpBank) {
    guard let device else { return }
    Task {
      do {
        print("🎸 Updating AmpBank \(bank)...")
        try await device.writeBank(bank)
      } catch {
        print("❌ Error: \(error)")
      }
    }
  }

  func enableFx(_ enabled: Bool, channel: KatanaGoFxChannel) {
    guard let device else { return }
    Task {
      do {
        print("🎸 Updating Fx enablement \(channel)...")
        try await device.enableFx(enabled, channel: channel)
      } catch {
        print("❌ Error: \(error)")
      }
    }
  }

  func selectFxType(_ type: ModFxType, channel: KatanaGoFxChannel) {
    guard let device else { return }
    Task {
      do {
        print("🎸 Select ModFx \(type), \(channel)...")
        try await device.selectFxType(type, channel: channel)
      } catch {
        print("❌ Error: \(error)")
      }
    }
  }

  func updateWritableBank<T: KatanaGoBank>(_ bank: T) {
    guard let device else { return }
    Task {
      do {
        print("🎸 Updating bank \(bank)...")
        try await device.writeBank(bank)
      } catch {
        print("❌ Error: \(error)")
      }
    }
  }

  func updateWritableBank<T: KatanaGoFxBank>(_ bank: T, channel: KatanaGoFxChannel) {
    guard let device else { return }
    Task {
      do {
        print("🎸 Updating bank \(bank)...")
        try await device.writeFxBank(bank, channel: channel)
      } catch {
        print("❌ Error: \(error)")
      }
    }
  }

  //  func updateMod(_ parameter: ModFxParameter) {
  //    guard let device else { return }
  //    Task {
  //      do {
  //        print("🎸 Updating MOD \(parameter)...")
  //        try await device.write(.mod(parameter))
  //      } catch {
  //        print("❌ Error: \(error)")
  //      }
  //    }
  //  }

  //  func updateFx(_ parameter: ModFxParameter) {
  //    guard let device else { return }
  //    Task {
  //      do {
  //        print("🎸 Updating FX \(parameter)...")
  //        try await device.write(.fx(parameter))
  //      } catch {
  //        print("❌ Error: \(error)")
  //      }
  //    }
  //  }

  func readBank<T: KatanaGoBank>(type: T.Type) async -> T? {
    guard let device else { return nil }
    do {
      return try await device.readBank(type)
    } catch {
      print("❌ Error: \(error)")
      return nil
    }
  }

  func readFxBank<T: KatanaGoFxBank>(type: T.Type, channel: KatanaGoFxChannel) async -> T? {
    guard let device else { return nil }
    do {
      return try await device.readFxBank(type, channel: channel)
    } catch {
      print("❌ Error: \(error)")
      return nil
    }
  }

  func updateChannelAddressableBank<T: KatanaGoChannelAddressableBank>(
    _ bank: T, channel: T.BankChannel
  ) {
    guard let device else { return }
    Task {
      do {
        print("🎸 Updating bank \(bank)...")
        try await device.writeChannelAddressableBank(bank, channel: channel)
      } catch {
        print("❌ Error: \(error)")
      }
    }
  }

  func readChannelAddressableBank<T: KatanaGoChannelAddressableBank>(
    type: T.Type, channel: T.BankChannel
  ) async -> T? {
    guard let device else { return nil }
    do {
      return try await device.readChannelAddressableBank(type, channel: channel)
    } catch {
      print("❌ Error: \(error)")
      return nil
    }
  }

}
