import KatanaGoData
import SwiftUI

struct OctaverView: View {
    @State private var range = OctaverRange.range1
    @State private var level: Double = 50
    @State private var directLevel: Double = 50
    
    let onUpdate: (ModFxParameter) -> Void
    
    var body: some View {
        Section("Octaver Parameters") {
            Picker("Range", selection: $range) {
                ForEach(OctaverRange.allCases, id: \.self) { type in
                    Text("\(type.name)").tag(type)
                }
            }
            .onChange(of: range) { _, newValue in
                onUpdate(.octaver(.range(newValue)))
            }
            ParameterSlider(title: "Level", value: $level, range: 0...100) {
                onUpdate(.octaver(.level(UInt8($0))))
            }
            ParameterSlider(title: "Direct Level", value: $directLevel, range: 0...100) {
                onUpdate(.octaver(.directLevel(UInt8($0))))
            }
        }
    }
}

struct HeavyOctaveView: View {
    @State private var octaveMinus1: Double = 50
    @State private var octaveMinus2: Double = 50
    @State private var directMix: Double = 50
    
    let onUpdate: (ModFxParameter) -> Void
    
    var body: some View {
        Section("Heavy Octave Parameters") {
            ParameterSlider(title: "Octave -1", value: $octaveMinus1, range: 0...100) {
                onUpdate(.heavyOctave(.octaveMinus1(UInt8($0))))
            }
            ParameterSlider(title: "Octave -2", value: $octaveMinus2, range: 0...100) {
                onUpdate(.heavyOctave(.octaveMinus2(UInt8($0))))
            }
            ParameterSlider(title: "Direct Mix", value: $directMix, range: 0...100) {
                onUpdate(.heavyOctave(.directMix(UInt8($0))))
            }
        }
    }
}

struct PitchShifterView: View {
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
    
    let onUpdate: (ModFxParameter) -> Void
    
    var body: some View {
        Section("Pitch Shifter Parameters") {
            Picker("Voice", selection: $voice) {
                ForEach(PitchShifterVoice.allCases, id: \.self) { type in
                    Text("\(type.name)").tag(type)
                }
            }
            .onChange(of: voice) { _, newValue in
                onUpdate(.pitchShifter(.voice(newValue)))
            }
            
            Group {
                Text("PS1")
                Picker("Mode", selection: $ps1Mode) {
                    ForEach(PitchShifterMode.allCases, id: \.self) { type in
                        Text("\(type.name)").tag(type)
                    }
                }
                .onChange(of: ps1Mode) { _, newValue in
                    onUpdate(.pitchShifter(.ps1Mode(newValue)))
                }
                ParameterSlider(title: "Pitch", value: $ps1Pitch, range: 0...100) {
                    onUpdate(.pitchShifter(.ps1Pitch(UInt8($0))))
                }
                ParameterSlider(title: "Fine", value: $ps1Fine, range: 0...100) {
                    onUpdate(.pitchShifter(.ps1Fine(UInt8($0))))
                }
                ParameterSlider(title: "Pre-Delay", value: $ps1PreDelay, range: 0...300) {
                    onUpdate(.pitchShifter(.ps1PreDelay(UInt16($0))))
                }
                ParameterSlider(title: "Level", value: $ps1Level, range: 0...100) {
                    onUpdate(.pitchShifter(.ps1Level(UInt8($0))))
                }
                ParameterSlider(title: "Feedback", value: $ps1Feedback, range: 0...100) {
                    onUpdate(.pitchShifter(.ps1Feedback(UInt8($0))))
                }
            }
            
            if voice == .twoVoice {
                Group {
                    Text("PS2")
                    Picker("Mode", selection: $ps2Mode) {
                        ForEach(PitchShifterMode.allCases, id: \.self) { type in
                            Text("\(type.name)").tag(type)
                        }
                    }
                    .onChange(of: ps2Mode) { _, newValue in
                        onUpdate(.pitchShifter(.ps2Mode(newValue)))
                    }
                    ParameterSlider(title: "Pitch", value: $ps2Pitch, range: 0...100) {
                        onUpdate(.pitchShifter(.ps2Pitch(UInt8($0))))
                    }
                    ParameterSlider(title: "Fine", value: $ps2Fine, range: 0...100) {
                        onUpdate(.pitchShifter(.ps2Fine(UInt8($0))))
                    }
                    ParameterSlider(title: "Pre-Delay", value: $ps2PreDelay, range: 0...300) {
                        onUpdate(.pitchShifter(.ps2PreDelay(UInt16($0))))
                    }
                    ParameterSlider(title: "Level", value: $ps2Level, range: 0...100) {
                        onUpdate(.pitchShifter(.ps2Level(UInt8($0))))
                    }
                }
            }
            
            ParameterSlider(title: "Direct Level", value: $directLevel, range: 0...100) {
                onUpdate(.pitchShifter(.directLevel(UInt8($0))))
            }
        }
    }
}

struct HarmonistView: View {
    @State private var voice = HarmonistVoice.oneVoice
    @State private var h1Harmony: Double = 50
    @State private var h1PreDelay: Double = 0
    @State private var h1Level: Double = 50
    @State private var h2Harmony: Double = 50
    @State private var h2PreDelay: Double = 0
    @State private var h2Level: Double = 50
    @State private var h1Feedback: Double = 0
    @State private var directLevel: Double = 50
    
    let onUpdate: (ModFxParameter) -> Void
    
    var body: some View {
        Section("Harmonist Parameters") {
            Picker("Voice", selection: $voice) {
                ForEach(HarmonistVoice.allCases, id: \.self) { type in
                    Text("\(type.name)").tag(type)
                }
            }
            .onChange(of: voice) { _, newValue in
                onUpdate(.harmonist(.voice(newValue)))
            }
            
            Group {
                Text("H1")
                ParameterSlider(title: "Harmony", value: $h1Harmony, range: 0...100) {
                    onUpdate(.harmonist(.h1Harmony(UInt8($0))))
                }
                ParameterSlider(title: "Pre-Delay", value: $h1PreDelay, range: 0...300) {
                    onUpdate(.harmonist(.h1PreDelay(UInt16($0))))
                }
                ParameterSlider(title: "Level", value: $h1Level, range: 0...100) {
                    onUpdate(.harmonist(.h1Level(UInt8($0))))
                }
                ParameterSlider(title: "Feedback", value: $h1Feedback, range: 0...100) {
                    onUpdate(.harmonist(.h1Feedback(UInt8($0))))
                }
            }
            
            if voice == .twoVoice {
                Group {
                    Text("H2")
                    ParameterSlider(title: "Harmony", value: $h2Harmony, range: 0...100) {
                        onUpdate(.harmonist(.h2Harmony(UInt8($0))))
                    }
                    ParameterSlider(title: "Pre-Delay", value: $h2PreDelay, range: 0...300) {
                        onUpdate(.harmonist(.h2PreDelay(UInt16($0))))
                    }
                    ParameterSlider(title: "Level", value: $h2Level, range: 0...100) {
                        onUpdate(.harmonist(.h2Level(UInt8($0))))
                    }
                }
            }
            
            ParameterSlider(title: "Direct Level", value: $directLevel, range: 0...100) {
                onUpdate(.harmonist(.directLevel(UInt8($0))))
            }
        }
    }
}
