import KatanaCore
import KatanaFx
import KatanaGoData
import SwiftUI

struct CompressorView: View {
  var viewModel: ContentViewModel
  var channel: KatanaGoFxChannel

  @State private var type = CompType.boss
  @State private var sustain: Double = 50
  @State private var attack: Double = 50
  @State private var tone: Double = 50
  @State private var level: Double = 50

  var body: some View {
    Section("Compressor Parameters") {
      Picker(
        "Type",
        selection: Binding(
          get: { type },
          set: {
            type = $0
            viewModel.updateWritableBank(CompBank(type: $0), channel: channel)
          }
        )
      ) {
        ForEach(CompType.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      ParameterSlider(
        title: "Sustain",
        value: Binding(
          get: { sustain },
          set: {
            sustain = $0
            viewModel.updateWritableBank(CompBank(sustain: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Attack",
        value: Binding(
          get: { attack },
          set: {
            attack = $0
            viewModel.updateWritableBank(CompBank(attack: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Tone",
        value: Binding(
          get: { tone },
          set: {
            tone = $0
            viewModel.updateWritableBank(CompBank(tone: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Level",
        value: Binding(
          get: { level },
          set: {
            level = $0
            viewModel.updateWritableBank(CompBank(level: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
    }
    .task {
      await loadData()
    }
  }

  private func loadData() async {
    guard let bank = await viewModel.readFxBank(type: CompBank.self, channel: channel) else {
      return
    }
    type = bank.type
    sustain = Double(bank.sustain)
    attack = Double(bank.attack)
    tone = Double(bank.tone)
    level = Double(bank.level)
  }
}

struct LimiterView: View {
  var viewModel: ContentViewModel
  var channel: KatanaGoFxChannel

  @State private var type = LimiterType.boss
  @State private var attack: Double = 50
  @State private var threshold: Double = 50
  @State private var ratio = LimiterRatio.oneToOne
  @State private var release: Double = 50
  @State private var level: Double = 50

  var body: some View {
    Section("Limiter Parameters") {
      Picker(
        "Type",
        selection: Binding(
          get: { type },
          set: {
            type = $0
            viewModel.updateWritableBank(LimiterBank(type: $0), channel: channel)
          }
        )
      ) {
        ForEach(LimiterType.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      ParameterSlider(
        title: "Attack",
        value: Binding(
          get: { attack },
          set: {
            attack = $0
            viewModel.updateWritableBank(LimiterBank(attack: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Threshold",
        value: Binding(
          get: { threshold },
          set: {
            threshold = $0
            viewModel.updateWritableBank(LimiterBank(threshold: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      Picker(
        "Ratio",
        selection: Binding(
          get: { ratio },
          set: {
            ratio = $0
            viewModel.updateWritableBank(LimiterBank(ratio: $0), channel: channel)
          }
        )
      ) {
        ForEach(LimiterRatio.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      ParameterSlider(
        title: "Release",
        value: Binding(
          get: { release },
          set: {
            release = $0
            viewModel.updateWritableBank(LimiterBank(release: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Level",
        value: Binding(
          get: { level },
          set: {
            level = $0
            viewModel.updateWritableBank(LimiterBank(level: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
    }
    .task {
      await loadData()
    }
  }

  private func loadData() async {
    guard let bank = await viewModel.readFxBank(type: LimiterBank.self, channel: channel) else {
      return
    }
    type = bank.type
    attack = Double(bank.attack)
    threshold = Double(bank.threshold)
    ratio = bank.ratio
    release = Double(bank.release)
    level = Double(bank.level)
  }
}

struct SlowGearView: View {
  var viewModel: ContentViewModel
  var channel: KatanaGoFxChannel

  @State private var sens: Double = 50
  @State private var riseTime: Double = 50
  @State private var level: Double = 50

  var body: some View {
    Section("Slow Gear Parameters") {
      ParameterSlider(
        title: "Sens",
        value: Binding(
          get: { sens },
          set: {
            sens = $0
            viewModel.updateWritableBank(SlowGearBank(sens: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Rise Time",
        value: Binding(
          get: { riseTime },
          set: {
            riseTime = $0
            viewModel.updateWritableBank(SlowGearBank(riseTime: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Level",
        value: Binding(
          get: { level },
          set: {
            level = $0
            viewModel.updateWritableBank(SlowGearBank(level: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
    }
    .task {
      await loadData()
    }
  }

  private func loadData() async {
    guard let bank = await viewModel.readFxBank(type: SlowGearBank.self, channel: channel) else {
      return
    }
    sens = Double(bank.sens)
    riseTime = Double(bank.riseTime)
    level = Double(bank.level)
  }
}

struct SlicerView: View {
  var viewModel: ContentViewModel
  var channel: KatanaGoFxChannel

  @State private var pattern: Double = 0
  @State private var rate: Double = 50
  @State private var triggerSens: Double = 50
  @State private var effectLevel: Double = 50
  @State private var directMix: Double = 50

  var body: some View {
    Section("Slicer Parameters") {
      ParameterSlider(
        title: "Pattern",
        value: Binding(
          get: { pattern },
          set: {
            pattern = $0
            viewModel.updateWritableBank(SlicerBank(pattern: UInt8($0)), channel: channel)
          }
        ), range: 0...19)
      ParameterSlider(
        title: "Rate",
        value: Binding(
          get: { rate },
          set: {
            rate = $0
            viewModel.updateWritableBank(SlicerBank(rate: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Trigger Sens",
        value: Binding(
          get: { triggerSens },
          set: {
            triggerSens = $0
            viewModel.updateWritableBank(SlicerBank(triggerSens: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Effect Level",
        value: Binding(
          get: { effectLevel },
          set: {
            effectLevel = $0
            viewModel.updateWritableBank(SlicerBank(effectLevel: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Direct Mix",
        value: Binding(
          get: { directMix },
          set: {
            directMix = $0
            viewModel.updateWritableBank(SlicerBank(directMix: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
    }
    .task {
      await loadData()
    }
  }

  private func loadData() async {
    guard let bank = await viewModel.readFxBank(type: SlicerBank.self, channel: channel) else {
      return
    }
    pattern = Double(bank.pattern)
    rate = Double(bank.rate)
    triggerSens = Double(bank.triggerSens)
    effectLevel = Double(bank.effectLevel)
    directMix = Double(bank.directMix)
  }
}
