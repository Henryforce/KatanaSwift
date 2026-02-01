//
//  ReverbView.swift
//  KatanaGoExample
//
//  Created by Henry Javier Serrano Echeverria on 2026/01/27.
//

import KatanaEQ
import KatanaGoData
import SwiftUI

struct ReverbView: View {
  var viewModel: ContentViewModel

  @State private var isEnabled = false
  @State private var type = ReverbType.room
  @State private var time: Double = 50
  @State private var preDelay: Double = 0
  @State private var lowCut = EQLowCut.flat
  @State private var highCut = EQHighCut.freq630Hz
  @State private var density: Double = 5
  @State private var effectLevel: Double = 50
  @State private var directMix: Double = 0
  @State private var springSensitivity: Double = 50

  private let timeRange: ClosedRange<Double> = 0...100
  private let preDelayRange: ClosedRange<Double> = 0...500
  private let densityRange: ClosedRange<Double> = 0...100
  private let effectLevelRange: ClosedRange<Double> = 0...100
  private let directMixRange: ClosedRange<Double> = 0...100
  private let springSensitivityRange: ClosedRange<Double> = 0...100

  var body: some View {
    NavigationView {
      Form {
        Section("Reverb Type") {
          Toggle(
            "Enabled",
            isOn: Binding(
              get: { isEnabled },
              set: {
                isEnabled = $0
                viewModel.updateWritableBank(EffectStatusBank(reverb: $0))
              }
            ))

          Picker(
            "Type",
            selection: Binding(
              get: { type },
              set: {
                type = $0
                viewModel.updateWritableBank(ReverbBank(type: $0))
              }
            )
          ) {
            ForEach(ReverbType.allCases, id: \.self) { type in
              Text("\(type.name)").tag(type)
            }
          }
        }

        Section("Parameters") {
          parameterSlider(title: "Time", value: $time, range: timeRange) {
            viewModel.updateWritableBank(ReverbBank(time: UInt8($0)))
          }

          parameterSlider(title: "Pre Delay", value: $preDelay, range: preDelayRange) {
            viewModel.updateWritableBank(ReverbBank(preDelay: UInt16($0)))
          }

          Picker(
            "Low Cut",
            selection: Binding(
              get: { lowCut },
              set: {
                lowCut = $0
                viewModel.updateWritableBank(ReverbBank(lowCut: $0))
              }
            )
          ) {
            ForEach(EQLowCut.allCases, id: \.self) { cut in
              Text("\(cut.name)").tag(cut)
            }
          }

          Picker(
            "High Cut",
            selection: Binding(
              get: { highCut },
              set: {
                highCut = $0
                viewModel.updateWritableBank(ReverbBank(highCut: $0))
              }
            )
          ) {
            ForEach(EQHighCut.allCases, id: \.self) { cut in
              Text("\(cut.name)").tag(cut)
            }
          }

          parameterSlider(title: "Density", value: $density, range: densityRange) {
            viewModel.updateWritableBank(ReverbBank(density: UInt8($0)))
          }

          parameterSlider(title: "Effect Level", value: $effectLevel, range: effectLevelRange) {
            viewModel.updateWritableBank(ReverbBank(effectLevel: UInt8($0)))
          }

          parameterSlider(title: "Direct Mix", value: $directMix, range: directMixRange) {
            viewModel.updateWritableBank(ReverbBank(directMix: UInt8($0)))
          }

          if type == .spring {
            parameterSlider(
              title: "Spring Sensitivity", value: $springSensitivity, range: springSensitivityRange
            ) {
              viewModel.updateWritableBank(ReverbBank(springSensitivity: UInt8($0)))
            }
          }
        }
      }
      .navigationTitle("Reverb Settings")
      .task {
        await loadReverbData()
      }
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          Button("Done") {
            dismissAction()
          }
        }
      }
    }
  }

  @Environment(\.dismiss) private var dismissAction

  private func parameterSlider(
    title: String,
    value: Binding<Double>,
    range: ClosedRange<Double>,
    onUpdate: @escaping (Double) -> Void
  ) -> some View {
    VStack(alignment: .leading) {
      HStack {
        Text(title)
        Spacer()
        if range.upperBound > 100 {
          Text("\(Int(value.wrappedValue)) ms")
            .foregroundColor(.secondary)
        } else {
          Text("\(Int(value.wrappedValue))")
            .foregroundColor(.secondary)
        }
      }
      Slider(
        value: Binding(
          get: { value.wrappedValue },
          set: {
            value.wrappedValue = $0
            onUpdate($0)
          }
        ), in: range)
    }
  }

  private func loadReverbData() async {
    let statusBank = await viewModel.readBank(type: EffectStatusBank.self)
    let reverbBank = await viewModel.readBank(type: ReverbBank.self)

    if let statusBank {
      isEnabled = statusBank.reverb
    }

    if let reverbBank {
      type = reverbBank.type
      time = Double(reverbBank.time)
      preDelay = Double(reverbBank.preDelay)
      lowCut = reverbBank.lowCut
      highCut = reverbBank.highCut
      density = Double(reverbBank.density)
      effectLevel = Double(reverbBank.effectLevel)
      directMix = Double(reverbBank.directMix)
      springSensitivity = Double(reverbBank.springSensitivity)
    }
  }
}

extension ReverbType {
  var name: String {
    switch self {
    case .plate: "Plate"
    case .room: "Room"
    case .hall: "Hall"
    case .spring: "Spring"
    case .modulate: "Modulate"
    }
  }
}

extension EQLowCut {
  var name: String {
    "\(self)".replacingOccurrences(of: "freq", with: "").replacingOccurrences(of: "Hz", with: " Hz")
      .capitalized
  }
}

extension EQHighCut {
  var name: String {
    "\(self)".replacingOccurrences(of: "freq", with: "").replacingOccurrences(of: "Hz", with: " Hz")
      .capitalized
  }
}
