import KatanaCore
import KatanaFx
import KatanaGoData
import SwiftUI

struct ChorusView: View {
  var viewModel: ContentViewModel
  var channel: KatanaGoFxChannel

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

  var body: some View {
    Section("Chorus Parameters") {
      Picker(
        "Crossover frequency",
        selection: Binding(
          get: { crossoverFrequency },
          set: {
            crossoverFrequency = $0
            viewModel.updateWritableBank(ChorusBank(crossoverFrequency: $0), channel: channel)
          }
        )
      ) {
        ForEach(ChorusCrossoverFrequency.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      ParameterSlider(
        title: "Low Rate",
        value: Binding(
          get: { lowRate },
          set: {
            lowRate = $0
            viewModel.updateWritableBank(ChorusBank(lowRate: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Low Depth",
        value: Binding(
          get: { lowDepth },
          set: {
            lowDepth = $0
            viewModel.updateWritableBank(ChorusBank(lowDepth: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Low Pre-Delay",
        value: Binding(
          get: { lowPreDelay },
          set: {
            lowPreDelay = $0
            viewModel.updateWritableBank(ChorusBank(lowPreDelay: UInt8($0)), channel: channel)
          }
        ), range: 0...80)
      ParameterSlider(
        title: "Low Level",
        value: Binding(
          get: { lowLevel },
          set: {
            lowLevel = $0
            viewModel.updateWritableBank(ChorusBank(lowLevel: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "High Rate",
        value: Binding(
          get: { highRate },
          set: {
            highRate = $0
            viewModel.updateWritableBank(ChorusBank(highRate: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "High Depth",
        value: Binding(
          get: { highDepth },
          set: {
            highDepth = $0
            viewModel.updateWritableBank(ChorusBank(highDepth: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "High Pre-Delay",
        value: Binding(
          get: { highPreDelay },
          set: {
            highPreDelay = $0
            viewModel.updateWritableBank(ChorusBank(highPreDelay: UInt8($0)), channel: channel)
          }
        ), range: 0...80)
      ParameterSlider(
        title: "High Level",
        value: Binding(
          get: { highLevel },
          set: {
            highLevel = $0
            viewModel.updateWritableBank(ChorusBank(highLevel: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Direct Mix",
        value: Binding(
          get: { directMix },
          set: {
            directMix = $0
            viewModel.updateWritableBank(ChorusBank(directMix: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
    }
    .task {
      await loadData()
    }
  }

  private func loadData() async {
    guard let bank = await viewModel.readFxBank(type: ChorusBank.self, channel: channel) else {
      return
    }
    crossoverFrequency = bank.crossoverFrequency
    lowRate = Double(bank.lowRate)
    lowDepth = Double(bank.lowDepth)
    lowPreDelay = Double(bank.lowPreDelay)
    lowLevel = Double(bank.lowLevel)
    highRate = Double(bank.highRate)
    highDepth = Double(bank.highDepth)
    highPreDelay = Double(bank.highPreDelay)
    highLevel = Double(bank.highLevel)
    directMix = Double(bank.directMix)
  }
}

struct FlangerView: View {
  var viewModel: ContentViewModel
  var channel: KatanaGoFxChannel

  @State private var rate: Double = 50
  @State private var depth: Double = 50
  @State private var manual: Double = 50
  @State private var resonance: Double = 50
  @State private var lowCut = FlangerLowCut.flat
  @State private var effectLevel: Double = 50
  @State private var directLevel: Double = 50

  var body: some View {
    Section("Flanger Parameters") {
      ParameterSlider(
        title: "Rate",
        value: Binding(
          get: { rate },
          set: {
            rate = $0
            viewModel.updateWritableBank(FlangerBank(rate: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Depth",
        value: Binding(
          get: { depth },
          set: {
            depth = $0
            viewModel.updateWritableBank(FlangerBank(depth: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Manual",
        value: Binding(
          get: { manual },
          set: {
            manual = $0
            viewModel.updateWritableBank(FlangerBank(manual: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Resonance",
        value: Binding(
          get: { resonance },
          set: {
            resonance = $0
            viewModel.updateWritableBank(FlangerBank(resonance: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      Picker(
        "Low Cut",
        selection: Binding(
          get: { lowCut },
          set: {
            lowCut = $0
            viewModel.updateWritableBank(FlangerBank(lowCut: $0), channel: channel)
          }
        )
      ) {
        ForEach(FlangerLowCut.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      ParameterSlider(
        title: "Effect Level",
        value: Binding(
          get: { effectLevel },
          set: {
            effectLevel = $0
            viewModel.updateWritableBank(FlangerBank(effectLevel: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Direct Level",
        value: Binding(
          get: { directLevel },
          set: {
            directLevel = $0
            viewModel.updateWritableBank(FlangerBank(directLevel: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
    }
    .task {
      await loadData()
    }
  }

  private func loadData() async {
    guard let bank = await viewModel.readFxBank(type: FlangerBank.self, channel: channel) else {
      return
    }
    rate = Double(bank.rate)
    depth = Double(bank.depth)
    manual = Double(bank.manual)
    resonance = Double(bank.resonance)
    lowCut = bank.lowCut
    effectLevel = Double(bank.effectLevel)
    directLevel = Double(bank.directLevel)
  }
}

struct PhaserView: View {
  var viewModel: ContentViewModel
  var channel: KatanaGoFxChannel

  @State private var type = PhaserType.fourStage
  @State private var rate: Double = 50
  @State private var depth: Double = 50
  @State private var manual: Double = 50
  @State private var resonance: Double = 50
  @State private var stepRate: Double = 50
  @State private var effectLevel: Double = 50
  @State private var directLevel: Double = 50

  var body: some View {
    Section("Phaser Parameters") {
      Picker(
        "Type",
        selection: Binding(
          get: { type },
          set: {
            type = $0
            viewModel.updateWritableBank(PhaserBank(type: $0), channel: channel)
          }
        )
      ) {
        ForEach(PhaserType.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      ParameterSlider(
        title: "Rate",
        value: Binding(
          get: { rate },
          set: {
            rate = $0
            viewModel.updateWritableBank(PhaserBank(rate: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Depth",
        value: Binding(
          get: { depth },
          set: {
            depth = $0
            viewModel.updateWritableBank(PhaserBank(depth: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Manual",
        value: Binding(
          get: { manual },
          set: {
            manual = $0
            viewModel.updateWritableBank(PhaserBank(manual: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Resonance",
        value: Binding(
          get: { resonance },
          set: {
            resonance = $0
            viewModel.updateWritableBank(PhaserBank(resonance: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Step Rate",
        value: Binding(
          get: { stepRate },
          set: {
            stepRate = $0
            viewModel.updateWritableBank(PhaserBank(stepRate: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Effect Level",
        value: Binding(
          get: { effectLevel },
          set: {
            effectLevel = $0
            viewModel.updateWritableBank(PhaserBank(effectLevel: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Direct Level",
        value: Binding(
          get: { directLevel },
          set: {
            directLevel = $0
            viewModel.updateWritableBank(PhaserBank(directLevel: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
    }
    .task {
      await loadData()
    }
  }

  private func loadData() async {
    guard let bank = await viewModel.readFxBank(type: PhaserBank.self, channel: channel) else {
      return
    }
    type = bank.type
    rate = Double(bank.rate)
    depth = Double(bank.depth)
    manual = Double(bank.manual)
    resonance = Double(bank.resonance)
    stepRate = Double(bank.stepRate)
    effectLevel = Double(bank.effectLevel)
    directLevel = Double(bank.directLevel)
  }
}

struct UniVibeView: View {
  var viewModel: ContentViewModel
  var channel: KatanaGoFxChannel

  @State private var rate: Double = 50
  @State private var depth: Double = 50
  @State private var level: Double = 50

  var body: some View {
    Section("Uni-Vibe Parameters") {
      ParameterSlider(
        title: "Rate",
        value: Binding(
          get: { rate },
          set: {
            rate = $0
            viewModel.updateWritableBank(UniVibeBank(rate: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Depth",
        value: Binding(
          get: { depth },
          set: {
            depth = $0
            viewModel.updateWritableBank(UniVibeBank(depth: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Level",
        value: Binding(
          get: { level },
          set: {
            level = $0
            viewModel.updateWritableBank(UniVibeBank(level: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
    }
    .task {
      await loadData()
    }
  }

  private func loadData() async {
    guard let bank = await viewModel.readFxBank(type: UniVibeBank.self, channel: channel) else {
      return
    }
    rate = Double(bank.rate)
    depth = Double(bank.depth)
    level = Double(bank.level)
  }
}

struct TremoloView: View {
  var viewModel: ContentViewModel
  var channel: KatanaGoFxChannel

  @State private var waveShape: Double = 50
  @State private var rate: Double = 50
  @State private var depth: Double = 50
  @State private var level: Double = 50

  var body: some View {
    Section("Tremolo Parameters") {
      ParameterSlider(
        title: "Wave Shape",
        value: Binding(
          get: { waveShape },
          set: {
            waveShape = $0
            viewModel.updateWritableBank(TremoloBank(waveShape: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Rate",
        value: Binding(
          get: { rate },
          set: {
            rate = $0
            viewModel.updateWritableBank(TremoloBank(rate: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Depth",
        value: Binding(
          get: { depth },
          set: {
            depth = $0
            viewModel.updateWritableBank(TremoloBank(depth: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Level",
        value: Binding(
          get: { level },
          set: {
            level = $0
            viewModel.updateWritableBank(TremoloBank(level: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
    }
    .task {
      await loadData()
    }
  }

  private func loadData() async {
    guard let bank = await viewModel.readFxBank(type: TremoloBank.self, channel: channel) else {
      return
    }
    waveShape = Double(bank.waveShape)
    rate = Double(bank.rate)
    depth = Double(bank.depth)
    level = Double(bank.level)
  }
}

struct VibratoView: View {
  var viewModel: ContentViewModel
  var channel: KatanaGoFxChannel

  @State private var rate: Double = 50
  @State private var depth: Double = 50
  @State private var level: Double = 50

  var body: some View {
    Section("Vibrato Parameters") {
      ParameterSlider(
        title: "Rate",
        value: Binding(
          get: { rate },
          set: {
            rate = $0
            viewModel.updateWritableBank(VibratoBank(rate: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Depth",
        value: Binding(
          get: { depth },
          set: {
            depth = $0
            viewModel.updateWritableBank(VibratoBank(depth: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Level",
        value: Binding(
          get: { level },
          set: {
            level = $0
            viewModel.updateWritableBank(VibratoBank(level: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
    }
    .task {
      await loadData()
    }
  }

  private func loadData() async {
    guard let bank = await viewModel.readFxBank(type: VibratoBank.self, channel: channel) else {
      return
    }
    rate = Double(bank.rate)
    depth = Double(bank.depth)
    level = Double(bank.level)
  }
}

struct RotaryView: View {
  var viewModel: ContentViewModel
  var channel: KatanaGoFxChannel

  @State private var rate: Double = 50
  @State private var depth: Double = 50
  @State private var level: Double = 50

  var body: some View {
    Section("Rotary Parameters") {
      ParameterSlider(
        title: "Rate",
        value: Binding(
          get: { rate },
          set: {
            rate = $0
            viewModel.updateWritableBank(RotaryBank(rate: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Depth",
        value: Binding(
          get: { depth },
          set: {
            depth = $0
            viewModel.updateWritableBank(RotaryBank(depth: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Level",
        value: Binding(
          get: { level },
          set: {
            level = $0
            viewModel.updateWritableBank(RotaryBank(level: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
    }
    .task {
      await loadData()
    }
  }

  private func loadData() async {
    guard let bank = await viewModel.readFxBank(type: RotaryBank.self, channel: channel) else {
      return
    }
    rate = Double(bank.rate)
    depth = Double(bank.depth)
    level = Double(bank.level)
  }
}

struct RingModView: View {
  var viewModel: ContentViewModel
  var channel: KatanaGoFxChannel

  @State private var mode = RingModMode.normal
  @State private var frequency: Double = 50
  @State private var effectLevel: Double = 50
  @State private var directMix: Double = 50

  var body: some View {
    Section("Ring Mod Parameters") {
      Picker(
        "Mode",
        selection: Binding(
          get: { mode },
          set: {
            mode = $0
            viewModel.updateWritableBank(RingModBank(mode: $0), channel: channel)
          }
        )
      ) {
        ForEach(RingModMode.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      ParameterSlider(
        title: "Frequency",
        value: Binding(
          get: { frequency },
          set: {
            frequency = $0
            viewModel.updateWritableBank(RingModBank(frequency: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Effect Level",
        value: Binding(
          get: { effectLevel },
          set: {
            effectLevel = $0
            viewModel.updateWritableBank(RingModBank(effectLevel: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Direct Mix",
        value: Binding(
          get: { directMix },
          set: {
            directMix = $0
            viewModel.updateWritableBank(RingModBank(directMix: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
    }
    .task {
      await loadData()
    }
  }

  private func loadData() async {
    guard let bank = await viewModel.readFxBank(type: RingModBank.self, channel: channel) else {
      return
    }
    mode = bank.mode
    frequency = Double(bank.frequency)
    effectLevel = Double(bank.effectLevel)
    directMix = Double(bank.directMix)
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
