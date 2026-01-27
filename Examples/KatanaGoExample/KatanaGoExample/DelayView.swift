//
//  DelayView.swift
//  KatanaGoExample
//
//  Created by Henry Javier Serrano Echeverria on 2026/01/27.
//

import KatanaGoData
import SwiftUI

struct DelayView: View {
  var viewModel: ContentViewModel

  @State private var isEnabled = false
  @State private var type = DelayType.digital
  @State private var time: Double = 100
  @State private var feedback: Double = 50
  @State private var highCut = DelayHighCutFrequency.flat
  @State private var effectLevel: Double = 50
  @State private var directMix: Double = 0
  @State private var modulationRate: Double = 50
  @State private var modulationDepth: Double = 50
  @State private var modulationSwitchStatus = false
  @State private var tapTimePercentage: Double = 100
  @State private var filterStatus = false
  @State private var filter = DelayFilterRange.freq8kHz
  @State private var delayPhase = DelayPhase.normal
  @State private var feedbackPhase = DelayPhase.normal

  private let timeRange: ClosedRange<Double> = 1...2000
  private let feedbackRange: ClosedRange<Double> = 0...100
  private let effectLevelRange: ClosedRange<Double> = 0...100
  private let directMixRange: ClosedRange<Double> = 0...100
  private let modulationRateRange: ClosedRange<Double> = 0...100
  private let modulationDepthRange: ClosedRange<Double> = 0...100
  private let tapTimePercentageRange: ClosedRange<Double> = 0...100

  var body: some View {
    NavigationView {
      Form {
        Section("Delay Type") {
          Toggle("Enabled", isOn: $isEnabled)
            .onChange(of: isEnabled) { _, newValue in
              viewModel.updateWritableBank(EffectStatusBank(delay1: newValue))
            }

          Picker("Type", selection: $type) {
            ForEach(DelayType.allCases, id: \.self) { type in
              Text("\(type.name)").tag(type)
            }
          }
          .onChange(of: type) { _, newValue in
            viewModel.updateWritableBank(DelayBank(type: newValue))
          }
        }

        Section("Parameters") {
          parameterSlider(title: "Time", value: $time, range: timeRange) {
            viewModel.updateWritableBank(DelayBank(time: UInt16($0)))
          }

          parameterSlider(title: "Feedback", value: $feedback, range: feedbackRange) {
            viewModel.updateWritableBank(DelayBank(feedback: UInt8($0)))
          }

          Picker("High Cut", selection: $highCut) {
            ForEach(DelayHighCutFrequency.allCases, id: \.self) { cut in
              Text("\(cut.name)").tag(cut)
            }
          }
          .onChange(of: highCut) { _, newValue in
            viewModel.updateWritableBank(DelayBank(highCut: newValue))
          }

          parameterSlider(title: "Effect Level", value: $effectLevel, range: effectLevelRange) {
            viewModel.updateWritableBank(DelayBank(effectLevel: UInt8($0)))
          }

          parameterSlider(title: "Direct Mix", value: $directMix, range: directMixRange) {
            viewModel.updateWritableBank(DelayBank(directMix: UInt8($0)))
          }
        }

        Section("Modulation") {
          Toggle("Modulation Switch", isOn: $modulationSwitchStatus)
            .onChange(of: modulationSwitchStatus) { _, newValue in
              viewModel.updateWritableBank(DelayBank(modulationSwitchStatus: newValue))
            }

          parameterSlider(
            title: "Modulation Rate", value: $modulationRate, range: modulationRateRange
          ) {
            viewModel.updateWritableBank(DelayBank(modulationRate: UInt8($0)))
          }

          parameterSlider(
            title: "Modulation Depth", value: $modulationDepth, range: modulationDepthRange
          ) {
            viewModel.updateWritableBank(DelayBank(modulationDepth: UInt8($0)))
          }
        }

        Section("Advanced") {
          Toggle("Filter Status", isOn: $filterStatus)
            .onChange(of: filterStatus) { _, newValue in
              viewModel.updateWritableBank(DelayBank(filterStatus: newValue))
            }

          Picker("Filter", selection: $filter) {
            ForEach(DelayFilterRange.allCases, id: \.self) { range in
              Text("\(range.name)").tag(range)
            }
          }
          .onChange(of: filter) { _, newValue in
            viewModel.updateWritableBank(DelayBank(filter: newValue))
          }

          parameterSlider(
            title: "Tap Time %", value: $tapTimePercentage, range: tapTimePercentageRange
          ) {
            viewModel.updateWritableBank(DelayBank(tapTimePercentage: UInt8($0)))
          }

          Picker("Delay Phase", selection: $delayPhase) {
            ForEach(DelayPhase.allCases, id: \.self) { phase in
              Text("\(phase.name)").tag(phase)
            }
          }
          .onChange(of: delayPhase) { _, newValue in
            viewModel.updateWritableBank(DelayBank(delayPhase: newValue))
          }

          Picker("Feedback Phase", selection: $feedbackPhase) {
            ForEach(DelayPhase.allCases, id: \.self) { phase in
              Text("\(phase.name)").tag(phase)
            }
          }
          .onChange(of: feedbackPhase) { _, newValue in
            viewModel.updateWritableBank(DelayBank(feedbackPhase: newValue))
          }
        }
      }
      .navigationTitle("Delay Settings")
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

extension DelayType {
  var name: String {
    switch self {
    case .digital: "Digital"
    case .pan: "Pan"
    case .stereo: "Stereo"
    case .analog: "Analog"
    case .tapeEcho: "Tape Echo"
    case .reverse: "Reverse"
    case .modulate: "Modulate"
    case .sde3000: "SDE-3000"
    }
  }
}

extension DelayHighCutFrequency {
  var name: String {
    "\(self)".replacingOccurrences(of: "freq", with: "").replacingOccurrences(of: "Hz", with: " Hz")
      .capitalized
  }
}

extension DelayFilterRange {
  var name: String {
    "\(self)".replacingOccurrences(of: "freq", with: "").replacingOccurrences(of: "Hz", with: " Hz")
      .capitalized
  }
}

extension DelayPhase {
  var name: String {
    "\(self)".capitalized
  }
}
