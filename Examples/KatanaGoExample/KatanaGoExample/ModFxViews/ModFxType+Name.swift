import KatanaGoData

extension ModFxType {
    var name: String {
        switch self {
        case .twoByTwoChorus: return "2x2 Chorus"
        case .flanger: return "Flanger"
        case .phaser: return "Phaser"
        case .uniV: return "Uni-Vibe"
        case .tremolo: return "Tremolo"
        case .vibrato: return "Vibrato"
        case .rotary: return "Rotary"
        case .ringMod: return "Ring Mod"
        case .slowGear: return "Slow Gear"
        case .slicer: return "Slicer"
        case .comp: return "Compressor"
        case .limiter: return "Limiter"
        case .tWah: return "T-Wah"
        case .autoWah: return "Auto Wah"
        case .graphicEQ: return "Graphic EQ"
        case .parametricEQ: return "Parametric EQ"
        case .guitarSim: return "Guitar Sim"
        case .acSim: return "AC Sim"
        case .acousticPro: return "Acoustic Pro"
        case .waveSynth: return "Wave Synth"
        case .octave: return "Octave"
        case .heavyOctave: return "Heavy Octave"
        case .pitchShifter: return "Pitch Shifter"
        case .harmonist: return "Harmonist"
        case .humanizer: return "Humanizer"
        case .phaser90E: return "Phaser 90E"
        case .flanger117E: return "Flanger 117E"
        case .dc30: return "DC-30"
        }
    }
}

extension FlangerLowCut {
    var name: String {
        switch self {
        case .flat: return "Flat"
        case .freq55Hz: return "55 Hz"
        case .freq110Hz: return "110 Hz"
        case .freq165Hz: return "165 Hz"
        case .freq200Hz: return "200 Hz"
        case .freq280Hz: return "280 Hz"
        case .freq340Hz: return "340 Hz"
        case .freq400Hz: return "400 Hz"
        case .freq500Hz: return "500 Hz"
        case .freq630Hz: return "630 Hz"
        case .freq800Hz: return "800 Hz"
        }
    }
}

extension PhaserType {
    var name: String {
        switch self {
        case .fourStage: return "4 Stage"
        case .eightStage: return "8 Stage"
        case .twelveStage: return "12 Stage"
        case .biStage: return "Bi-Phase"
        }
    }
}

extension RingModMode {
    var name: String {
        switch self {
        case .normal: return "Normal"
        case .intelligent: return "Intelligent"
        }
    }
}

extension CompType {
    var name: String {
        switch self {
        case .boss: return "BOSS"
        case .hiBand: return "Hi-Band"
        case .light: return "Light"
        case .dComp: return "D-Comp"
        case .orange: return "Orange"
        case .fat: return "Fat"
        case .mild: return "Mild"
        }
    }
}

extension LimiterType {
    var name: String {
        switch self {
        case .boss: return "BOSS"
        case .rack160D: return "Rack 160D"
        case .vtgRackU: return "Vtg Rack U"
        }
    }
}

extension LimiterRatio {
    var name: String {
        switch self {
        case .oneToOne: return "1:1"
        case .oneDotTwoToOne: return "1.2:1"
        case .oneDotFourToOne: return "1.4:1"
        case .oneDotSixToOne: return "1.6:1"
        case .oneDotEightToOne: return "1.8:1"
        case .twoToOne: return "2:1"
        case .twoDotThreeToOne: return "2.3:1"
        case .twoDotSixToOne: return "2.6:1"
        case .threeToOne: return "3:1"
        case .threeDotFiveToOne: return "3.5:1"
        case .fourToOne: return "4:1"
        case .fiveToOne: return "5:1"
        case .sixToOne: return "6:1"
        case .eightToOne: return "8:1"
        case .tenToOne: return "10:1"
        case .twelveToOne: return "12:1"
        case .twentyToOne: return "20:1"
        case .infiniteToOne: return "Inf:1"
        }
    }
}

extension WahMode {
    var name: String {
        switch self {
        case .lowPassFilter: return "LPF"
        case .highPassFilter: return "HPF"
        }
    }
}

extension TWahPolarity {
    var name: String {
        switch self {
        case .down: return "Down"
        case .up: return "Up"
        }
    }
}

extension EQLowCut {
    var name: String {
        switch self {
        case .flat: return "Flat"
        case .freq20Hz: return "20 Hz"
        case .freq25Hz: return "25 Hz"
        case .freq31Hz5: return "31.5 Hz"
        case .freq40Hz: return "40 Hz"
        case .freq50Hz: return "50 Hz"
        case .freq63Hz: return "63 Hz"
        case .freq80Hz: return "80 Hz"
        case .freq100Hz: return "100 Hz"
        case .freq125Hz: return "125 Hz"
        case .freq160Hz: return "160 Hz"
        case .freq200Hz: return "200 Hz"
        case .freq250Hz: return "250 Hz"
        case .freq315Hz: return "315 Hz"
        case .freq400Hz: return "400 Hz"
        case .freq500Hz: return "500 Hz"
        case .freq630Hz: return "630 Hz"
        case .freq800Hz: return "800 Hz"
        }
    }
}

extension EQHighCut {
    var name: String {
        switch self {
        case .freq630Hz: return "630 Hz"
        case .freq800Hz: return "800 Hz"
        case .freq1kHz: return "1 kHz"
        case .freq1k25Hz: return "1.25 kHz"
        case .freq1k6Hz: return "1.6 kHz"
        case .freq2kHz: return "2 kHz"
        case .freq2k5Hz: return "2.5 kHz"
        case .freq3k15Hz: return "3.15 kHz"
        case .freq4kHz: return "4 kHz"
        case .freq5kHz: return "5 kHz"
        case .freq6k3Hz: return "6.3 kHz"
        case .freq8kHz: return "8 kHz"
        case .freq10kHz: return "10 kHz"
        case .freq12k5Hz: return "12.5 kHz"
        case .flat: return "Flat"
        }
    }
}

extension EQFrequency {
    var name: String {
        switch self {
        case .freq20Hz: return "20 Hz"
        case .freq25Hz: return "25 Hz"
        case .freq31Hz5: return "31.5 Hz"
        case .freq40Hz: return "40 Hz"
        case .freq50Hz: return "50 Hz"
        case .freq63Hz: return "63 Hz"
        case .freq80Hz: return "80 Hz"
        case .freq100Hz: return "100 Hz"
        case .freq125Hz: return "125 Hz"
        case .freq160Hz: return "160 Hz"
        case .freq200Hz: return "200 Hz"
        case .freq250Hz: return "250 Hz"
        case .freq315Hz: return "315 Hz"
        case .freq400Hz: return "400 Hz"
        case .freq500Hz: return "500 Hz"
        case .freq630Hz: return "630 Hz"
        case .freq800Hz: return "800 Hz"
        case .freq1kHz: return "1 kHz"
        case .freq1k25Hz: return "1.25 kHz"
        case .freq1k6Hz: return "1.6 kHz"
        case .freq2kHz: return "2 kHz"
        case .freq2k5Hz: return "2.5 kHz"
        case .freq3k15Hz: return "3.15 kHz"
        case .freq4kHz: return "4 kHz"
        case .freq5kHz: return "5 kHz"
        case .freq6k3Hz: return "6.3 kHz"
        case .freq8kHz: return "8 kHz"
        case .freq10kHz: return "10 kHz"
        }
    }
}

extension EQQ {
    var name: String {
        switch self {
        case .q05: return "0.5"
        case .q1: return "1.0"
        case .q2: return "2.0"
        case .q4: return "4.0"
        case .q8: return "8.0"
        case .q16: return "16.0"
        }
    }
}

extension GuitarSimType {
    var name: String {
        switch self {
        case .sToH: return "S->H"
        case .hToS: return "H->S"
        case .hToHF: return "H->HF"
        case .sToHollow: return "S->Hollow"
        case .hToHollow: return "H->Hollow"
        case .sToAc: return "S->AC"
        case .hToAc: return "H->AC"
        case .pToAc: return "P->AC"
        }
    }
}

extension AcousticProType {
    var name: String {
        switch self {
        case .small: return "Small"
        case .medium: return "Medium"
        case .bright: return "Bright"
        case .power: return "Power"
        }
    }
}

extension WaveSynthType {
    var name: String {
        switch self {
        case .saw: return "Saw"
        case .square: return "Square"
        }
    }
}

extension OctaverRange {
    var name: String {
        switch self {
        case .range1: return "Range 1"
        case .range2: return "Range 2"
        case .range3: return "Range 3"
        case .range4: return "Range 4"
        }
    }
}

extension PitchShifterVoice {
    var name: String {
        switch self {
        case .oneVoice: return "1 Voice"
        case .twoVoice: return "2 Voice"
        }
    }
}

extension PitchShifterMode {
    var name: String {
        switch self {
        case .fast: return "Fast"
        case .medium: return "Medium"
        case .slow: return "Slow"
        case .mono: return "Mono"
        }
    }
}

extension HarmonistVoice {
    var name: String {
        switch self {
        case .oneVoice: return "1 Voice"
        case .twoVoice: return "2 Voice"
        }
    }
}

extension HumanizerMode {
    var name: String {
        switch self {
        case .picking: return "Picking"
        case .auto: return "Auto"
        }
    }
}

extension HumanizerWovel {
    var name: String {
        switch self {
        case .a: return "A"
        case .e: return "E"
        case .i: return "I"
        case .o: return "O"
        case .u: return "U"
        }
    }
}

extension DC30Type {
    var name: String {
        switch self {
        case .chorus: return "Chorus"
        case .echo: return "Echo"
        }
    }
}

extension DC30OutputType {
    var name: String {
        switch self {
        case .dPlusE: return "D+E"
        case .dOverE: return "D/E"
        }
    }
}
