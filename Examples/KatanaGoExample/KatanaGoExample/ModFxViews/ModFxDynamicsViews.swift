import KatanaGoData
import SwiftUI

struct CompressorView: View {
  @State private var type = CompType.boss
  @State private var sustain: Double = 50
  @State private var attack: Double = 50
  @State private var tone: Double = 50
  @State private var level: Double = 50

  let onUpdate: (ModFxParameter) -> Void

  var body: some View {
    Section("Compressor Parameters") {
      Picker("Type", selection: $type) {
        ForEach(CompType.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      .onChange(of: type) { _, newValue in
        onUpdate(.comp(.type(newValue)))
      }
      ParameterSlider(title: "Sustain", value: $sustain, range: 0...100) {
        onUpdate(.comp(.sustain(UInt8($0))))
      }
      ParameterSlider(title: "Attack", value: $attack, range: 0...100) {
        onUpdate(.comp(.attack(UInt8($0))))
      }
      ParameterSlider(title: "Tone", value: $tone, range: 0...100) {
        onUpdate(.comp(.tone(UInt8($0))))
      }
      ParameterSlider(title: "Level", value: $level, range: 0...100) {
        onUpdate(.comp(.level(UInt8($0))))
      }
    }
  }
}

struct LimiterView: View {
  @State private var type = LimiterType.boss
  @State private var attack: Double = 50
  @State private var threshold: Double = 50
  @State private var ratio = LimiterRatio.oneToOne
  @State private var release: Double = 50
  @State private var level: Double = 50

  let onUpdate: (ModFxParameter) -> Void

  var body: some View {
    Section("Limiter Parameters") {
      Picker("Type", selection: $type) {
        ForEach(LimiterType.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      .onChange(of: type) { _, newValue in
        onUpdate(.limiter(.type(newValue)))
      }
      ParameterSlider(title: "Attack", value: $attack, range: 0...100) {
        onUpdate(.limiter(.attack(UInt8($0))))
      }
      ParameterSlider(title: "Threshold", value: $threshold, range: 0...100) {
        onUpdate(.limiter(.threshold(UInt8($0))))
      }
      Picker("Ratio", selection: $ratio) {
        ForEach(LimiterRatio.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      .onChange(of: ratio) { _, newValue in
        onUpdate(.limiter(.ratio(newValue)))
      }
      ParameterSlider(title: "Release", value: $release, range: 0...100) {
        onUpdate(.limiter(.release(UInt8($0))))
      }
      ParameterSlider(title: "Level", value: $level, range: 0...100) {
        onUpdate(.limiter(.level(UInt8($0))))
      }
    }
  }
}

struct SlowGearView: View {
  @State private var sens: Double = 50
  @State private var riseTime: Double = 50
  @State private var level: Double = 50

  let onUpdate: (ModFxParameter) -> Void

  var body: some View {
    Section("Slow Gear Parameters") {
      ParameterSlider(title: "Sens", value: $sens, range: 0...100) {
        onUpdate(.slowGear(.sens(UInt8($0))))
      }
      ParameterSlider(title: "Rise Time", value: $riseTime, range: 0...100) {
        onUpdate(.slowGear(.riseTime(UInt8($0))))
      }
      ParameterSlider(title: "Level", value: $level, range: 0...100) {
        onUpdate(.slowGear(.level(UInt8($0))))
      }
    }
  }
}

struct SlicerView: View {
  @State private var pattern: Double = 0
  @State private var rate: Double = 50
  @State private var triggerSens: Double = 50
  @State private var effectLevel: Double = 50
  @State private var directMix: Double = 50

  let onUpdate: (ModFxParameter) -> Void

  var body: some View {
    Section("Slicer Parameters") {
      ParameterSlider(title: "Pattern", value: $pattern, range: 0...19) {
        onUpdate(.slicer(.pattern(UInt8($0))))
      }
      ParameterSlider(title: "Rate", value: $rate, range: 0...100) {
        onUpdate(.slicer(.rate(UInt8($0))))
      }
      ParameterSlider(title: "Trigger Sens", value: $triggerSens, range: 0...100) {
        onUpdate(.slicer(.triggerSens(UInt8($0))))
      }
      ParameterSlider(title: "Effect Level", value: $effectLevel, range: 0...100) {
        onUpdate(.slicer(.effectLevel(UInt8($0))))
      }
      ParameterSlider(title: "Direct Mix", value: $directMix, range: 0...100) {
        onUpdate(.slicer(.directMix(UInt8($0))))
      }
    }
  }
}
