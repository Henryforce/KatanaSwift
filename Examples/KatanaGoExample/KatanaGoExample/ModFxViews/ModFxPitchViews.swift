import KatanaCore
import KatanaFx
import KatanaGoData
import SwiftUI

struct OctaverView: View {
  var viewModel: ContentViewModel
  var channel: KatanaGoFxChannel

  @State private var range = OctaverRange.range1
  @State private var level: Double = 50
  @State private var directLevel: Double = 50

  var body: some View {
    Section("Octaver Parameters") {
      Picker(
        "Range",
        selection: Binding(
          get: { range },
          set: {
            range = $0
            viewModel.updateWritableBank(OctaverBank(range: $0), channel: channel)
          }
        )
      ) {
        ForEach(OctaverRange.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      ParameterSlider(
        title: "Level",
        value: Binding(
          get: { level },
          set: {
            level = $0
            viewModel.updateWritableBank(OctaverBank(level: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Direct Level",
        value: Binding(
          get: { directLevel },
          set: {
            directLevel = $0
            viewModel.updateWritableBank(OctaverBank(directLevel: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
    }
    .task {
      await loadData()
    }
  }

  private func loadData() async {
    guard let bank = await viewModel.readFxBank(type: OctaverBank.self, channel: channel) else {
      return
    }
    range = bank.range
    level = Double(bank.level)
    directLevel = Double(bank.directLevel)
  }
}

struct HeavyOctaveView: View {
  var viewModel: ContentViewModel
  var channel: KatanaGoFxChannel

  @State private var octaveMinus1: Double = 50
  @State private var octaveMinus2: Double = 50
  @State private var directMix: Double = 50

  var body: some View {
    Section("Heavy Octave Parameters") {
      ParameterSlider(
        title: "Octave -1",
        value: Binding(
          get: { octaveMinus1 },
          set: {
            octaveMinus1 = $0
            viewModel.updateWritableBank(HeavyOctaveBank(octaveMinus1: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Octave -2",
        value: Binding(
          get: { octaveMinus2 },
          set: {
            octaveMinus2 = $0
            viewModel.updateWritableBank(HeavyOctaveBank(octaveMinus2: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Direct Mix",
        value: Binding(
          get: { directMix },
          set: {
            directMix = $0
            viewModel.updateWritableBank(HeavyOctaveBank(directMix: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
    }
    .task {
      await loadData()
    }
  }

  private func loadData() async {
    guard let bank = await viewModel.readFxBank(type: HeavyOctaveBank.self, channel: channel) else {
      return
    }
    octaveMinus1 = Double(bank.octaveMinus1)
    octaveMinus2 = Double(bank.octaveMinus2)
    directMix = Double(bank.directMix)
  }
}

struct PitchShifterView: View {
  var viewModel: ContentViewModel
  var channel: KatanaGoFxChannel

  @State private var voice = PitchShifterVoice.oneVoice
  @State private var ps1Mode = PitchShifterMode.fast
  @State private var ps1Pitch: Double = 50
  @State private var ps1Fine: Double = 50
  @State private var ps1PreDelay: Double = 0
  @State private var ps1Level: Double = 50
  @State private var ps2Mode = PitchShifterMode.fast
  @State private var ps2Pitch: Double = 50
  @State private var ps2Fine: Double = 50
  @State private var ps2PreDelay: Double = 0
  @State private var ps2Level: Double = 50
  @State private var ps1Feedback: Double = 0
  @State private var directLevel: Double = 50

  var body: some View {
    Section("Pitch Shifter Parameters") {
      Picker(
        "Voice",
        selection: Binding(
          get: { voice },
          set: {
            voice = $0
            viewModel.updateWritableBank(PitchShifterBank(voice: $0), channel: channel)
          }
        )
      ) {
        ForEach(PitchShifterVoice.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }

      Group {
        Text("PS1")
        Picker(
          "Mode",
          selection: Binding(
            get: { ps1Mode },
            set: {
              ps1Mode = $0
              viewModel.updateWritableBank(PitchShifterBank(ps1Mode: $0), channel: channel)
            }
          )
        ) {
          ForEach(PitchShifterMode.allCases, id: \.self) { type in
            Text("\(type.name)").tag(type)
          }
        }
        ParameterSlider(
          title: "Pitch",
          value: Binding(
            get: { ps1Pitch },
            set: {
              ps1Pitch = $0
              viewModel.updateWritableBank(PitchShifterBank(ps1Pitch: UInt8($0)), channel: channel)
            }
          ), range: 0...100)
        ParameterSlider(
          title: "Fine",
          value: Binding(
            get: { ps1Fine },
            set: {
              ps1Fine = $0
              viewModel.updateWritableBank(PitchShifterBank(ps1Fine: UInt8($0)), channel: channel)
            }
          ), range: 0...100)
        ParameterSlider(
          title: "Pre-Delay",
          value: Binding(
            get: { ps1PreDelay },
            set: {
              ps1PreDelay = $0
              viewModel.updateWritableBank(
                PitchShifterBank(ps1PreDelay: UInt16($0)), channel: channel)
            }
          ), range: 0...300)
        ParameterSlider(
          title: "Level",
          value: Binding(
            get: { ps1Level },
            set: {
              ps1Level = $0
              viewModel.updateWritableBank(PitchShifterBank(ps1Level: UInt8($0)), channel: channel)
            }
          ), range: 0...100)
        ParameterSlider(
          title: "Feedback",
          value: Binding(
            get: { ps1Feedback },
            set: {
              ps1Feedback = $0
              viewModel.updateWritableBank(
                PitchShifterBank(ps1Feedback: UInt8($0)), channel: channel)
            }
          ), range: 0...100)
      }

      if voice == .twoVoice {
        Group {
          Text("PS2")
          Picker(
            "Mode",
            selection: Binding(
              get: { ps2Mode },
              set: {
                ps2Mode = $0
                viewModel.updateWritableBank(PitchShifterBank(ps2Mode: $0), channel: channel)
              }
            )
          ) {
            ForEach(PitchShifterMode.allCases, id: \.self) { type in
              Text("\(type.name)").tag(type)
            }
          }
          ParameterSlider(
            title: "Pitch",
            value: Binding(
              get: { ps2Pitch },
              set: {
                ps2Pitch = $0
                viewModel.updateWritableBank(
                  PitchShifterBank(ps2Pitch: UInt8($0)), channel: channel)
              }
            ), range: 0...100)
          ParameterSlider(
            title: "Fine",
            value: Binding(
              get: { ps2Fine },
              set: {
                ps2Fine = $0
                viewModel.updateWritableBank(PitchShifterBank(ps2Fine: UInt8($0)), channel: channel)
              }
            ), range: 0...100)
          ParameterSlider(
            title: "Pre-Delay",
            value: Binding(
              get: { ps2PreDelay },
              set: {
                ps2PreDelay = $0
                viewModel.updateWritableBank(
                  PitchShifterBank(ps2PreDelay: UInt16($0)), channel: channel)
              }
            ), range: 0...300)
          ParameterSlider(
            title: "Level",
            value: Binding(
              get: { ps2Level },
              set: {
                ps2Level = $0
                viewModel.updateWritableBank(
                  PitchShifterBank(ps2Level: UInt8($0)), channel: channel)
              }
            ), range: 0...100)
        }
      }

      ParameterSlider(
        title: "Direct Level",
        value: Binding(
          get: { directLevel },
          set: {
            directLevel = $0
            viewModel.updateWritableBank(PitchShifterBank(directLevel: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
    }
    .task {
      await loadData()
    }
  }

  private func loadData() async {
    guard let bank = await viewModel.readFxBank(type: PitchShifterBank.self, channel: channel)
    else { return }
    voice = bank.voice
    ps1Mode = bank.ps1Mode
    ps1Pitch = Double(bank.ps1Pitch)
    ps1Fine = Double(bank.ps1Fine)
    ps1PreDelay = Double(bank.ps1PreDelay)
    ps1Level = Double(bank.ps1Level)
    ps1Feedback = Double(bank.ps1Feedback)
    ps2Mode = bank.ps2Mode
    ps2Pitch = Double(bank.ps2Pitch)
    ps2Fine = Double(bank.ps2Fine)
    ps2PreDelay = Double(bank.ps2PreDelay)
    ps2Level = Double(bank.ps2Level)
    directLevel = Double(bank.directLevel)
  }
}

struct HarmonistView: View {
  var viewModel: ContentViewModel
  var channel: KatanaGoFxChannel

  @State private var voice = HarmonistVoice.oneVoice
  @State private var h1Harmony = HarmonistHarmony.unison
  @State private var h1PreDelay: Double = 0
  @State private var h1Level: Double = 50
  @State private var h2Harmony = HarmonistHarmony.unison
  @State private var h2PreDelay: Double = 0
  @State private var h2Level: Double = 50
  @State private var h1Feedback: Double = 0
  @State private var directLevel: Double = 50

  var body: some View {
    Section("Harmonist Parameters") {
      Picker(
        "Voice",
        selection: Binding(
          get: { voice },
          set: {
            voice = $0
            viewModel.updateWritableBank(HarmonistBank(voice: $0), channel: channel)
          }
        )
      ) {
        ForEach(HarmonistVoice.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }

      Group {
        Text("H1")
        Picker(
          "Harmony",
          selection: Binding(
            get: { h1Harmony },
            set: {
              h1Harmony = $0
              viewModel.updateWritableBank(HarmonistBank(h1Harmony: $0), channel: channel)
            }
          )
        ) {
          ForEach(HarmonistHarmony.allCases, id: \.self) { harmony in
            Text("\(harmony.name)").tag(harmony)
          }
        }
        ParameterSlider(
          title: "Pre-Delay",
          value: Binding(
            get: { h1PreDelay },
            set: {
              h1PreDelay = $0
              viewModel.updateWritableBank(HarmonistBank(h1PreDelay: UInt16($0)), channel: channel)
            }
          ), range: 0...300)
        ParameterSlider(
          title: "Level",
          value: Binding(
            get: { h1Level },
            set: {
              h1Level = $0
              viewModel.updateWritableBank(HarmonistBank(h1Level: UInt8($0)), channel: channel)
            }
          ), range: 0...100)
        ParameterSlider(
          title: "Feedback",
          value: Binding(
            get: { h1Feedback },
            set: {
              h1Feedback = $0
              viewModel.updateWritableBank(HarmonistBank(h1Feedback: UInt8($0)), channel: channel)
            }
          ), range: 0...100)
      }

      if voice == .twoVoice {
        Group {
          Text("H2")
          Picker(
            "Harmony",
            selection: Binding(
              get: { h2Harmony },
              set: {
                h2Harmony = $0
                viewModel.updateWritableBank(HarmonistBank(h2Harmony: $0), channel: channel)
              }
            )
          ) {
            ForEach(HarmonistHarmony.allCases, id: \.self) { harmony in
              Text("\(harmony.name)").tag(harmony)
            }
          }
          ParameterSlider(
            title: "Pre-Delay",
            value: Binding(
              get: { h2PreDelay },
              set: {
                h2PreDelay = $0
                viewModel.updateWritableBank(
                  HarmonistBank(h2PreDelay: UInt16($0)), channel: channel)
              }
            ), range: 0...300)
          ParameterSlider(
            title: "Level",
            value: Binding(
              get: { h2Level },
              set: {
                h2Level = $0
                viewModel.updateWritableBank(HarmonistBank(h2Level: UInt8($0)), channel: channel)
              }
            ), range: 0...100)
        }
      }

      ParameterSlider(
        title: "Direct Level",
        value: Binding(
          get: { directLevel },
          set: {
            directLevel = $0
            viewModel.updateWritableBank(HarmonistBank(directLevel: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
    }
    .task {
      await loadData()
    }
  }

  private func loadData() async {
    guard let bank = await viewModel.readFxBank(type: HarmonistBank.self, channel: channel) else {
      return
    }
    voice = bank.voice
    h1Harmony = bank.h1Harmony
    h1PreDelay = Double(bank.h1PreDelay)
    h1Level = Double(bank.h1Level)
    h2Harmony = bank.h2Harmony
    h2PreDelay = Double(bank.h2PreDelay)
    h2Level = Double(bank.h2Level)
    h1Feedback = Double(bank.h1Feedback)
    directLevel = Double(bank.directLevel)
  }
}
