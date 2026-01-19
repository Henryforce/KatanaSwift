//
//  ModFxView.swift
//  KatanaGoExample
//
//  Created by Henry Javier Serrano Echeverria on 2026/01/18.
//

import KatanaGoData
import SwiftUI

enum ModFxMode: String {
  case mod = "MOD"
  case fx = "FX"
}

struct ModFxView: View {
  var viewModel: ContentViewModel
  let mode: ModFxMode

  @State private var isEnabled = false
  @State private var type = ModFxType.twoByTwoChorus

  var body: some View {
    NavigationView {
      Form {
        Section("General") {
          Toggle("Enabled", isOn: $isEnabled)
            .onChange(of: isEnabled) { _, newValue in
              updateParameter(.enable(newValue))
            }

          Picker("Type", selection: $type) {
            ForEach(ModFxType.allCases, id: \.self) { type in
              Text("\(type.name)").tag(type)
            }
          }
          .onChange(of: type) { _, newValue in
            updateParameter(.type(newValue))
          }
        }

        switch type {
        case .twoByTwoChorus: ChorusView(onUpdate: updateParameter)
        case .flanger: FlangerView(onUpdate: updateParameter)
        case .phaser: PhaserView(onUpdate: updateParameter)
        case .uniV: UniVibeView(onUpdate: updateParameter)
        case .tremolo: TremoloView(onUpdate: updateParameter)
        case .vibrato: VibratoView(onUpdate: updateParameter)
        case .rotary: RotaryView(onUpdate: updateParameter)
        case .ringMod: RingModView(onUpdate: updateParameter)
        case .slowGear: SlowGearView(onUpdate: updateParameter)
        case .slicer: SlicerView(onUpdate: updateParameter)
        case .comp: CompressorView(onUpdate: updateParameter)
        case .limiter: LimiterView(onUpdate: updateParameter)
        case .tWah: TWahView(onUpdate: updateParameter)
        case .autoWah: AutoWahView(onUpdate: updateParameter)
        case .graphicEQ: GraphicEQView(onUpdate: updateParameter)
        case .parametricEQ: ParametricEQView(onUpdate: updateParameter)
        case .guitarSim: GuitarSimView(onUpdate: updateParameter)
        case .acSim: ACSimView(onUpdate: updateParameter)
        case .acousticPro: AcousticProView(onUpdate: updateParameter)
        case .waveSynth: WaveSynthView(onUpdate: updateParameter)
        case .octave: OctaverView(onUpdate: updateParameter)
        case .heavyOctave: HeavyOctaveView(onUpdate: updateParameter)
        case .pitchShifter: PitchShifterView(onUpdate: updateParameter)
        case .harmonist: HarmonistView(onUpdate: updateParameter)
        case .humanizer: HumanizerView(onUpdate: updateParameter)
        case .phaser90E: Phaser90EView(onUpdate: updateParameter)
        case .flanger117E: Flanger117EView(onUpdate: updateParameter)
        case .dc30: DC30View(onUpdate: updateParameter)
        }
      }
      .navigationTitle("\(mode.rawValue) Settings")
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

  private func updateParameter(_ parameter: ModFxParameter) {
    switch mode {
    case .mod:
      viewModel.updateMod(parameter)
    case .fx:
      viewModel.updateFx(parameter)
    }
  }
}

