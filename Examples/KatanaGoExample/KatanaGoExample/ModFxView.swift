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
  @State private var chorusParams = ChorusState()
  @State private var flangerParams = FlangerState()
  @State private var phaserParams = PhaserState()
  @State private var tremoloParams = TremoloState()
  @State private var compressorParams = CompressorState()

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
              Text("\(type.title)").tag(type)
            }
          }
          .onChange(of: type) { _, newValue in
            updateParameter(.type(newValue))
          }
        }

        if type == .delayChorus30 || type == .twoByTwoChorus {
          Section("Chorus Parameters") {
            parameterSlider(
              title: "Crossover Frequency", value: $chorusParams.crossoverFrequency, range: 0...100
            ) {
              updateParameter(.chorus(.crossoverFrequency(UInt8($0))))
            }
            parameterSlider(title: "Low Rate", value: $chorusParams.lowRate, range: 0...100) {
              updateParameter(.chorus(.lowRate(UInt8($0))))
            }
            parameterSlider(title: "Low Depth", value: $chorusParams.lowDepth, range: 0...100) {
              updateParameter(.chorus(.lowDepth(UInt8($0))))
            }
            parameterSlider(title: "High Rate", value: $chorusParams.highRate, range: 0...100) {
              updateParameter(.chorus(.highRate(UInt8($0))))
            }
            parameterSlider(title: "High Depth", value: $chorusParams.highDepth, range: 0...100) {
              updateParameter(.chorus(.highDepth(UInt8($0))))
            }
            parameterSlider(title: "Direct Mix", value: $chorusParams.directMix, range: 0...100) {
              updateParameter(.chorus(.directMix(UInt8($0))))
            }
          }
        } else if type == .flanger || type == .flanger117E {
          Section("Flanger Parameters") {
            parameterSlider(title: "Rate", value: $flangerParams.rate, range: 0...100) {
              updateParameter(.flanger(.rate(UInt8($0))))
            }
            parameterSlider(title: "Depth", value: $flangerParams.depth, range: 0...100) {
              updateParameter(.flanger(.depth(UInt8($0))))
            }
            parameterSlider(title: "Manual", value: $flangerParams.manual, range: 0...100) {
              updateParameter(.flanger(.manual(UInt8($0))))
            }
            parameterSlider(title: "Resonance", value: $flangerParams.resonance, range: 0...100) {
              updateParameter(.flanger(.resonance(UInt8($0))))
            }
          }
        } else if type == .phaser || type == .phaser90E {
          Section("Phaser Parameters") {
            parameterSlider(title: "Rate", value: $phaserParams.rate, range: 0...100) {
              updateParameter(.phaser(.rate(UInt8($0))))
            }
            parameterSlider(title: "Depth", value: $phaserParams.depth, range: 0...100) {
              updateParameter(.phaser(.depth(UInt8($0))))
            }
            parameterSlider(title: "Manual", value: $phaserParams.manual, range: 0...100) {
              updateParameter(.phaser(.manual(UInt8($0))))
            }
            parameterSlider(title: "Resonance", value: $phaserParams.resonance, range: 0...100) {
              updateParameter(.phaser(.resonance(UInt8($0))))
            }
          }
        } else if type == .tremolo {
          Section("Tremolo Parameters") {
            parameterSlider(title: "Wave Shape", value: $tremoloParams.waveShape, range: 0...100) {
              updateParameter(.tremolo(.waveShape(UInt8($0))))
            }
            parameterSlider(title: "Rate", value: $tremoloParams.rate, range: 0...100) {
              updateParameter(.tremolo(.rate(UInt8($0))))
            }
            parameterSlider(title: "Depth", value: $tremoloParams.depth, range: 0...100) {
              updateParameter(.tremolo(.depth(UInt8($0))))
            }
            parameterSlider(title: "Level", value: $tremoloParams.level, range: 0...100) {
              updateParameter(.tremolo(.level(UInt8($0))))
            }
          }
        } else if type == .compressor {
          Section("Compressor Parameters") {
            parameterSlider(title: "Sustain", value: $compressorParams.sustain, range: 0...100) {
              updateParameter(.comp(.sustain(UInt8($0))))
            }
            parameterSlider(title: "Attack", value: $compressorParams.attack, range: 0...100) {
              updateParameter(.comp(.attack(UInt8($0))))
            }
            parameterSlider(title: "Tone", value: $compressorParams.tone, range: 0...100) {
              updateParameter(.comp(.tone(UInt8($0))))
            }
            parameterSlider(title: "Level", value: $compressorParams.level, range: 0...100) {
              updateParameter(.comp(.level(UInt8($0))))
            }
          }
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

  private func parameterSlider(
    title: String,
    value: Binding<Double>,
    range: ClosedRange<Double>,
    onUpdate: @escaping (Double) -> Void
  ) -> some View {
    VStack(alignment: .leading) {
      Text("\(title): \(Int(value.wrappedValue))")
      Slider(value: value, in: range)
        .onChange(of: value.wrappedValue) { _, newValue in
          onUpdate(newValue)
        }
    }
  }
}

// State structures to keep things organized
struct ChorusState {
  var crossoverFrequency: Double = 50
  var lowRate: Double = 50
  var lowDepth: Double = 50
  var lowPreDelay: Double = 0
  var lowLevel: Double = 50
  var highRate: Double = 50
  var highDepth: Double = 50
  var highPreDelay: Double = 0
  var highLevel: Double = 50
  var directMix: Double = 50
}

struct FlangerState {
  var rate: Double = 50
  var depth: Double = 50
  var manual: Double = 50
  var resonance: Double = 50
  var effectLevel: Double = 50
  var directLevel: Double = 50
}

struct PhaserState {
  var rate: Double = 50
  var depth: Double = 50
  var manual: Double = 50
  var resonance: Double = 50
  var stepRate: Double = 50
  var effectLevel: Double = 50
  var directLevel: Double = 50
}

struct TremoloState {
  var waveShape: Double = 50
  var rate: Double = 50
  var depth: Double = 50
  var level: Double = 50
}

struct CompressorState {
  var sustain: Double = 50
  var attack: Double = 50
  var tone: Double = 50
  var level: Double = 50
}

extension ModFxType {
  var title: String {
    switch self {
    case .tWah: "T-Wah"
    case .autoWah: "Auto Wah"
    case .wah: "Wah"
    case .compressor: "Compressor"
    case .limiter: "Limiter"
    case .graphicEQ: "Graphic EQ"
    case .paraEQ: "Parametric EQ"
    case .guitarSim: "Guitar Sim"
    case .slowGear: "Slow Gear"
    case .waveSynth: "Wave Synth"
    case .octave: "Octave"
    case .pitchShifter: "Pitch Shifter"
    case .harmonist: "Harmonist"
    case .acProcessor: "AC Processor"
    case .phaser: "Phaser"
    case .flanger: "Flanger"
    case .tremolo: "Tremolo"
    case .rotary: "Rotary"
    case .uniV: "Uni-Vibe"
    case .slicer: "Slicer"
    case .vibrato: "Vibrato"
    case .ringMod: "Ring Mod"
    case .humanizer: "Humanizer"
    case .twoByTwoChorus: "2x2 Chorus"
    case .acGuitarSim: "AC Guitar Sim"
    case .phaser90E: "Phaser 90E"
    case .flanger117E: "Flanger 117E"
    case .wah95E: "Wah 95E"
    case .delayChorus30: "Delay Chorus 30"
    case .heavyOctave: "Heavy Octave"
    }
  }
}
