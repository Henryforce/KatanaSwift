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
          Toggle("Enabled", isOn: $isEnabled)
            .onChange(of: isEnabled) { _, newValue in
              viewModel.updateWritableBank(EffectStatusBank(reverb: newValue))
            }

          Picker("Type", selection: $type) {
            ForEach(ReverbType.allCases, id: \.self) { type in
              Text("\(type.name)").tag(type)
            }
          }
          .onChange(of: type) { _, newValue in
            viewModel.updateWritableBank(ReverbBank(type: newValue))
          }
        }

        Section("Parameters") {
          parameterSlider(title: "Time", value: $time, range: timeRange) {
            viewModel.updateWritableBank(ReverbBank(time: UInt8($0)))
          }

          parameterSlider(title: "Pre Delay", value: $preDelay, range: preDelayRange) {
            viewModel.updateWritableBank(ReverbBank(preDelay: UInt16($0)))
          }

          Picker("Low Cut", selection: $lowCut) {
            ForEach(EQLowCut.allCases, id: \.self) { cut in
              Text("\(cut.name)").tag(cut)
            }
          }
          .onChange(of: lowCut) { _, newValue in
            viewModel.updateWritableBank(ReverbBank(lowCut: newValue))
          }

          Picker("High Cut", selection: $highCut) {
            ForEach(EQHighCut.allCases, id: \.self) { cut in
              Text("\(cut.name)").tag(cut)
            }
          }
          .onChange(of: highCut) { _, newValue in
            viewModel.updateWritableBank(ReverbBank(highCut: newValue))
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
      Slider(value: value, in: range)
        .onChange(of: value.wrappedValue) { _, newValue in
          onUpdate(newValue)
        }
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
