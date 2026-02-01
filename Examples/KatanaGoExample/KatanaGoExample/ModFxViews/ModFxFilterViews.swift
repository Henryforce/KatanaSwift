import KatanaCore
import KatanaEQ
import KatanaFx
import KatanaGoData
import SwiftUI

struct TWahView: View {
  @State private var mode = WahMode.lowPassFilter
  @State private var polarity = TWahPolarity.down
  @State private var sens: Double = 50
  @State private var frequency: Double = 50
  @State private var peak: Double = 50
  @State private var effectLevel: Double = 50
  @State private var directLevel: Double = 50

  let onUpdate: (KatanaGoFxBank) -> Void

  var body: some View {
    Section("T-Wah Parameters") {
      Picker("Mode", selection: $mode) {
        ForEach(WahMode.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      .onChange(of: mode) { _, newValue in
        onUpdate(TWahBank(mode: newValue))
      }
      Picker("Polarity", selection: $polarity) {
        ForEach(TWahPolarity.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      .onChange(of: polarity) { _, newValue in
        onUpdate(TWahBank(polarity: newValue))
      }
      ParameterSlider(title: "Sens", value: $sens, range: 0...100) {
        onUpdate(TWahBank(sens: UInt8($0)))
      }
      ParameterSlider(title: "Frequency", value: $frequency, range: 0...100) {
        onUpdate(TWahBank(frequency: UInt8($0)))
      }
      ParameterSlider(title: "Peak", value: $peak, range: 0...100) {
        onUpdate(TWahBank(peak: UInt8($0)))
      }
      ParameterSlider(title: "Effect Level", value: $effectLevel, range: 0...100) {
        onUpdate(TWahBank(effectLevel: UInt8($0)))
      }
      ParameterSlider(title: "Direct Level", value: $directLevel, range: 0...100) {
        onUpdate(TWahBank(directLevel: UInt8($0)))
      }
    }
  }
}

struct AutoWahView: View {
  @State private var mode = WahMode.lowPassFilter
  @State private var frequency: Double = 50
  @State private var peak: Double = 50
  @State private var rate: Double = 50
  @State private var depth: Double = 50
  @State private var effectLevel: Double = 50
  @State private var directLevel: Double = 50

  let onUpdate: (KatanaGoFxBank) -> Void

  var body: some View {
    Section("Auto Wah Parameters") {
      Picker("Mode", selection: $mode) {
        ForEach(WahMode.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      .onChange(of: mode) { _, newValue in
        onUpdate(AutoWahBank(mode: newValue))
      }
      ParameterSlider(title: "Frequency", value: $frequency, range: 0...100) {
        onUpdate(AutoWahBank(frequency: UInt8($0)))
      }
      ParameterSlider(title: "Peak", value: $peak, range: 0...100) {
        onUpdate(AutoWahBank(peak: UInt8($0)))
      }
      ParameterSlider(title: "Rate", value: $rate, range: 0...100) {
        onUpdate(AutoWahBank(rate: UInt8($0)))
      }
      ParameterSlider(title: "Depth", value: $depth, range: 0...100) {
        onUpdate(AutoWahBank(depth: UInt8($0)))
      }
      ParameterSlider(title: "Effect Level", value: $effectLevel, range: 0...100) {
        onUpdate(AutoWahBank(effectLevel: UInt8($0)))
      }
      ParameterSlider(title: "Direct Level", value: $directLevel, range: 0...100) {
        onUpdate(AutoWahBank(directLevel: UInt8($0)))
      }
    }
  }
}

struct GraphicEQView: View {
  @State private var band31Hz: Double = 20
  @State private var band62Hz: Double = 20
  @State private var band125Hz: Double = 20
  @State private var band250Hz: Double = 20
  @State private var band500Hz: Double = 20
  @State private var band1kHz: Double = 20
  @State private var band2kHz: Double = 20
  @State private var band4kHz: Double = 20
  @State private var band8kHz: Double = 20
  @State private var band16kHz: Double = 20
  @State private var level: Double = 20

  let onUpdate: (KatanaGoBank) -> Void

  var body: some View {
    Section("Graphic EQ Parameters") {
      ParameterSlider(title: "31.5 Hz", value: $band31Hz, range: 0...40) {
        onUpdate(GraphicEQBank(band31Hz: UInt8($0)))
      }
      ParameterSlider(title: "63 Hz", value: $band62Hz, range: 0...40) {
        onUpdate(GraphicEQBank(band62Hz: UInt8($0)))
      }
      ParameterSlider(title: "125 Hz", value: $band125Hz, range: 0...40) {
        onUpdate(GraphicEQBank(band125Hz: UInt8($0)))
      }
      ParameterSlider(title: "250 Hz", value: $band250Hz, range: 0...40) {
        onUpdate(GraphicEQBank(band250Hz: UInt8($0)))
      }
      ParameterSlider(title: "500 Hz", value: $band500Hz, range: 0...40) {
        onUpdate(GraphicEQBank(band500Hz: UInt8($0)))
      }
      ParameterSlider(title: "1 kHz", value: $band1kHz, range: 0...40) {
        onUpdate(GraphicEQBank(band1kHz: UInt8($0)))
      }
      ParameterSlider(title: "2 kHz", value: $band2kHz, range: 0...40) {
        onUpdate(GraphicEQBank(band2kHz: UInt8($0)))
      }
      ParameterSlider(title: "4 kHz", value: $band4kHz, range: 0...40) {
        onUpdate(GraphicEQBank(band4kHz: UInt8($0)))
      }
      ParameterSlider(title: "8 kHz", value: $band8kHz, range: 0...40) {
        onUpdate(GraphicEQBank(band8kHz: UInt8($0)))
      }
      ParameterSlider(title: "16 kHz", value: $band16kHz, range: 0...40) {
        onUpdate(GraphicEQBank(band16kHz: UInt8($0)))
      }
      ParameterSlider(title: "Level", value: $level, range: 0...40) {
        onUpdate(GraphicEQBank(level: UInt8($0)))
      }
    }
  }
}

struct ParametricEQView: View {
  @State private var lowCut = EQLowCut.flat
  @State private var lowGain: Double = 20
  @State private var lowMidFreq = EQFrequency.freq500Hz
  @State private var lowMidQ = EQQ.q05
  @State private var lowMidGain: Double = 20
  @State private var highMidFreq = EQFrequency.freq4kHz
  @State private var highMidQ = EQQ.q05
  @State private var highMidGain: Double = 20
  @State private var highGain: Double = 20
  @State private var highCut = EQHighCut.flat
  @State private var level: Double = 20

  let onUpdate: (KatanaGoBank) -> Void

  var body: some View {
    Section("Parametric EQ Parameters") {
      Picker("Low Cut", selection: $lowCut) {
        ForEach(EQLowCut.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      .onChange(of: lowCut) { _, newValue in
        onUpdate(ParametricEQBank(lowCut: newValue))
      }
      ParameterSlider(title: "Low Gain", value: $lowGain, range: 0...40) {
        onUpdate(ParametricEQBank(lowGain: UInt8($0)))
      }
      Picker("Low Mid Freq", selection: $lowMidFreq) {
        ForEach(EQFrequency.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      .onChange(of: lowMidFreq) { _, newValue in
        onUpdate(ParametricEQBank(lowMidFreq: newValue))
      }
      Picker("Low Mid Q", selection: $lowMidQ) {
        ForEach(EQQ.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      .onChange(of: lowMidQ) { _, newValue in
        onUpdate(ParametricEQBank(lowMidQ: newValue))
      }
      ParameterSlider(title: "Low Mid Gain", value: $lowMidGain, range: 0...40) {
        onUpdate(ParametricEQBank(lowMidGain: UInt8($0)))
      }
      Picker("High Mid Freq", selection: $highMidFreq) {
        ForEach(EQFrequency.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      .onChange(of: highMidFreq) { _, newValue in
        onUpdate(ParametricEQBank(highMidFreq: newValue))
      }
      Picker("High Mid Q", selection: $highMidQ) {
        ForEach(EQQ.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      .onChange(of: highMidQ) { _, newValue in
        onUpdate(ParametricEQBank(highMidQ: newValue))
      }
      ParameterSlider(title: "High Mid Gain", value: $highMidGain, range: 0...40) {
        onUpdate(ParametricEQBank(highMidGain: UInt8($0)))
      }
      ParameterSlider(title: "High Gain", value: $highGain, range: 0...40) {
        onUpdate(ParametricEQBank(highGain: UInt8($0)))
      }
      Picker("High Cut", selection: $highCut) {
        ForEach(EQHighCut.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      .onChange(of: highCut) { _, newValue in
        onUpdate(ParametricEQBank(highCut: newValue))
      }
      ParameterSlider(title: "Level", value: $level, range: 0...40) {
        onUpdate(ParametricEQBank(level: UInt8($0)))
      }
    }
  }
}

struct HumanizerView: View {
  @State private var mode = HumanizerMode.picking
  @State private var vowel1 = HumanizerWovel.a
  @State private var vowel2 = HumanizerWovel.e
  @State private var sens: Double = 50
  @State private var rate: Double = 50
  @State private var depth: Double = 50
  @State private var manual: Double = 50
  @State private var level: Double = 50

  let onUpdate: (KatanaGoFxBank) -> Void

  var body: some View {
    Section("Humanizer Parameters") {
      Picker("Mode", selection: $mode) {
        ForEach(HumanizerMode.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      .onChange(of: mode) { _, newValue in
        onUpdate(HumanizerBank(mode: newValue))
      }
      Picker("Vowel 1", selection: $vowel1) {
        ForEach(HumanizerWovel.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      .onChange(of: vowel1) { _, newValue in
        onUpdate(HumanizerBank(vowel1: newValue))
      }
      Picker("Vowel 2", selection: $vowel2) {
        ForEach(HumanizerWovel.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      .onChange(of: vowel2) { _, newValue in
        onUpdate(HumanizerBank(vowel2: newValue))
      }
      ParameterSlider(title: "Sens", value: $sens, range: 0...100) {
        onUpdate(HumanizerBank(sens: UInt8($0)))
      }
      ParameterSlider(title: "Rate", value: $rate, range: 0...100) {
        onUpdate(HumanizerBank(rate: UInt8($0)))
      }
      ParameterSlider(title: "Depth", value: $depth, range: 0...100) {
        onUpdate(HumanizerBank(depth: UInt8($0)))
      }
      ParameterSlider(title: "Manual", value: $manual, range: 0...100) {
        onUpdate(HumanizerBank(manual: UInt8($0)))
      }
      ParameterSlider(title: "Level", value: $level, range: 0...100) {
        onUpdate(HumanizerBank(level: UInt8($0)))
      }
    }
  }
}
