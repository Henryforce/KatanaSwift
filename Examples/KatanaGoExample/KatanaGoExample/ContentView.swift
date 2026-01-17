//
//  ContentView.swift
//  KatanaGoExample
//
//  Created by Henry Javier Serrano Echeverria on 2026/01/11.
//

import SwiftUI

struct ContentView: View {
  @State var viewModel = ContentViewModel()
  @State private var volume: Double = 50
  @State private var gain: Double = 50
  @State private var showBoostSettings = false
  @State private var showAmpSettings = false

  var body: some View {
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
        // .onChange(of: volume) { oldValue, newValue in
        //   viewModel.updateVolume(Int(newValue))
        // }
      }
      .padding()

      Button {
        viewModel.updateDeviceVolume(Int(volume))
      } label: {
        Text("Update Volume")
      }

      VStack {
        Text("Gain: \(Int(gain))")
        Slider(value: $gain, in: 0...100)
        // .onChange(of: volume) { oldValue, newValue in
        //   viewModel.updateVolume(Int(newValue))
        // }
      }
      .padding()

      Button {
        viewModel.updateDeviceGain(Int(gain))
      } label: {
        Text("Update Gain")
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

    }
    .padding()
    .sheet(isPresented: $showBoostSettings) {
      BoostView(viewModel: viewModel)
    }
    .sheet(isPresented: $showAmpSettings) {
      AmpView(viewModel: viewModel)
    }
  }
}

//#Preview {
//    ContentView()
//}
