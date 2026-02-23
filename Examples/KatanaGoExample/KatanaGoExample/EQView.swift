import KatanaEQ
import KatanaGoData
import SwiftUI

struct EQView: View {
  var viewModel: ContentViewModel
  let channel: EQBankChannel

  @State private var isEnabled = false
  @State private var position = EQPosition.ampIn
  @State private var type = EQType.parametric

  // Parametric EQ
  @State private var lowCut = EQLowCut.flat
  @State private var lowGain: Double = 20
  @State private var lowMidFreq = EQFrequency.freq200Hz
  @State private var lowMidQ = EQQ.q1
  @State private var lowMidGain: Double = 20
  @State private var highMidFreq = EQFrequency.freq2kHz
  @State private var highMidQ = EQQ.q1
  @State private var highMidGain: Double = 20
  @State private var highGain: Double = 20
  @State private var highCut = EQHighCut.flat
  @State private var parametricLevel: Double = 20

  // Graphic EQ
  @State private var band31Hz: Double = 24
  @State private var band62Hz: Double = 24
  @State private var band125Hz: Double = 24
  @State private var band250Hz: Double = 24
  @State private var band500Hz: Double = 24
  @State private var band1kHz: Double = 24
  @State private var band2kHz: Double = 24
  @State private var band4kHz: Double = 24
  @State private var band8kHz: Double = 24
  @State private var band16kHz: Double = 24
  @State private var graphicLevel: Double = 24

  private let gainRange: ClosedRange<Double> = 0...40
  private let graphicRange: ClosedRange<Double> = 0...48

  var body: some View {
    NavigationView {
      Form {
        Section("EQ Type") {
          //          Toggle(
          //            "Enabled",
          //            isOn: Binding(
          //              get: { isEnabled },
          //              set: {
          //                isEnabled = $0
          //                viewModel.updateChannelAddressableBank(EQSelectionBank(status: $0), channel: channel)
          //              }
          //            ))

          //          Picker(
          //            "Position",
          //            selection: Binding(
          //              get: { position },
          //              set: {
          //                position = $0
          //                viewModel.updateChannelAddressableBank(EQSelectionBank(position: $0), channel: channel)
          //              }
          //            )
          //          ) {
          //            ForEach(EQPosition.allCases, id: \.self) { pos in
          //              Text("\(pos.name)").tag(pos)
          //            }
          //          }

          //          Picker(
          //            "Type",
          //            selection: Binding(
          //              get: { type },
          //              set: {
          //                type = $0
          //                viewModel.updateChannelAddressableBank(EQSelectionBank(type: $0), channel: channel)
          //              }
          //            )
          //          ) {
          //            ForEach(EQType.allCases, id: \.self) { type in
          //              Text("\(type.name)").tag(type)
          //            }
          //          }
        }

        if type == .parametric {
          Section("Parametric Parameters") {
            Picker(
              "Low Cut",
              selection: Binding(
                get: { lowCut },
                set: {
                  lowCut = $0
                  viewModel.updateChannelAddressableBank(
                    ParametricEQBank(lowCut: $0), channel: channel)
                }
              )
            ) {
              ForEach(EQLowCut.allCases, id: \.self) { cut in
                Text("\(cut.name)").tag(cut)
              }
            }

            parameterSlider(title: "Low Gain", value: $lowGain, range: gainRange) {
              viewModel.updateChannelAddressableBank(
                ParametricEQBank(lowGain: UInt8($0)), channel: channel)
            }

            Picker(
              "Low Mid Freq",
              selection: Binding(
                get: { lowMidFreq },
                set: {
                  lowMidFreq = $0
                  viewModel.updateChannelAddressableBank(
                    ParametricEQBank(lowMidFreq: $0), channel: channel)
                }
              )
            ) {
              ForEach(EQFrequency.allCases, id: \.self) { freq in
                Text("\(freq.name)").tag(freq)
              }
            }

            Picker(
              "Low Mid Q",
              selection: Binding(
                get: { lowMidQ },
                set: {
                  lowMidQ = $0
                  viewModel.updateChannelAddressableBank(
                    ParametricEQBank(lowMidQ: $0), channel: channel)
                }
              )
            ) {
              ForEach(EQQ.allCases, id: \.self) { q in
                Text("\(q.name)").tag(q)
              }
            }

            parameterSlider(title: "Low Mid Gain", value: $lowMidGain, range: gainRange) {
              viewModel.updateChannelAddressableBank(
                ParametricEQBank(lowMidGain: UInt8($0)), channel: channel)
            }

            Picker(
              "High Mid Freq",
              selection: Binding(
                get: { highMidFreq },
                set: {
                  highMidFreq = $0
                  viewModel.updateChannelAddressableBank(
                    ParametricEQBank(highMidFreq: $0), channel: channel)
                }
              )
            ) {
              ForEach(EQFrequency.allCases, id: \.self) { freq in
                Text("\(freq.name)").tag(freq)
              }
            }

            Picker(
              "High Mid Q",
              selection: Binding(
                get: { highMidQ },
                set: {
                  highMidQ = $0
                  viewModel.updateChannelAddressableBank(
                    ParametricEQBank(highMidQ: $0), channel: channel)
                }
              )
            ) {
              ForEach(EQQ.allCases, id: \.self) { q in
                Text("\(q.name)").tag(q)
              }
            }

            parameterSlider(title: "High Mid Gain", value: $highMidGain, range: gainRange) {
              viewModel.updateChannelAddressableBank(
                ParametricEQBank(highMidGain: UInt8($0)), channel: channel)
            }

            parameterSlider(title: "High Gain", value: $highGain, range: gainRange) {
              viewModel.updateChannelAddressableBank(
                ParametricEQBank(highGain: UInt8($0)), channel: channel)
            }

            Picker(
              "High Cut",
              selection: Binding(
                get: { highCut },
                set: {
                  highCut = $0
                  viewModel.updateChannelAddressableBank(
                    ParametricEQBank(highCut: $0), channel: channel)
                }
              )
            ) {
              ForEach(EQHighCut.allCases, id: \.self) { cut in
                Text("\(cut.name)").tag(cut)
              }
            }

            parameterSlider(title: "Level", value: $parametricLevel, range: gainRange) {
              viewModel.updateChannelAddressableBank(
                ParametricEQBank(level: UInt8($0)), channel: channel)
            }
          }
        } else {
          Section("Graphic Parameters") {
            parameterSlider(title: "31.5 Hz", value: $band31Hz, range: graphicRange) {
              viewModel.updateChannelAddressableBank(
                GraphicEQBank(band31Hz: UInt8($0)), channel: channel)
            }
            parameterSlider(title: "62.5 Hz", value: $band62Hz, range: graphicRange) {
              viewModel.updateChannelAddressableBank(
                GraphicEQBank(band62Hz: UInt8($0)), channel: channel)
            }
            parameterSlider(title: "125 Hz", value: $band125Hz, range: graphicRange) {
              viewModel.updateChannelAddressableBank(
                GraphicEQBank(band125Hz: UInt8($0)), channel: channel)
            }
            parameterSlider(title: "250 Hz", value: $band250Hz, range: graphicRange) {
              viewModel.updateChannelAddressableBank(
                GraphicEQBank(band250Hz: UInt8($0)), channel: channel)
            }
            parameterSlider(title: "500 Hz", value: $band500Hz, range: graphicRange) {
              viewModel.updateChannelAddressableBank(
                GraphicEQBank(band500Hz: UInt8($0)), channel: channel)
            }
            parameterSlider(title: "1 kHz", value: $band1kHz, range: graphicRange) {
              viewModel.updateChannelAddressableBank(
                GraphicEQBank(band1kHz: UInt8($0)), channel: channel)
            }
            parameterSlider(title: "2 kHz", value: $band2kHz, range: graphicRange) {
              viewModel.updateChannelAddressableBank(
                GraphicEQBank(band2kHz: UInt8($0)), channel: channel)
            }
            parameterSlider(title: "4 kHz", value: $band4kHz, range: graphicRange) {
              viewModel.updateChannelAddressableBank(
                GraphicEQBank(band4kHz: UInt8($0)), channel: channel)
            }
            parameterSlider(title: "8 kHz", value: $band8kHz, range: graphicRange) {
              viewModel.updateChannelAddressableBank(
                GraphicEQBank(band8kHz: UInt8($0)), channel: channel)
            }
            parameterSlider(title: "16 kHz", value: $band16kHz, range: graphicRange) {
              viewModel.updateChannelAddressableBank(
                GraphicEQBank(band16kHz: UInt8($0)), channel: channel)
            }
            parameterSlider(title: "Level", value: $graphicLevel, range: graphicRange) {
              viewModel.updateChannelAddressableBank(
                GraphicEQBank(level: UInt8($0)), channel: channel)
            }
          }
        }
      }
      .navigationTitle("EQ Settings")
      .task {
        await loadEQData()
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

  private func loadEQData() async {
    let selectionBank = await viewModel.readChannelAddressableBank(
      type: EQSelectionBank.self, channel: channel)
    let parametricBank = await viewModel.readChannelAddressableBank(
      type: ParametricEQBank.self, channel: channel)
    let graphicBank = await viewModel.readChannelAddressableBank(
      type: GraphicEQBank.self, channel: channel)

    if let selectionBank {
      isEnabled = selectionBank.status
      position = selectionBank.position
      type = selectionBank.type
    }

    if let parametricBank {
      lowCut = parametricBank.lowCut
      lowGain = Double(parametricBank.lowGain)
      lowMidFreq = parametricBank.lowMidFreq
      lowMidQ = parametricBank.lowMidQ
      lowMidGain = Double(parametricBank.lowMidGain)
      highMidFreq = parametricBank.highMidFreq
      highMidQ = parametricBank.highMidQ
      highMidGain = Double(parametricBank.highMidGain)
      highGain = Double(parametricBank.highGain)
      highCut = parametricBank.highCut
      parametricLevel = Double(parametricBank.level)
    }

    if let graphicBank {
      band31Hz = Double(graphicBank.band31Hz)
      band62Hz = Double(graphicBank.band62Hz)
      band125Hz = Double(graphicBank.band125Hz)
      band250Hz = Double(graphicBank.band250Hz)
      band500Hz = Double(graphicBank.band500Hz)
      band1kHz = Double(graphicBank.band1kHz)
      band2kHz = Double(graphicBank.band2kHz)
      band4kHz = Double(graphicBank.band4kHz)
      band8kHz = Double(graphicBank.band8kHz)
      band16kHz = Double(graphicBank.band16kHz)
      graphicLevel = Double(graphicBank.level)
    }
  }
}

extension EQType {
  var name: String {
    switch self {
    case .parametric: "Parametric"
    case .graphic: "Graphic"
    }
  }
}

extension EQPosition {
  var name: String {
    switch self {
    case .ampIn: "Amp In"
    case .ampOut: "Amp Out"
    }
  }
}

extension EQLowCut {
  var name: String {
    "\(self)".replacingOccurrences(of: "freq", with: "").replacingOccurrences(of: "Hz", with: " Hz")
      .replacingOccurrences(of: "Hz5", with: ".5 Hz")
      .capitalized
  }
}

extension EQHighCut {
  var name: String {
    "\(self)".replacingOccurrences(of: "freq", with: "").replacingOccurrences(of: "Hz", with: " Hz")
      .replacingOccurrences(of: "k", with: " kHz ").replacingOccurrences(of: "00 Hz", with: " Hz")
      .capitalized
  }
}

//extension EQFrequency {
//  var name: String {
//    "\(self)".replacingOccurrences(of: "freq", with: "").replacingOccurrences(of: "Hz", with: " Hz")
//      .replacingOccurrences(of: "Hz5", with: ".5 Hz")
//      .replacingOccurrences(of: "k", with: " kHz ").replacingOccurrences(of: "00 Hz", with: " Hz")
//      .capitalized
//  }
//}
//
//extension EQQ {
//  var name: String {
//    "\(self)".replacingOccurrences(of: "q", with: "Q").replacingOccurrences(of: "05", with: "0.5")
//  }
//}
