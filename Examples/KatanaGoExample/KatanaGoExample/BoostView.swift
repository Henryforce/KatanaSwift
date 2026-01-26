//
//  BoostView.swift
//  KatanaGoExample
//
//  Created by Henry Javier Serrano Echeverria on 2026/01/16.
//

import KatanaGoData
import SwiftUI

struct BoostView: View {
  var viewModel: ContentViewModel

  @State private var isEnabled = false
  @State private var type = BoostType.midBoost
  @State private var drive: Double = 50
  @State private var bottom: Double = 50
  @State private var tone: Double = 50
  @State private var soloSwitchEnable = false
  @State private var soloLevel: Double = 50
  @State private var effectLevel: Double = 50
  @State private var directMix: Double = 50

  // Define ranges separately as requested
  private let driveRange: ClosedRange<Double> = 0...120
  private let bottomRange: ClosedRange<Double> = 0...100  // Actually it is -50 to 50
  private let toneRange: ClosedRange<Double> = 0...100  // Actually it is -50 to 50
  private let soloLevelRange: ClosedRange<Double> = 0...100
  private let effectLevelRange: ClosedRange<Double> = 0...100
  private let directMixRange: ClosedRange<Double> = 0...100

  var body: some View {
    NavigationView {
      Form {
        Section("General") {
          Toggle("Enabled", isOn: $isEnabled)
            .onChange(of: isEnabled) { _, newValue in
              viewModel.updateWritableBank(EffectStatusBank(booster: newValue))
            }

          Picker("Type", selection: $type) {
            ForEach(BoostType.allCases, id: \.self) { type in
              Text("\(type.title)").tag(type)
            }
          }
          .onChange(of: type) { _, newValue in
            viewModel.updateWritableBank(BoostBank(type: newValue))
          }
        }

        Section("Parameters") {
          parameterSlider(title: "Drive", value: $drive, range: driveRange) {
            viewModel.updateWritableBank(BoostBank(drive: UInt8($0)))
          }

          parameterSlider(title: "Bottom", value: $bottom, range: bottomRange) {
            viewModel.updateWritableBank(BoostBank(bottom: UInt8($0)))
          }

          parameterSlider(title: "Tone", value: $tone, range: toneRange) {
            viewModel.updateWritableBank(BoostBank(tone: UInt8($0)))
          }

          parameterSlider(title: "Effect Level", value: $effectLevel, range: effectLevelRange) {
            viewModel.updateWritableBank(BoostBank(effectLevel: UInt8($0)))
          }

          parameterSlider(title: "Direct Mix", value: $directMix, range: directMixRange) {
            viewModel.updateWritableBank(BoostBank(directMix: UInt8($0)))
          }
        }

        Section("Solo") {
          Toggle("Solo Switch", isOn: $soloSwitchEnable)
            .onChange(of: soloSwitchEnable) { _, newValue in
              viewModel.updateWritableBank(BoostBank(soloSwitchStatus: newValue))
            }

          parameterSlider(title: "Solo Level", value: $soloLevel, range: soloLevelRange) {
            viewModel.updateWritableBank(BoostBank(soloLevel: UInt8($0)))
          }
        }
      }
      .navigationTitle("Boost Settings")
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          Button("Done") {
            // Dismissal handled by the parent sheet binding
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
      Text("\(title): \(Int(value.wrappedValue))")
      Slider(value: value, in: range)
        .onChange(of: value.wrappedValue) { _, newValue in
          onUpdate(newValue)
        }
    }
  }
}

//#Preview {
//  BoostView(viewModel: ContentViewModel())
//}

extension BoostType {
  var title: String {
    switch self {
    case .midBoost: "Mid Boost"
    case .cleanBoost: "Clean Boost"
    case .trebleBoost: "Treble Boost"
    case .crunch: "Crunch"
    case .naturalOD: "Natural OD"
    case .warmOD: "Warm OD"
    case .fatDS: "Fat DS"
    case .metalDS: "Metal DS"
    case .octFuzz: "Oct Fuzz"
    case .bluesOD: "Blues OD"
    case .tubescreamer: "Tube Screamer"
    case .turboOD: "Turbo OD"
    case .dist: "Dist"
    case .rat: "RAT"
    case .guVDS: "GU VDS"
    case .dstPlus: "DST Plus"
    case .metalZone: "Metal Zone"
    case .sixtiesFuzz: "Sixties Fuzz"
    case .muffFuzz: "Muff Fuzz"
    case .overdrive: "Overdrive"
    case .hm2: "HM-2"
    case .metalCore: "Metal Core"
    case .centaOD: "Centa OD"
    }
  }
}
