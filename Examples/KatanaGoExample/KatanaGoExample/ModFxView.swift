import KatanaCore
import KatanaFx
import KatanaGoData
import SwiftUI

struct ModFxView: View {
  var viewModel: ContentViewModel
  let channel: KatanaGoFxChannel

  @State private var isEnabled = false
  @State private var type = ModFxType.chorus

  var body: some View {
    NavigationView {
      Form {
        Section("General") {
          Toggle(
            "Enabled",
            isOn: Binding(
              get: { isEnabled },
              set: {
                isEnabled = $0
                viewModel.enableFx($0, channel: channel)
              }
            ))

          Picker(
            "Type",
            selection: Binding(
              get: { type },
              set: {
                type = $0
                viewModel.selectFxType($0, channel: channel)
              }
            )
          ) {
            ForEach(ModFxType.allCases, id: \.self) { type in
              Text("\(type.name)").tag(type)
            }
          }
        }

        buildViewFromType(type)
      }
      .navigationTitle("Settings \(channel.name)")
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          Button("Done") {
            dismissAction()
          }
        }
      }
    }
    .task {
      await loadData()
    }
  }

  private func loadData() async {
    if let effectStatusBank = await viewModel.readBank(type: EffectStatusBank.self) {
      if channel == .mod {
        isEnabled = effectStatusBank.mod
      } else {
        isEnabled = effectStatusBank.fx
      }
    }

    if channel == .mod, let bank = await viewModel.readBank(type: ModSelectionBank.self) {
      type = bank.type
    } else if let bank = await viewModel.readBank(type: FxSelectionBank.self) {
      type = bank.type
    }
  }

  @Environment(\.dismiss) private var dismissAction

  @ViewBuilder
  private func buildViewFromType(_ type: ModFxType) -> some View {
    switch type {
    case .chorus: ChorusView(viewModel: viewModel, channel: channel)
    case .flanger: FlangerView(viewModel: viewModel, channel: channel)
    case .phaser: PhaserView(viewModel: viewModel, channel: channel)
    case .uniV: UniVibeView(viewModel: viewModel, channel: channel)
    case .tremolo: TremoloView(viewModel: viewModel, channel: channel)
    case .vibrato: VibratoView(viewModel: viewModel, channel: channel)
    case .rotary: RotaryView(viewModel: viewModel, channel: channel)
    case .ringMod: RingModView(viewModel: viewModel, channel: channel)
    case .slowGear: SlowGearView(viewModel: viewModel, channel: channel)
    case .slicer: SlicerView(viewModel: viewModel, channel: channel)
    case .comp: CompressorView(viewModel: viewModel, channel: channel)
    case .limiter: LimiterView(viewModel: viewModel, channel: channel)
    case .tWah: TWahView(viewModel: viewModel, channel: channel)
    case .autoWah: AutoWahView(viewModel: viewModel, channel: channel)
    case .graphicEQ: GraphicEQView(viewModel: viewModel, channel: channel)
    case .parametricEQ: ParametricEQView(viewModel: viewModel, channel: channel)
    case .guitarSim: GuitarSimView(viewModel: viewModel, channel: channel)
    case .acSim: ACSimView(viewModel: viewModel, channel: channel)
    case .acousticPro: AcousticProView(viewModel: viewModel, channel: channel)
    case .waveSynth: WaveSynthView(viewModel: viewModel, channel: channel)
    case .octave: OctaverView(viewModel: viewModel, channel: channel)
    case .heavyOctave: HeavyOctaveView(viewModel: viewModel, channel: channel)
    case .pitchShifter: PitchShifterView(viewModel: viewModel, channel: channel)
    case .harmonist: HarmonistView(viewModel: viewModel, channel: channel)
    case .humanizer: HumanizerView(viewModel: viewModel, channel: channel)
    case .phaser90E: Phaser90EView(viewModel: viewModel, channel: channel)
    case .flanger117E: Flanger117EView(viewModel: viewModel, channel: channel)
    case .dc30: DC30View(viewModel: viewModel, channel: channel)
    }
  }
}

extension KatanaGoFxChannel {
  var name: String {
    switch self {
    case .mod: "MOD"
    case .fx: "FX"
    }
  }
}
