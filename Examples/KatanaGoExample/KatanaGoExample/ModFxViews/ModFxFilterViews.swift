import KatanaCore
import KatanaEQ
import KatanaFx
import KatanaGoData
import SwiftUI

struct TWahView: View {
  var viewModel: ContentViewModel
  var channel: KatanaGoFxChannel

  @State private var mode = WahMode.lowPassFilter
  @State private var polarity = TWahPolarity.down
  @State private var sens: Double = 50
  @State private var frequency: Double = 50
  @State private var peak: Double = 50
  @State private var effectLevel: Double = 50
  @State private var directLevel: Double = 50

  var body: some View {
    Section("T-Wah Parameters") {
      Picker(
        "Mode",
        selection: Binding(
          get: { mode },
          set: {
            mode = $0
            viewModel.updateWritableBank(TWahBank(mode: $0), channel: channel)
          }
        )
      ) {
        ForEach(WahMode.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      Picker(
        "Polarity",
        selection: Binding(
          get: { polarity },
          set: {
            polarity = $0
            viewModel.updateWritableBank(TWahBank(polarity: $0), channel: channel)
          }
        )
      ) {
        ForEach(TWahPolarity.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      ParameterSlider(
        title: "Sens",
        value: Binding(
          get: { sens },
          set: {
            sens = $0
            viewModel.updateWritableBank(TWahBank(sens: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Frequency",
        value: Binding(
          get: { frequency },
          set: {
            frequency = $0
            viewModel.updateWritableBank(TWahBank(frequency: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Peak",
        value: Binding(
          get: { peak },
          set: {
            peak = $0
            viewModel.updateWritableBank(TWahBank(peak: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Effect Level",
        value: Binding(
          get: { effectLevel },
          set: {
            effectLevel = $0
            viewModel.updateWritableBank(TWahBank(effectLevel: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Direct Level",
        value: Binding(
          get: { directLevel },
          set: {
            directLevel = $0
            viewModel.updateWritableBank(TWahBank(directLevel: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
    }
    .task {
      await loadData()
    }
  }

  private func loadData() async {
    guard let bank = await viewModel.readFxBank(type: TWahBank.self, channel: channel) else {
      return
    }
    mode = bank.mode
    polarity = bank.polarity
    sens = Double(bank.sens)
    frequency = Double(bank.frequency)
    peak = Double(bank.peak)
    effectLevel = Double(bank.effectLevel)
    directLevel = Double(bank.directLevel)
  }
}

struct AutoWahView: View {
  var viewModel: ContentViewModel
  var channel: KatanaGoFxChannel

  @State private var mode = WahMode.lowPassFilter
  @State private var frequency: Double = 50
  @State private var peak: Double = 50
  @State private var rate: Double = 50
  @State private var depth: Double = 50
  @State private var effectLevel: Double = 50
  @State private var directLevel: Double = 50

  var body: some View {
    Section("Auto Wah Parameters") {
      Picker(
        "Mode",
        selection: Binding(
          get: { mode },
          set: {
            mode = $0
            viewModel.updateWritableBank(AutoWahBank(mode: $0), channel: channel)
          }
        )
      ) {
        ForEach(WahMode.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      ParameterSlider(
        title: "Frequency",
        value: Binding(
          get: { frequency },
          set: {
            frequency = $0
            viewModel.updateWritableBank(AutoWahBank(frequency: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Peak",
        value: Binding(
          get: { peak },
          set: {
            peak = $0
            viewModel.updateWritableBank(AutoWahBank(peak: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Rate",
        value: Binding(
          get: { rate },
          set: {
            rate = $0
            viewModel.updateWritableBank(AutoWahBank(rate: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Depth",
        value: Binding(
          get: { depth },
          set: {
            depth = $0
            viewModel.updateWritableBank(AutoWahBank(depth: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Effect Level",
        value: Binding(
          get: { effectLevel },
          set: {
            effectLevel = $0
            viewModel.updateWritableBank(AutoWahBank(effectLevel: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Direct Level",
        value: Binding(
          get: { directLevel },
          set: {
            directLevel = $0
            viewModel.updateWritableBank(AutoWahBank(directLevel: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
    }
    .task {
      await loadData()
    }
  }

  private func loadData() async {
    guard let bank = await viewModel.readFxBank(type: AutoWahBank.self, channel: channel) else {
      return
    }
    mode = bank.mode
    frequency = Double(bank.frequency)
    peak = Double(bank.peak)
    rate = Double(bank.rate)
    depth = Double(bank.depth)
    effectLevel = Double(bank.effectLevel)
    directLevel = Double(bank.directLevel)
  }
}

struct GraphicEQView: View {
  var viewModel: ContentViewModel
  var channel: KatanaGoFxChannel

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
  @State private var level: Double = 24

  var body: some View {
    Section("Graphic EQ Parameters") {
      ParameterSlider(
        title: "31.5 Hz",
        value: Binding(
          get: { band31Hz },
          set: {
            band31Hz = $0
            viewModel.updateWritableBank(GraphicEQBank(band31Hz: UInt8($0)))
          }
        ), range: 0...48)
      ParameterSlider(
        title: "63 Hz",
        value: Binding(
          get: { band62Hz },
          set: {
            band62Hz = $0
            viewModel.updateWritableBank(GraphicEQBank(band62Hz: UInt8($0)))
          }
        ), range: 0...48)
      ParameterSlider(
        title: "125 Hz",
        value: Binding(
          get: { band125Hz },
          set: {
            band125Hz = $0
            viewModel.updateWritableBank(GraphicEQBank(band125Hz: UInt8($0)))
          }
        ), range: 0...48)
      ParameterSlider(
        title: "250 Hz",
        value: Binding(
          get: { band250Hz },
          set: {
            band250Hz = $0
            viewModel.updateWritableBank(GraphicEQBank(band250Hz: UInt8($0)))
          }
        ), range: 0...48)
      ParameterSlider(
        title: "500 Hz",
        value: Binding(
          get: { band500Hz },
          set: {
            band500Hz = $0
            viewModel.updateWritableBank(GraphicEQBank(band500Hz: UInt8($0)))
          }
        ), range: 0...48)
      ParameterSlider(
        title: "1 kHz",
        value: Binding(
          get: { band1kHz },
          set: {
            band1kHz = $0
            viewModel.updateWritableBank(GraphicEQBank(band1kHz: UInt8($0)))
          }
        ), range: 0...48)
      ParameterSlider(
        title: "2 kHz",
        value: Binding(
          get: { band2kHz },
          set: {
            band2kHz = $0
            viewModel.updateWritableBank(GraphicEQBank(band2kHz: UInt8($0)))
          }
        ), range: 0...48)
      ParameterSlider(
        title: "4 kHz",
        value: Binding(
          get: { band4kHz },
          set: {
            band4kHz = $0
            viewModel.updateWritableBank(GraphicEQBank(band4kHz: UInt8($0)))
          }
        ), range: 0...48)
      ParameterSlider(
        title: "8 kHz",
        value: Binding(
          get: { band8kHz },
          set: {
            band8kHz = $0
            viewModel.updateWritableBank(GraphicEQBank(band8kHz: UInt8($0)))
          }
        ), range: 0...48)
      ParameterSlider(
        title: "16 kHz",
        value: Binding(
          get: { band16kHz },
          set: {
            band16kHz = $0
            viewModel.updateWritableBank(GraphicEQBank(band16kHz: UInt8($0)))
          }
        ), range: 0...48)
      ParameterSlider(
        title: "Level",
        value: Binding(
          get: { level },
          set: {
            level = $0
            viewModel.updateWritableBank(GraphicEQBank(level: UInt8($0)))
          }
        ), range: 0...48)
    }
    .task {
      await loadData()
    }
  }

  private func loadData() async {
    // Note: GraphicEQ is a normal bank, not an Fx bank, but its address depends on the channel (MOD/FX).
    // For now we use the default address from the bank.
    guard let bank = await viewModel.readBank(type: GraphicEQBank.self) else { return }
    band31Hz = Double(bank.band31Hz)
    band62Hz = Double(bank.band62Hz)
    band125Hz = Double(bank.band125Hz)
    band250Hz = Double(bank.band250Hz)
    band500Hz = Double(bank.band500Hz)
    band1kHz = Double(bank.band1kHz)
    band2kHz = Double(bank.band2kHz)
    band4kHz = Double(bank.band4kHz)
    band8kHz = Double(bank.band8kHz)
    band16kHz = Double(bank.band16kHz)
    level = Double(bank.level)
  }
}

struct ParametricEQView: View {
  var viewModel: ContentViewModel
  var channel: KatanaGoFxChannel

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

  var body: some View {
    Section("Parametric EQ Parameters") {
      Picker(
        "Low Cut",
        selection: Binding(
          get: { lowCut },
          set: {
            lowCut = $0
            viewModel.updateWritableBank(ParametricEQBank(lowCut: $0))
          }
        )
      ) {
        ForEach(EQLowCut.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      ParameterSlider(
        title: "Low Gain",
        value: Binding(
          get: { lowGain },
          set: {
            lowGain = $0
            viewModel.updateWritableBank(ParametricEQBank(lowGain: UInt8($0)))
          }
        ), range: 0...40)
      Picker(
        "Low Mid Freq",
        selection: Binding(
          get: { lowMidFreq },
          set: {
            lowMidFreq = $0
            viewModel.updateWritableBank(ParametricEQBank(lowMidFreq: $0))
          }
        )
      ) {
        ForEach(EQFrequency.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      Picker(
        "Low Mid Q",
        selection: Binding(
          get: { lowMidQ },
          set: {
            lowMidQ = $0
            viewModel.updateWritableBank(ParametricEQBank(lowMidQ: $0))
          }
        )
      ) {
        ForEach(EQQ.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      ParameterSlider(
        title: "Low Mid Gain",
        value: Binding(
          get: { lowMidGain },
          set: {
            lowMidGain = $0
            viewModel.updateWritableBank(ParametricEQBank(lowMidGain: UInt8($0)))
          }
        ), range: 0...40)
      Picker(
        "High Mid Freq",
        selection: Binding(
          get: { highMidFreq },
          set: {
            highMidFreq = $0
            viewModel.updateWritableBank(ParametricEQBank(highMidFreq: $0))
          }
        )
      ) {
        ForEach(EQFrequency.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      Picker(
        "High Mid Q",
        selection: Binding(
          get: { highMidQ },
          set: {
            highMidQ = $0
            viewModel.updateWritableBank(ParametricEQBank(highMidQ: $0))
          }
        )
      ) {
        ForEach(EQQ.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      ParameterSlider(
        title: "High Mid Gain",
        value: Binding(
          get: { highMidGain },
          set: {
            highMidGain = $0
            viewModel.updateWritableBank(ParametricEQBank(highMidGain: UInt8($0)))
          }
        ), range: 0...40)
      ParameterSlider(
        title: "High Gain",
        value: Binding(
          get: { highGain },
          set: {
            highGain = $0
            viewModel.updateWritableBank(ParametricEQBank(highGain: UInt8($0)))
          }
        ), range: 0...40)
      Picker(
        "High Cut",
        selection: Binding(
          get: { highCut },
          set: {
            highCut = $0
            viewModel.updateWritableBank(ParametricEQBank(highCut: $0))
          }
        )
      ) {
        ForEach(EQHighCut.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      ParameterSlider(
        title: "Level",
        value: Binding(
          get: { level },
          set: {
            level = $0
            viewModel.updateWritableBank(ParametricEQBank(level: UInt8($0)))
          }
        ), range: 0...40)
    }
    .task {
      await loadData()
    }
  }

  private func loadData() async {
    guard let bank = await viewModel.readBank(type: ParametricEQBank.self) else { return }
    lowCut = bank.lowCut
    lowGain = Double(bank.lowGain)
    lowMidFreq = bank.lowMidFreq
    lowMidQ = bank.lowMidQ
    lowMidGain = Double(bank.lowMidGain)
    highMidFreq = bank.highMidFreq
    highMidQ = bank.highMidQ
    highMidGain = Double(bank.highMidGain)
    highGain = Double(bank.highGain)
    highCut = bank.highCut
    level = Double(bank.level)
  }
}

struct HumanizerView: View {
  var viewModel: ContentViewModel
  var channel: KatanaGoFxChannel

  @State private var mode = HumanizerMode.picking
  @State private var vowel1 = HumanizerWovel.a
  @State private var vowel2 = HumanizerWovel.e
  @State private var sens: Double = 50
  @State private var rate: Double = 50
  @State private var depth: Double = 50
  @State private var manual: Double = 50
  @State private var level: Double = 50

  var body: some View {
    Section("Humanizer Parameters") {
      Picker(
        "Mode",
        selection: Binding(
          get: { mode },
          set: {
            mode = $0
            viewModel.updateWritableBank(HumanizerBank(mode: $0), channel: channel)
          }
        )
      ) {
        ForEach(HumanizerMode.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      Picker(
        "Vowel 1",
        selection: Binding(
          get: { vowel1 },
          set: {
            vowel1 = $0
            viewModel.updateWritableBank(HumanizerBank(vowel1: $0), channel: channel)
          }
        )
      ) {
        ForEach(HumanizerWovel.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      Picker(
        "Vowel 2",
        selection: Binding(
          get: { vowel2 },
          set: {
            vowel2 = $0
            viewModel.updateWritableBank(HumanizerBank(vowel2: $0), channel: channel)
          }
        )
      ) {
        ForEach(HumanizerWovel.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      ParameterSlider(
        title: "Sens",
        value: Binding(
          get: { sens },
          set: {
            sens = $0
            viewModel.updateWritableBank(HumanizerBank(sens: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Rate",
        value: Binding(
          get: { rate },
          set: {
            rate = $0
            viewModel.updateWritableBank(HumanizerBank(rate: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Depth",
        value: Binding(
          get: { depth },
          set: {
            depth = $0
            viewModel.updateWritableBank(HumanizerBank(depth: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Manual",
        value: Binding(
          get: { manual },
          set: {
            manual = $0
            viewModel.updateWritableBank(HumanizerBank(manual: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Level",
        value: Binding(
          get: { level },
          set: {
            level = $0
            viewModel.updateWritableBank(HumanizerBank(level: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
    }
    .task {
      await loadData()
    }
  }

  private func loadData() async {
    guard let bank = await viewModel.readFxBank(type: HumanizerBank.self, channel: channel) else {
      return
    }
    mode = bank.mode
    vowel1 = bank.vowel1
    vowel2 = bank.vowel2
    sens = Double(bank.sens)
    rate = Double(bank.rate)
    depth = Double(bank.depth)
    manual = Double(bank.manual)
    level = Double(bank.level)
  }
}
