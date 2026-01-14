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

    }
    .padding()
  }
}

//#Preview {
//    ContentView()
//}
