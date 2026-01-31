import KatanaCore
import KatanaFx
import KatanaGoData
import SwiftUI

struct ChorusView: View {
  @State private var crossoverFrequency: ChorusCrossoverFrequency = .freq250Hz
  @State private var lowRate: Double = 50
  @State private var lowDepth: Double = 50
  @State private var lowPreDelay: Double = 0
  @State private var lowLevel: Double = 50
  @State private var highRate: Double = 50
  @State private var highDepth: Double = 50
  @State private var highPreDelay: Double = 0
  @State private var highLevel: Double = 50
  @State private var directMix: Double = 50

  let onUpdate: (KatanaGoFxBank) -> Void

  var body: some View {
    Section("Chorus Parameters") {
      Picker("Crossover frequency", selection: $crossoverFrequency) {
        ForEach(ChorusCrossoverFrequency.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      .onChange(of: crossoverFrequency) { _, newValue in
        onUpdate(ChorusBank(crossoverFrequency: newValue))
      }
      ParameterSlider(title: "Low Rate", value: $lowRate, range: 0...100) {
        onUpdate(ChorusBank(lowRate: UInt8($0)))
      }
      ParameterSlider(title: "Low Depth", value: $lowDepth, range: 0...100) {
        onUpdate(ChorusBank(lowDepth: UInt8($0)))
      }
      ParameterSlider(title: "Low Pre-Delay", value: $lowPreDelay, range: 0...80) {
        onUpdate(ChorusBank(lowPreDelay: UInt8($0)))
      }
      ParameterSlider(title: "Low Level", value: $lowLevel, range: 0...100) {
        onUpdate(ChorusBank(lowLevel: UInt8($0)))
      }
      ParameterSlider(title: "High Rate", value: $highRate, range: 0...100) {
        onUpdate(ChorusBank(highRate: UInt8($0)))
      }
      ParameterSlider(title: "High Depth", value: $highDepth, range: 0...100) {
        onUpdate(ChorusBank(highDepth: UInt8($0)))
      }
      ParameterSlider(title: "High Pre-Delay", value: $highPreDelay, range: 0...80) {
        onUpdate(ChorusBank(highPreDelay: UInt8($0)))
      }
      ParameterSlider(title: "High Level", value: $highLevel, range: 0...100) {
        onUpdate(ChorusBank(highLevel: UInt8($0)))
      }
      ParameterSlider(title: "Direct Mix", value: $directMix, range: 0...100) {
        onUpdate(ChorusBank(directMix: UInt8($0)))
      }
    }
  }
}

struct FlangerView: View {
  @State private var rate: Double = 50
  @State private var depth: Double = 50
  @State private var manual: Double = 50
  @State private var resonance: Double = 50
  @State private var lowCut = FlangerLowCut.flat
  @State private var effectLevel: Double = 50
  @State private var directLevel: Double = 50

  let onUpdate: (KatanaGoFxBank) -> Void

  var body: some View {
    Section("Flanger Parameters") {
      ParameterSlider(title: "Rate", value: $rate, range: 0...100) {
        onUpdate(FlangerBank(rate: UInt8($0)))
      }
      ParameterSlider(title: "Depth", value: $depth, range: 0...100) {
        onUpdate(FlangerBank(depth: UInt8($0)))
      }
      ParameterSlider(title: "Manual", value: $manual, range: 0...100) {
        onUpdate(FlangerBank(manual: UInt8($0)))
      }
      ParameterSlider(title: "Resonance", value: $resonance, range: 0...100) {
        onUpdate(FlangerBank(resonance: UInt8($0)))
      }
      Picker("Low Cut", selection: $lowCut) {
        ForEach(FlangerLowCut.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      .onChange(of: lowCut) { _, newValue in
        onUpdate(FlangerBank(lowCut: newValue))
      }
      ParameterSlider(title: "Effect Level", value: $effectLevel, range: 0...100) {
        onUpdate(FlangerBank(effectLevel: UInt8($0)))
      }
      ParameterSlider(title: "Direct Level", value: $directLevel, range: 0...100) {
        onUpdate(FlangerBank(directLevel: UInt8($0)))
      }
    }
  }
}

struct PhaserView: View {
  @State private var type = PhaserType.fourStage
  @State private var rate: Double = 50
  @State private var depth: Double = 50
  @State private var manual: Double = 50
  @State private var resonance: Double = 50
  @State private var stepRate: Double = 50
  @State private var effectLevel: Double = 50
  @State private var directLevel: Double = 50

  let onUpdate: (KatanaGoFxBank) -> Void

  var body: some View {
    Section("Phaser Parameters") {
      Picker("Type", selection: $type) {
        ForEach(PhaserType.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      .onChange(of: type) { _, newValue in
        onUpdate(PhaserBank(type: newValue))
      }
      ParameterSlider(title: "Rate", value: $rate, range: 0...100) {
        onUpdate(PhaserBank(rate: UInt8($0)))
      }
      ParameterSlider(title: "Depth", value: $depth, range: 0...100) {
        onUpdate(PhaserBank(depth: UInt8($0)))
      }
      ParameterSlider(title: "Manual", value: $manual, range: 0...100) {
        onUpdate(PhaserBank(manual: UInt8($0)))
      }
      ParameterSlider(title: "Resonance", value: $resonance, range: 0...100) {
        onUpdate(PhaserBank(resonance: UInt8($0)))
      }
      ParameterSlider(title: "Step Rate", value: $stepRate, range: 0...100) {
        onUpdate(PhaserBank(stepRate: UInt8($0)))
      }
      ParameterSlider(title: "Effect Level", value: $effectLevel, range: 0...100) {
        onUpdate(PhaserBank(effectLevel: UInt8($0)))
      }
      ParameterSlider(title: "Direct Level", value: $directLevel, range: 0...100) {
        onUpdate(PhaserBank(directLevel: UInt8($0)))
      }
    }
  }
}

struct UniVibeView: View {
  @State private var rate: Double = 50
  @State private var depth: Double = 50
  @State private var level: Double = 50

  let onUpdate: (KatanaGoFxBank) -> Void

  var body: some View {
    Section("Uni-Vibe Parameters") {
      ParameterSlider(title: "Rate", value: $rate, range: 0...100) {
        onUpdate(UniVibeBank(rate: UInt8($0)))
      }
      ParameterSlider(title: "Depth", value: $depth, range: 0...100) {
        onUpdate(UniVibeBank(depth: UInt8($0)))
      }
      ParameterSlider(title: "Level", value: $level, range: 0...100) {
        onUpdate(UniVibeBank(level: UInt8($0)))
      }
    }
  }
}

struct TremoloView: View {
  @State private var waveShape: Double = 50
  @State private var rate: Double = 50
  @State private var depth: Double = 50
  @State private var level: Double = 50

  let onUpdate: (KatanaGoFxBank) -> Void

  var body: some View {
    Section("Tremolo Parameters") {
      ParameterSlider(title: "Wave Shape", value: $waveShape, range: 0...100) {
        onUpdate(TremoloBank(waveShape: UInt8($0)))
      }
      ParameterSlider(title: "Rate", value: $rate, range: 0...100) {
        onUpdate(TremoloBank(rate: UInt8($0)))
      }
      ParameterSlider(title: "Depth", value: $depth, range: 0...100) {
        onUpdate(TremoloBank(depth: UInt8($0)))
      }
      ParameterSlider(title: "Level", value: $level, range: 0...100) {
        onUpdate(TremoloBank(level: UInt8($0)))
      }
    }
  }
}

struct VibratoView: View {
  @State private var rate: Double = 50
  @State private var depth: Double = 50
  @State private var level: Double = 50

  let onUpdate: (KatanaGoFxBank) -> Void

  var body: some View {
    Section("Vibrato Parameters") {
      ParameterSlider(title: "Rate", value: $rate, range: 0...100) {
        onUpdate(VibratoBank(rate: UInt8($0)))
      }
      ParameterSlider(title: "Depth", value: $depth, range: 0...100) {
        onUpdate(VibratoBank(depth: UInt8($0)))
      }
      ParameterSlider(title: "Level", value: $level, range: 0...100) {
        onUpdate(VibratoBank(level: UInt8($0)))
      }
    }
  }
}

struct RotaryView: View {
  @State private var rate: Double = 50
  @State private var depth: Double = 50
  @State private var level: Double = 50

  let onUpdate: (KatanaGoFxBank) -> Void

  var body: some View {
    Section("Rotary Parameters") {
      ParameterSlider(title: "Rate", value: $rate, range: 0...100) {
        onUpdate(RotaryBank(rate: UInt8($0)))
      }
      ParameterSlider(title: "Depth", value: $depth, range: 0...100) {
        onUpdate(RotaryBank(depth: UInt8($0)))
      }
      ParameterSlider(title: "Level", value: $level, range: 0...100) {
        onUpdate(RotaryBank(level: UInt8($0)))
      }
    }
  }
}

struct RingModView: View {
  @State private var mode = RingModMode.normal
  @State private var frequency: Double = 50
  @State private var effectLevel: Double = 50
  @State private var directMix: Double = 50

  let onUpdate: (KatanaGoFxBank) -> Void

  var body: some View {
    Section("Ring Mod Parameters") {
      Picker("Mode", selection: $mode) {
        ForEach(RingModMode.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      .onChange(of: mode) { _, newValue in
        onUpdate(RingModBank(mode: newValue))
      }
      ParameterSlider(title: "Frequency", value: $frequency, range: 0...100) {
        onUpdate(RingModBank(frequency: UInt8($0)))
      }
      ParameterSlider(title: "Effect Level", value: $effectLevel, range: 0...100) {
        onUpdate(RingModBank(effectLevel: UInt8($0)))
      }
      ParameterSlider(title: "Direct Mix", value: $directMix, range: 0...100) {
        onUpdate(RingModBank(directMix: UInt8($0)))
      }
    }
  }
}

extension ChorusCrossoverFrequency {
  var name: String {
    switch self {
    case .freq100Hz: "100 Hz"
    case .freq125Hz: "125 Hz"
    case .freq160Hz: "160 Hz"
    case .freq200Hz: "200 Hz"
    case .freq250Hz: "250 Hz"
    case .freq315Hz: "315 Hz"
    case .freq400Hz: "400 Hz"
    case .freq500Hz: "500 Hz"
    case .freq630Hz: "630 Hz"
    case .freq800Hz: "800 Hz"
    case .freq1kHz: "1 kHz"
    case .freq1k250Hz: "1.25 kHz"
    case .freq1k600Hz: "1.6 kHz"
    case .freq2kHz: "2 kHz"
    case .freq2k500Hz: "2.5 kHz"
    case .freq3k150Hz: "3.15 kHz"
    case .freq4kHz: "4 kHz"
    }
  }
}
