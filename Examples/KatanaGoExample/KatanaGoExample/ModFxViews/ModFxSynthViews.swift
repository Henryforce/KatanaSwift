import KatanaCore
import KatanaEQ
import KatanaFx
import KatanaGoData
import SwiftUI

struct GuitarSimView: View {
  var viewModel: ContentViewModel
  var channel: KatanaGoFxChannel

  @State private var type = GuitarSimType.sToH
  @State private var low: Double = 50
  @State private var high: Double = 50
  @State private var bodyVal: Double = 50
  @State private var level: Double = 50

  var body: some View {
    Section("Guitar Sim Parameters") {
      Picker(
        "Type",
        selection: Binding(
          get: { type },
          set: {
            type = $0
            viewModel.updateWritableBank(GuitarSimBank(type: $0), channel: channel)
          }
        )
      ) {
        ForEach(GuitarSimType.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      ParameterSlider(
        title: "Low",
        value: Binding(
          get: { low },
          set: {
            low = $0
            viewModel.updateWritableBank(GuitarSimBank(low: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "High",
        value: Binding(
          get: { high },
          set: {
            high = $0
            viewModel.updateWritableBank(GuitarSimBank(high: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Body",
        value: Binding(
          get: { bodyVal },
          set: {
            bodyVal = $0
            viewModel.updateWritableBank(GuitarSimBank(body: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Level",
        value: Binding(
          get: { level },
          set: {
            level = $0
            viewModel.updateWritableBank(GuitarSimBank(level: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
    }
    .task {
      await loadData()
    }
  }

  private func loadData() async {
    guard let bank = await viewModel.readFxBank(type: GuitarSimBank.self, channel: channel) else {
      return
    }
    type = bank.type
    low = Double(bank.low)
    high = Double(bank.high)
    bodyVal = Double(bank.body)
    level = Double(bank.level)
  }
}

struct ACSimView: View {
  var viewModel: ContentViewModel
  var channel: KatanaGoFxChannel

  @State private var high: Double = 50
  @State private var bodyVal: Double = 50
  @State private var low: Double = 50
  @State private var level: Double = 50

  var body: some View {
    Section("AC Sim Parameters") {
      ParameterSlider(
        title: "High",
        value: Binding(
          get: { high },
          set: {
            high = $0
            viewModel.updateWritableBank(ACSimBank(high: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Body",
        value: Binding(
          get: { bodyVal },
          set: {
            bodyVal = $0
            viewModel.updateWritableBank(ACSimBank(body: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Low",
        value: Binding(
          get: { low },
          set: {
            low = $0
            viewModel.updateWritableBank(ACSimBank(low: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Level",
        value: Binding(
          get: { level },
          set: {
            level = $0
            viewModel.updateWritableBank(ACSimBank(level: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
    }
    .task {
      await loadData()
    }
  }

  private func loadData() async {
    guard let bank = await viewModel.readFxBank(type: ACSimBank.self, channel: channel) else {
      return
    }
    high = Double(bank.high)
    bodyVal = Double(bank.body)
    low = Double(bank.low)
    level = Double(bank.level)
  }
}

struct AcousticProView: View {
  var viewModel: ContentViewModel
  var channel: KatanaGoFxChannel

  @State private var type = AcousticProType.small
  @State private var bass: Double = 50
  @State private var middle: Double = 50
  @State private var midFrequency = EQFrequency.freq500Hz
  @State private var treble: Double = 50
  @State private var presence: Double = 50
  @State private var level: Double = 50

  var body: some View {
    Section("Acoustic Pro Parameters") {
      Picker(
        "Type",
        selection: Binding(
          get: { type },
          set: {
            type = $0
            viewModel.updateWritableBank(AcousticProBank(type: $0), channel: channel)
          }
        )
      ) {
        ForEach(AcousticProType.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      ParameterSlider(
        title: "Bass",
        value: Binding(
          get: { bass },
          set: {
            bass = $0
            viewModel.updateWritableBank(AcousticProBank(bass: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Middle",
        value: Binding(
          get: { middle },
          set: {
            middle = $0
            viewModel.updateWritableBank(AcousticProBank(middle: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      Picker(
        "Mid Frequency",
        selection: Binding(
          get: { midFrequency },
          set: {
            midFrequency = $0
            viewModel.updateWritableBank(AcousticProBank(midFrequency: $0), channel: channel)
          }
        )
      ) {
        ForEach(EQFrequency.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      ParameterSlider(
        title: "Treble",
        value: Binding(
          get: { treble },
          set: {
            treble = $0
            viewModel.updateWritableBank(AcousticProBank(treble: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Presence",
        value: Binding(
          get: { presence },
          set: {
            presence = $0
            viewModel.updateWritableBank(AcousticProBank(presence: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Level",
        value: Binding(
          get: { level },
          set: {
            level = $0
            viewModel.updateWritableBank(AcousticProBank(level: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
    }
    .task {
      await loadData()
    }
  }

  private func loadData() async {
    guard let bank = await viewModel.readFxBank(type: AcousticProBank.self, channel: channel) else {
      return
    }
    type = bank.type
    bass = Double(bank.bass)
    middle = Double(bank.middle)
    midFrequency = bank.midFrequency
    treble = Double(bank.treble)
    presence = Double(bank.presence)
    level = Double(bank.level)
  }
}

struct WaveSynthView: View {
  var viewModel: ContentViewModel
  var channel: KatanaGoFxChannel

  @State private var type = WaveSynthType.saw
  @State private var cutoff: Double = 50
  @State private var resonance: Double = 50
  @State private var filterSens: Double = 50
  @State private var filterDecay: Double = 50
  @State private var filterDepth: Double = 50
  @State private var synthLevel: Double = 50
  @State private var directMix: Double = 50

  var body: some View {
    Section("Wave Synth Parameters") {
      Picker(
        "Type",
        selection: Binding(
          get: { type },
          set: {
            type = $0
            viewModel.updateWritableBank(WaveSynthBank(type: $0), channel: channel)
          }
        )
      ) {
        ForEach(WaveSynthType.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      ParameterSlider(
        title: "Cutoff",
        value: Binding(
          get: { cutoff },
          set: {
            cutoff = $0
            viewModel.updateWritableBank(WaveSynthBank(cutoff: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Resonance",
        value: Binding(
          get: { resonance },
          set: {
            resonance = $0
            viewModel.updateWritableBank(WaveSynthBank(resonance: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Filter Sens",
        value: Binding(
          get: { filterSens },
          set: {
            filterSens = $0
            viewModel.updateWritableBank(WaveSynthBank(filterSens: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Filter Decay",
        value: Binding(
          get: { filterDecay },
          set: {
            filterDecay = $0
            viewModel.updateWritableBank(WaveSynthBank(filterDecay: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Filter Depth",
        value: Binding(
          get: { filterDepth },
          set: {
            filterDepth = $0
            viewModel.updateWritableBank(WaveSynthBank(filterDepth: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Synth Level",
        value: Binding(
          get: { synthLevel },
          set: {
            synthLevel = $0
            viewModel.updateWritableBank(WaveSynthBank(synthLevel: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Direct Mix",
        value: Binding(
          get: { directMix },
          set: {
            directMix = $0
            viewModel.updateWritableBank(WaveSynthBank(directMix: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
    }
    .task {
      await loadData()
    }
  }

  private func loadData() async {
    guard let bank = await viewModel.readFxBank(type: WaveSynthBank.self, channel: channel) else {
      return
    }
    type = bank.type
    cutoff = Double(bank.cutoff)
    resonance = Double(bank.resonance)
    filterSens = Double(bank.filterSens)
    filterDecay = Double(bank.filterDecay)
    filterDepth = Double(bank.filterDepth)
    synthLevel = Double(bank.synthLevel)
    directMix = Double(bank.directMix)
  }
}
