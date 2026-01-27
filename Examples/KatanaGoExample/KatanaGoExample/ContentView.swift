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
  @State private var showBoostSettings = false
  @State private var showAmpSettings = false
  @State private var showModSettings = false
  @State private var showFxSettings = false
  @State private var showDelaySettings = false
  @State private var showReverbSettings = false

  var body: some View {
    ScrollView {
      VStack(spacing: 20) {
        Image(systemName: "globe")
          .imageScale(.large)
          .foregroundStyle(.tint)
        Text("Hello, world!")

        Button {
          viewModel.connect()
        } label: {
          Text("Connect")
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

        VStack {
          Text("Volume: \(Int(volume))")
          Slider(value: $volume, in: 0...100)
            .onChange(of: volume) { oldValue, newValue in
              viewModel.updateWritableBank(AmpBank(volume: UInt8(newValue)))
            }
        }
        .padding()

        VStack {
          Text("Gain: \(Int(gain))")
          Slider(value: $gain, in: 0...100)
            .onChange(of: volume) { oldValue, newValue in
              viewModel.updateWritableBank(AmpBank(gain: UInt8(newValue)))
            }
        }
        .padding()

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
          showDelaySettings = true
        } label: {
          Text("Delay Settings")
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.cyan)
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
      .sheet(isPresented: $showBoostSettings) {
        BoostView(viewModel: viewModel)
      }
      .sheet(isPresented: $showAmpSettings) {
        AmpView(viewModel: viewModel)
      }
      .sheet(isPresented: $showModSettings) {
        ModFxView(viewModel: viewModel, id: .id1)
      }
      .sheet(isPresented: $showFxSettings) {
        ModFxView(viewModel: viewModel, id: .id2)
      }
      .sheet(isPresented: $showDelaySettings) {
        DelayView(viewModel: viewModel)
      }
      .sheet(isPresented: $showReverbSettings) {
        ReverbView(viewModel: viewModel)
      }
    }
  }
}

//#Preview {
//    ContentView()
//}
