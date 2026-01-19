import KatanaGoData
import SwiftUI

struct GuitarSimView: View {
  @State private var type = GuitarSimType.sToH
  @State private var low: Double = 50
  @State private var high: Double = 50
  @State private var bodyVal: Double = 50
  @State private var level: Double = 50

  let onUpdate: (ModFxParameter) -> Void

  var body: some View {
    Section("Guitar Sim Parameters") {
      Picker("Type", selection: $type) {
        ForEach(GuitarSimType.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      .onChange(of: type) { _, newValue in
        onUpdate(.guitarSim(.type(newValue)))
      }
      ParameterSlider(title: "Low", value: $low, range: 0...100) {
        onUpdate(.guitarSim(.low(UInt8($0))))
      }
      ParameterSlider(title: "High", value: $high, range: 0...100) {
        onUpdate(.guitarSim(.high(UInt8($0))))
      }
      ParameterSlider(title: "Body", value: $bodyVal, range: 0...100) {
        onUpdate(.guitarSim(.body(UInt8($0))))
      }
      ParameterSlider(title: "Level", value: $level, range: 0...100) {
        onUpdate(.guitarSim(.level(UInt8($0))))
      }
    }
  }
}

struct ACSimView: View {
  @State private var high: Double = 50
  @State private var bodyVal: Double = 50
  @State private var low: Double = 50
  @State private var level: Double = 50

  let onUpdate: (ModFxParameter) -> Void

  var body: some View {
    Section("AC Sim Parameters") {
      ParameterSlider(title: "High", value: $high, range: 0...100) {
        onUpdate(.acSim(.high(UInt8($0))))
      }
      ParameterSlider(title: "Body", value: $bodyVal, range: 0...100) {
        onUpdate(.acSim(.body(UInt8($0))))
      }
      ParameterSlider(title: "Low", value: $low, range: 0...100) {
        onUpdate(.acSim(.low(UInt8($0))))
      }
      ParameterSlider(title: "Level", value: $level, range: 0...100) {
        onUpdate(.acSim(.level(UInt8($0))))
      }
    }
  }
}

struct AcousticProView: View {
  @State private var type = AcousticProType.small
  @State private var bass: Double = 50
  @State private var middle: Double = 50
  @State private var midFrequency = EQFrequency.freq500Hz
  @State private var treble: Double = 50
  @State private var presence: Double = 50
  @State private var level: Double = 50

  let onUpdate: (ModFxParameter) -> Void

  var body: some View {
    Section("Acoustic Pro Parameters") {
      Picker("Type", selection: $type) {
        ForEach(AcousticProType.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      .onChange(of: type) { _, newValue in
        onUpdate(.acousticPro(.type(newValue)))
      }
      ParameterSlider(title: "Bass", value: $bass, range: 0...100) {
        onUpdate(.acousticPro(.bass(UInt8($0))))
      }
      ParameterSlider(title: "Middle", value: $middle, range: 0...100) {
        onUpdate(.acousticPro(.middle(UInt8($0))))
      }
      Picker("Mid Frequency", selection: $midFrequency) {
        ForEach(EQFrequency.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      .onChange(of: midFrequency) { _, newValue in
        onUpdate(.acousticPro(.midFrequency(newValue)))
      }
      ParameterSlider(title: "Treble", value: $treble, range: 0...100) {
        onUpdate(.acousticPro(.treble(UInt8($0))))
      }
      ParameterSlider(title: "Presence", value: $presence, range: 0...100) {
        onUpdate(.acousticPro(.presence(UInt8($0))))
      }
      ParameterSlider(title: "Level", value: $level, range: 0...100) {
        onUpdate(.acousticPro(.level(UInt8($0))))
      }
    }
  }
}

struct WaveSynthView: View {
  @State private var type = WaveSynthType.saw
  @State private var cutoff: Double = 50
  @State private var resonance: Double = 50
  @State private var filterSens: Double = 50
  @State private var filterDecay: Double = 50
  @State private var filterDepth: Double = 50
  @State private var synthLevel: Double = 50
  @State private var directMix: Double = 50

  let onUpdate: (ModFxParameter) -> Void

  var body: some View {
    Section("Wave Synth Parameters") {
      Picker("Type", selection: $type) {
        ForEach(WaveSynthType.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      .onChange(of: type) { _, newValue in
        onUpdate(.waveSynth(.type(newValue)))
      }
      ParameterSlider(title: "Cutoff", value: $cutoff, range: 0...100) {
        onUpdate(.waveSynth(.cutoff(UInt8($0))))
      }
      ParameterSlider(title: "Resonance", value: $resonance, range: 0...100) {
        onUpdate(.waveSynth(.resonance(UInt8($0))))
      }
      ParameterSlider(title: "Filter Sens", value: $filterSens, range: 0...100) {
        onUpdate(.waveSynth(.filterSens(UInt8($0))))
      }
      ParameterSlider(title: "Filter Decay", value: $filterDecay, range: 0...100) {
        onUpdate(.waveSynth(.filterDecay(UInt8($0))))
      }
      ParameterSlider(title: "Filter Depth", value: $filterDepth, range: 0...100) {
        onUpdate(.waveSynth(.filterDepth(UInt8($0))))
      }
      ParameterSlider(title: "Synth Level", value: $synthLevel, range: 0...100) {
        onUpdate(.waveSynth(.synthLevel(UInt8($0))))
      }
      ParameterSlider(title: "Direct Mix", value: $directMix, range: 0...100) {
        onUpdate(.waveSynth(.directMix(UInt8($0))))
      }
    }
  }
}
