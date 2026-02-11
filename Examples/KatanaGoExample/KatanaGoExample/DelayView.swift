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
  let channel: DelayBankChannel

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
          Toggle(
            "Enabled",
            isOn: Binding(
              get: { isEnabled },
              set: {
                isEnabled = $0
                viewModel.updateWritableBank(
                  EffectStatusBank(
                    delay1: channel == .one ? $0 : isEnabled,
                    delay2: channel == .two ? $0 : isEnabled))
              }
            ))

          Picker(
            "Type",
            selection: Binding(
              get: { type },
              set: {
                type = $0
                viewModel.updateChannelAddressableBank(DelayBank(type: $0), channel: channel)
              }
            )
          ) {
            ForEach(DelayType.allCases, id: \.self) { type in
              Text("\(type.name)").tag(type)
            }
          }
        }

        Section("Parameters") {
          parameterSlider(title: "Time", value: $time, range: timeRange) {
            viewModel.updateChannelAddressableBank(DelayBank(time: UInt16($0)), channel: channel)
          }

          parameterSlider(title: "Feedback", value: $feedback, range: feedbackRange) {
            viewModel.updateChannelAddressableBank(DelayBank(feedback: UInt8($0)), channel: channel)
          }

          Picker(
            "High Cut",
            selection: Binding(
              get: { highCut },
              set: {
                highCut = $0
                viewModel.updateChannelAddressableBank(DelayBank(highCut: $0), channel: channel)
              }
            )
          ) {
            ForEach(DelayHighCutFrequency.allCases, id: \.self) { cut in
              Text("\(cut.name)").tag(cut)
            }
          }

          parameterSlider(title: "Effect Level", value: $effectLevel, range: effectLevelRange) {
            viewModel.updateChannelAddressableBank(
              DelayBank(effectLevel: UInt8($0)), channel: channel)
          }

          parameterSlider(title: "Direct Mix", value: $directMix, range: directMixRange) {
            viewModel.updateChannelAddressableBank(
              DelayBank(directMix: UInt8($0)), channel: channel)
          }
        }

        Section("Modulation") {
          Toggle(
            "Modulation Switch",
            isOn: Binding(
              get: { modulationSwitchStatus },
              set: {
                modulationSwitchStatus = $0
                viewModel.updateChannelAddressableBank(
                  DelayBank(modulationSwitchStatus: $0), channel: channel)
              }
            ))

          parameterSlider(
            title: "Modulation Rate", value: $modulationRate, range: modulationRateRange
          ) {
            viewModel.updateChannelAddressableBank(
              DelayBank(modulationRate: UInt8($0)), channel: channel)
          }

          parameterSlider(
            title: "Modulation Depth", value: $modulationDepth, range: modulationDepthRange
          ) {
            viewModel.updateChannelAddressableBank(
              DelayBank(modulationDepth: UInt8($0)), channel: channel)
          }
        }

        Section("Advanced") {
          Toggle(
            "Filter Status",
            isOn: Binding(
              get: { filterStatus },
              set: {
                filterStatus = $0
                viewModel.updateChannelAddressableBank(
                  DelayBank(filterStatus: $0), channel: channel)
              }
            ))

          Picker(
            "Filter",
            selection: Binding(
              get: { filter },
              set: {
                filter = $0
                viewModel.updateChannelAddressableBank(DelayBank(filter: $0), channel: channel)
              }
            )
          ) {
            ForEach(DelayFilterRange.allCases, id: \.self) { range in
              Text("\(range.name)").tag(range)
            }
          }

          parameterSlider(
            title: "Tap Time %", value: $tapTimePercentage, range: tapTimePercentageRange
          ) {
            viewModel.updateChannelAddressableBank(
              DelayBank(tapTimePercentage: UInt8($0)), channel: channel)
          }

          Picker(
            "Delay Phase",
            selection: Binding(
              get: { delayPhase },
              set: {
                delayPhase = $0
                viewModel.updateChannelAddressableBank(DelayBank(delayPhase: $0), channel: channel)
              }
            )
          ) {
            ForEach(DelayPhase.allCases, id: \.self) { phase in
              Text("\(phase.name)").tag(phase)
            }
          }

          Picker(
            "Feedback Phase",
            selection: Binding(
              get: { feedbackPhase },
              set: {
                feedbackPhase = $0
                viewModel.updateChannelAddressableBank(
                  DelayBank(feedbackPhase: $0), channel: channel)
              }
            )
          ) {
            ForEach(DelayPhase.allCases, id: \.self) { phase in
              Text("\(phase.name)").tag(phase)
            }
          }
        }
      }
      .navigationTitle("Delay Settings")
      .task {
        await loadDelayData()
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

  private func loadDelayData() async {
    let statusBank = await viewModel.readBank(type: EffectStatusBank.self)
    let delayBank = await viewModel.readChannelAddressableBank(
      type: DelayBank.self, channel: channel)

    if let statusBank {
      isEnabled = channel == .one ? statusBank.delay1 : statusBank.delay2
    }

    if let delayBank {
      type = delayBank.type
      time = Double(delayBank.time)
      feedback = Double(delayBank.feedback)
      highCut = delayBank.highCut
      effectLevel = Double(delayBank.effectLevel)
      directMix = Double(delayBank.directMix)
      modulationSwitchStatus = delayBank.modulationSwitchStatus
      modulationRate = Double(delayBank.modulationRate)
      modulationDepth = Double(delayBank.modulationDepth)
      filterStatus = delayBank.filterStatus
      filter = delayBank.filter
      tapTimePercentage = Double(delayBank.tapTimePercentage)
      delayPhase = delayBank.delayPhase
      feedbackPhase = delayBank.feedbackPhase
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
