import KatanaGoData
import SwiftUI

struct ChorusView: View {
    @State private var crossoverFrequency: Double = 50
    @State private var lowRate: Double = 50
    @State private var lowDepth: Double = 50
    @State private var lowPreDelay: Double = 0
    @State private var lowLevel: Double = 50
    @State private var highRate: Double = 50
    @State private var highDepth: Double = 50
    @State private var highPreDelay: Double = 0
    @State private var highLevel: Double = 50
    @State private var directMix: Double = 50
    
    let onUpdate: (ModFxParameter) -> Void
    
    var body: some View {
        Section("Chorus Parameters") {
            ParameterSlider(title: "Crossover Frequency", value: $crossoverFrequency, range: 0...100) {
                onUpdate(.chorus(.crossoverFrequency(UInt8($0))))
            }
            ParameterSlider(title: "Low Rate", value: $lowRate, range: 0...100) {
                onUpdate(.chorus(.lowRate(UInt8($0))))
            }
            ParameterSlider(title: "Low Depth", value: $lowDepth, range: 0...100) {
                onUpdate(.chorus(.lowDepth(UInt8($0))))
            }
            ParameterSlider(title: "Low Pre-Delay", value: $lowPreDelay, range: 0...80) {
                onUpdate(.chorus(.lowPreDelay(UInt8($0))))
            }
            ParameterSlider(title: "Low Level", value: $lowLevel, range: 0...100) {
                onUpdate(.chorus(.lowLevel(UInt8($0))))
            }
            ParameterSlider(title: "High Rate", value: $highRate, range: 0...100) {
                onUpdate(.chorus(.highRate(UInt8($0))))
            }
            ParameterSlider(title: "High Depth", value: $highDepth, range: 0...100) {
                onUpdate(.chorus(.highDepth(UInt8($0))))
            }
            ParameterSlider(title: "High Pre-Delay", value: $highPreDelay, range: 0...80) {
                onUpdate(.chorus(.highPreDelay(UInt8($0))))
            }
            ParameterSlider(title: "High Level", value: $highLevel, range: 0...100) {
                onUpdate(.chorus(.highLevel(UInt8($0))))
            }
            ParameterSlider(title: "Direct Mix", value: $directMix, range: 0...100) {
                onUpdate(.chorus(.directMix(UInt8($0))))
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
    
    let onUpdate: (ModFxParameter) -> Void
    
    var body: some View {
        Section("Flanger Parameters") {
            ParameterSlider(title: "Rate", value: $rate, range: 0...100) {
                onUpdate(.flanger(.rate(UInt8($0))))
            }
            ParameterSlider(title: "Depth", value: $depth, range: 0...100) {
                onUpdate(.flanger(.depth(UInt8($0))))
            }
            ParameterSlider(title: "Manual", value: $manual, range: 0...100) {
                onUpdate(.flanger(.manual(UInt8($0))))
            }
            ParameterSlider(title: "Resonance", value: $resonance, range: 0...100) {
                onUpdate(.flanger(.resonance(UInt8($0))))
            }
            Picker("Low Cut", selection: $lowCut) {
                ForEach(FlangerLowCut.allCases, id: \.self) { type in
                    Text("\(type.name)").tag(type)
                }
            }
            .onChange(of: lowCut) { _, newValue in
                onUpdate(.flanger(.lowCut(newValue)))
            }
            ParameterSlider(title: "Effect Level", value: $effectLevel, range: 0...100) {
                onUpdate(.flanger(.effectLevel(UInt8($0))))
            }
            ParameterSlider(title: "Direct Level", value: $directLevel, range: 0...100) {
                onUpdate(.flanger(.directLevel(UInt8($0))))
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
    
    let onUpdate: (ModFxParameter) -> Void
    
    var body: some View {
        Section("Phaser Parameters") {
            Picker("Type", selection: $type) {
                ForEach(PhaserType.allCases, id: \.self) { type in
                    Text("\(type.name)").tag(type)
                }
            }
            .onChange(of: type) { _, newValue in
                onUpdate(.phaser(.type(newValue)))
            }
            ParameterSlider(title: "Rate", value: $rate, range: 0...100) {
                onUpdate(.phaser(.rate(UInt8($0))))
            }
            ParameterSlider(title: "Depth", value: $depth, range: 0...100) {
                onUpdate(.phaser(.depth(UInt8($0))))
            }
            ParameterSlider(title: "Manual", value: $manual, range: 0...100) {
                onUpdate(.phaser(.manual(UInt8($0))))
            }
            ParameterSlider(title: "Resonance", value: $resonance, range: 0...100) {
                onUpdate(.phaser(.resonance(UInt8($0))))
            }
            ParameterSlider(title: "Step Rate", value: $stepRate, range: 0...100) {
                onUpdate(.phaser(.stepRate(UInt8($0))))
            }
            ParameterSlider(title: "Effect Level", value: $effectLevel, range: 0...100) {
                onUpdate(.phaser(.effectLevel(UInt8($0))))
            }
            ParameterSlider(title: "Direct Level", value: $directLevel, range: 0...100) {
                onUpdate(.phaser(.directLevel(UInt8($0))))
            }
        }
    }
}

struct UniVibeView: View {
    @State private var rate: Double = 50
    @State private var depth: Double = 50
    @State private var level: Double = 50
    
    let onUpdate: (ModFxParameter) -> Void
    
    var body: some View {
        Section("Uni-Vibe Parameters") {
            ParameterSlider(title: "Rate", value: $rate, range: 0...100) {
                onUpdate(.uniVibe(.rate(UInt8($0))))
            }
            ParameterSlider(title: "Depth", value: $depth, range: 0...100) {
                onUpdate(.uniVibe(.depth(UInt8($0))))
            }
            ParameterSlider(title: "Level", value: $level, range: 0...100) {
                onUpdate(.uniVibe(.level(UInt8($0))))
            }
        }
    }
}

struct TremoloView: View {
    @State private var waveShape: Double = 50
    @State private var rate: Double = 50
    @State private var depth: Double = 50
    @State private var level: Double = 50
    
    let onUpdate: (ModFxParameter) -> Void
    
    var body: some View {
        Section("Tremolo Parameters") {
            ParameterSlider(title: "Wave Shape", value: $waveShape, range: 0...100) {
                onUpdate(.tremolo(.waveShape(UInt8($0))))
            }
            ParameterSlider(title: "Rate", value: $rate, range: 0...100) {
                onUpdate(.tremolo(.rate(UInt8($0))))
            }
            ParameterSlider(title: "Depth", value: $depth, range: 0...100) {
                onUpdate(.tremolo(.depth(UInt8($0))))
            }
            ParameterSlider(title: "Level", value: $level, range: 0...100) {
                onUpdate(.tremolo(.level(UInt8($0))))
            }
        }
    }
}

struct VibratoView: View {
    @State private var rate: Double = 50
    @State private var depth: Double = 50
    @State private var level: Double = 50
    
    let onUpdate: (ModFxParameter) -> Void
    
    var body: some View {
        Section("Vibrato Parameters") {
            ParameterSlider(title: "Rate", value: $rate, range: 0...100) {
                onUpdate(.vibrato(.rate(UInt8($0))))
            }
            ParameterSlider(title: "Depth", value: $depth, range: 0...100) {
                onUpdate(.vibrato(.depth(UInt8($0))))
            }
            ParameterSlider(title: "Level", value: $level, range: 0...100) {
                onUpdate(.vibrato(.level(UInt8($0))))
            }
        }
    }
}

struct RotaryView: View {
    @State private var rate: Double = 50
    @State private var depth: Double = 50
    @State private var level: Double = 50
    
    let onUpdate: (ModFxParameter) -> Void
    
    var body: some View {
        Section("Rotary Parameters") {
            ParameterSlider(title: "Rate", value: $rate, range: 0...100) {
                onUpdate(.rotary(.rate(UInt8($0))))
            }
            ParameterSlider(title: "Depth", value: $depth, range: 0...100) {
                onUpdate(.rotary(.depth(UInt8($0))))
            }
            ParameterSlider(title: "Level", value: $level, range: 0...100) {
                onUpdate(.rotary(.level(UInt8($0))))
            }
        }
    }
}

struct RingModView: View {
    @State private var mode = RingModMode.normal
    @State private var frequency: Double = 50
    @State private var effectLevel: Double = 50
    @State private var directMix: Double = 50
    
    let onUpdate: (ModFxParameter) -> Void
    
    var body: some View {
        Section("Ring Mod Parameters") {
            Picker("Mode", selection: $mode) {
                ForEach(RingModMode.allCases, id: \.self) { type in
                    Text("\(type.name)").tag(type)
                }
            }
            .onChange(of: mode) { _, newValue in
                onUpdate(.ringMod(.mode(newValue)))
            }
            ParameterSlider(title: "Frequency", value: $frequency, range: 0...100) {
                onUpdate(.ringMod(.frequency(UInt8($0))))
            }
            ParameterSlider(title: "Effect Level", value: $effectLevel, range: 0...100) {
                onUpdate(.ringMod(.effectLevel(UInt8($0))))
            }
            ParameterSlider(title: "Direct Mix", value: $directMix, range: 0...100) {
                onUpdate(.ringMod(.directMix(UInt8($0))))
            }
        }
    }
}
