//
//  ContentView.swift
//  KatanaGoExample
//
//  Created by Henry Javier Serrano Echeverria on 2026/01/11.
//

import KatanaGoData
import SwiftUI

struct ContentView: View {
  @State var viewModel = ContentViewModel()
  @State private var volume: Double = 50
  @State private var gain: Double = 50
  @State private var showBLEDevices = false
  @State private var showBoostSettings = false
  @State private var showAmpSettings = false
  @State private var showModSettings = false
  @State private var showFxSettings = false
  @State private var showDelay1Settings = false
  @State private var showDelay2Settings = false
  @State private var showEQ1Settings = false
  @State private var showEQ2Settings = false
  @State private var showReverbSettings = false
  @State private var showBatterySettings = false

  var body: some View {
    ScrollView {
      VStack(spacing: 20) {
        Button {
          showBLEDevices = true
        } label: {
          Text("Check BLE devices")
        }

        Button {
          viewModel.connect()
        } label: {
          Text("Connect to first Katana device")
        }

        Button {
          viewModel.changePreset1A()
        } label: {
          Text("Preset 1A")
        }

        Button {
          viewModel.changePreset3A()
        } label: {
          Text("Preset 3A")
        }

        Button {
          showBatterySettings = true
        } label: {
          Text("Battery Status")
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        Button {
          showBoostSettings = true
        } label: {
          Text("Boost Settings")
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        Button {
          showAmpSettings = true
        } label: {
          Text("Amp Settings")
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        Button {
          showModSettings = true
        } label: {
          Text("MOD Settings")
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.purple)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        Button {
          showFxSettings = true
        } label: {
          Text("FX Settings")
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        Button {
          showDelay1Settings = true
        } label: {
          Text("Delay 1 Settings")
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.cyan)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        Button {
          showDelay2Settings = true
        } label: {
          Text("Delay 2 Settings")
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.cyan)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        Button {
          showEQ1Settings = true
        } label: {
          Text("EQ 1 Settings")
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.gray)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        Button {
          showEQ2Settings = true
        } label: {
          Text("EQ 2 Settings")
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.gray)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        Button {
          showReverbSettings = true
        } label: {
          Text("Reverb Settings")
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.pink)
            .foregroundColor(.white)
            .cornerRadius(10)
        }

      }
      .padding()
      .sheet(isPresented: $showBLEDevices) {
        BluetoothMIDIView()
      }
      .sheet(isPresented: $showBoostSettings) {
        BoostView(viewModel: viewModel)
      }
      .sheet(isPresented: $showAmpSettings) {
        AmpView(viewModel: viewModel)
      }
      .sheet(isPresented: $showModSettings) {
        ModFxView(viewModel: viewModel, channel: .mod)
      }
      .sheet(isPresented: $showFxSettings) {
        ModFxView(viewModel: viewModel, channel: .fx)
      }
      .sheet(isPresented: $showDelay1Settings) {
        DelayView(viewModel: viewModel, channel: .one)
      }
      .sheet(isPresented: $showDelay2Settings) {
        DelayView(viewModel: viewModel, channel: .two)
      }
      .sheet(isPresented: $showEQ1Settings) {
        EQView(viewModel: viewModel, channel: .one)
      }
      .sheet(isPresented: $showEQ2Settings) {
        EQView(viewModel: viewModel, channel: .two)
      }
      .sheet(isPresented: $showReverbSettings) {
        ReverbView(viewModel: viewModel)
      }
      .sheet(isPresented: $showBatterySettings) {
        BatteryView(viewModel: viewModel)
      }
    }
    .task {
      await loadData()
    }
  }

  private func loadData() async {
    guard let bank = await viewModel.readBank(type: AmpBank.self) else { return }
    volume = Double(bank.volume)
    gain = Double(bank.gain)
  }
}

//#Preview {
//    ContentView()
//}
