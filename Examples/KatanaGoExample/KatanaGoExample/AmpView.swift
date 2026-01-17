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
          Picker("Amp Type", selection: $ampType) {
            ForEach(AmpType.allCases, id: \.self) { type in
              Text("\(type.name)").tag(type)
            }
          }
          .onChange(of: ampType) { _, newValue in
            viewModel.updateAmp(.ampType(newValue))
          }

          Toggle("Variation", isOn: $variationEnable)
            .onChange(of: variationEnable) { _, newValue in
              viewModel.updateAmp(.variation(newValue))
            }
        }

        Section("Tone Controls") {
          parameterSlider(title: "Gain", value: $gain, range: gainRange) {
            viewModel.updateAmp(.gain(UInt8($0)))
          }

          parameterSlider(title: "Volume", value: $volume, range: volumeRange) {
            viewModel.updateAmp(.volume(UInt8($0)))
          }

          parameterSlider(title: "Bass", value: $bass, range: bassRange) {
            viewModel.updateAmp(.bass(UInt8($0)))
          }

          parameterSlider(title: "Middle", value: $middle, range: middleRange) {
            viewModel.updateAmp(.middle(UInt8($0)))
          }

          parameterSlider(title: "Treble", value: $treble, range: trebleRange) {
            viewModel.updateAmp(.treble(UInt8($0)))
          }

          parameterSlider(title: "Presence", value: $presence, range: presenceRange) {
            viewModel.updateAmp(.presence(UInt8($0)))
          }
        }
      }
      .navigationTitle("Amp Settings")
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
      Slider(value: value, in: range)
        .onChange(of: value.wrappedValue) { _, newValue in
          onUpdate(newValue)
        }
    }
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
