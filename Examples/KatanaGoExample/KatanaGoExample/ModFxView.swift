//
//  ModFxView.swift
//  KatanaGoExample
//
//  Created by Henry Javier Serrano Echeverria on 2026/01/18.
//

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
          Toggle("Enabled", isOn: $isEnabled)
            .onChange(of: isEnabled) { _, newValue in
              print("Dog")
              viewModel.enableFx(newValue, channel: channel)
            }

          Picker("Type", selection: $type) {
            ForEach(ModFxType.allCases, id: \.self) { type in
              Text("\(type.name)").tag(type)
            }
          }
          .onChange(of: type) { _, newValue in
            viewModel.selectFxType(type, channel: channel)
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
  }

  @Environment(\.dismiss) private var dismissAction

  @ViewBuilder
  private func buildViewFromType(_ type: ModFxType) -> some View {
    switch type {
    case .chorus: ChorusView(onUpdate: updateBank)
    case .flanger: FlangerView(onUpdate: updateBank)
    case .phaser: PhaserView(onUpdate: updateBank)
    case .uniV: UniVibeView(onUpdate: updateBank)
    case .tremolo: TremoloView(onUpdate: updateBank)
    case .vibrato: VibratoView(onUpdate: updateBank)
    case .rotary: RotaryView(onUpdate: updateBank)
    case .ringMod: RingModView(onUpdate: updateBank)
    case .slowGear: SlowGearView(onUpdate: updateBank)
    case .slicer: SlicerView(onUpdate: updateBank)
    case .comp: CompressorView(onUpdate: updateBank)
    case .limiter: LimiterView(onUpdate: updateBank)
    case .tWah: TWahView(onUpdate: updateBank)
    case .autoWah: AutoWahView(onUpdate: updateBank)
    case .graphicEQ: GraphicEQView(onUpdate: updateNormalBank)
    case .parametricEQ: ParametricEQView(onUpdate: updateNormalBank)
    case .guitarSim: GuitarSimView(onUpdate: updateBank)
    case .acSim: ACSimView(onUpdate: updateBank)
    case .acousticPro: AcousticProView(onUpdate: updateBank)
    case .waveSynth: WaveSynthView(onUpdate: updateBank)
    case .octave: OctaverView(onUpdate: updateBank)
    case .heavyOctave: HeavyOctaveView(onUpdate: updateBank)
    case .pitchShifter: PitchShifterView(onUpdate: updateBank)
    case .harmonist: HarmonistView(onUpdate: updateBank)
    case .humanizer: HumanizerView(onUpdate: updateBank)
    case .phaser90E: Phaser90EView(onUpdate: updateBank)
    case .flanger117E: Flanger117EView(onUpdate: updateBank)
    case .dc30: DC30View(onUpdate: updateBank)
    }
  }

  private func updateBank(_ bank: KatanaGoFxBank) {
    viewModel.updateWritableBank(bank, channel: channel)
  }

  private func updateNormalBank(_ bank: WritableBank) {
    viewModel.updateWritableBank(bank)
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
