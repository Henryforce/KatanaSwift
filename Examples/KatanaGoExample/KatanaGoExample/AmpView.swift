//
//  AmpView.swift
//  KatanaGoExample
//
//  Created by Henry Javier Serrano Echeverria on 2026/01/17.
//

import KatanaGoData
import SwiftUI

struct AmpView: View {
  var viewModel: ContentViewModel

  @State private var ampType = AmpType.clean
  @State private var gain: Double = 50
  @State private var volume: Double = 50
  @State private var bass: Double = 50
  @State private var middle: Double = 50
  @State private var treble: Double = 50
  @State private var presence: Double = 50
  @State private var variationEnable = false

  // Define ranges separately
  private let gainRange: ClosedRange<Double> = 0...100
  private let volumeRange: ClosedRange<Double> = 0...100
  private let bassRange: ClosedRange<Double> = 0...100
  private let middleRange: ClosedRange<Double> = 0...100
  private let trebleRange: ClosedRange<Double> = 0...100
  private let presenceRange: ClosedRange<Double> = 0...100

  var body: some View {
    NavigationView {
      Form {
        Section("Amp Selection") {
          Picker(
            "Amp Type",
            selection: Binding(
              get: { ampType },
              set: {
                ampType = $0
                viewModel.updateAmpBank(AmpBank(type: $0))
              }
            )
          ) {
            ForEach(AmpType.allCases, id: \.self) { type in
              Text("\(type.name)").tag(type)
            }
          }

          Toggle(
            "Variation",
            isOn: Binding(
              get: { variationEnable },
              set: {
                variationEnable = $0
                viewModel.updateAmpBank(AmpBank(variation: $0))
              }
            ))
        }

        Section("Tone Controls") {
          parameterSlider(title: "Gain", value: $gain, range: gainRange) {
            viewModel.updateAmpBank(AmpBank(gain: UInt8($0)))
          }

          parameterSlider(title: "Volume", value: $volume, range: volumeRange) {
            viewModel.updateAmpBank(AmpBank(volume: UInt8($0)))
          }

          parameterSlider(title: "Bass", value: $bass, range: bassRange) {
            viewModel.updateAmpBank(AmpBank(bass: UInt8($0)))
          }

          parameterSlider(title: "Middle", value: $middle, range: middleRange) {
            viewModel.updateAmpBank(AmpBank(middle: UInt8($0)))
          }

          parameterSlider(title: "Treble", value: $treble, range: trebleRange) {
            viewModel.updateAmpBank(AmpBank(treble: UInt8($0)))
          }

          parameterSlider(title: "Presence", value: $presence, range: presenceRange) {
            viewModel.updateAmpBank(AmpBank(presence: UInt8($0)))
          }
        }
      }
      .navigationTitle("Amp Settings")
      .task {
        await loadAmpData()
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
        Text("\(Int(value.wrappedValue))")
          .foregroundColor(.secondary)
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

  private func loadAmpData() async {
    guard let bank = await viewModel.readBank(type: AmpBank.self) else { return }

    ampType = bank.type
    gain = Double(bank.gain)
    volume = Double(bank.volume)
    bass = Double(bank.bass)
    middle = Double(bank.middle)
    treble = Double(bank.treble)
    presence = Double(bank.presence)
    variationEnable = bank.variation
  }
}

//#Preview {
//  AmpView(viewModel: ContentViewModel())
//}

extension AmpType {
  var name: String {
    switch self {
    case .acoustic: "Acoustic"
    case .clean: "Clean"
    case .crunch: "Crunch"
    case .brown: "Brown"
    case .lead: "Lead"
    }
  }
}
