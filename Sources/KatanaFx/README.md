# KatanaFx Documentation

This document provides an overview of the files and objects within the `Sources/KatanaFx` directory of the KatanaSwift project. This module contains the definitions for various guitar effects and their parameter structures.

## Overview

The effects in this directory are structured around "Banks" (structs marked with `@KatanaBank`). A bank defines the memory layout and parameter mapping for a specific effect, used for communication with the BOSS Katana amplifier. Supporting enums and other types are often defined alongside these banks.

Note that the effects listed here are not specific to any particular Katana model. Rather, only the parameter addresses are specific to each effect. Due to this setup, the effects in this directory still need to conform to different Katana models' specific parameter addresses. For example, the `KatanaGoBank` protocol requires a `katanaGoAddress` property, which is specific to each Katana model.

## List of Banks

Below is a comprehensive list of all `@KatanaBank` objects found in this directory:

| Bank Name | File | Description |
|-----------|------|-------------|
| `ACSimBank` | [ACSim.swift](ACSim.swift) | Acoustic simulation parameters. |
| `AcousticProBank` | [AcousticPro.swift](AcousticPro.swift) | Acoustic professor simulation. |
| `ChorusBank` | [Chorus.swift](Chorus.swift) | Standard chorus parameters. |
| `DC30Bank` | [Chorus.swift](Chorus.swift) | Roland DC-30 Chorus-Echo emulation. |
| `CompBank` | [Comp.swift](Comp.swift) | Compression effect parameters. |
| `FlangerBank` | [Flanger.swift](Flanger.swift) | Standard flanger parameters. |
| `Flanger117EBank` | [Flanger.swift](Flanger.swift) | MXR M117R Flanger emulation. |
| `GuitarSimBank` | [GuitarSim.swift](GuitarSim.swift) | Guitar simulation (transforms tone). |
| `HarmonistBank` | [Harmonist.swift](Harmonist.swift) | Pitch-based harmony effect. |
| `HumanizerBank` | [Humanizer.swift](Humanizer.swift) | Vowel-like filter effect. |
| `LimiterBank` | [Limiter.swift](Limiter.swift) | Sound level limiter. |
| `ModFxGraphicEQBank` | [ModFxGraphicEQ.swift](ModFxGraphicEQ.swift) | Graphic equalizer within MOD/FX block. |
| `ModFxParametricEQBank` | [ModFxParametricEQ.swift](ModFxParametricEQ.swift) | Parametric equalizer within MOD/FX block. |
| `OctaverBank` | [Octaver.swift](Octaver.swift) | Traditional octave effect. |
| `HeavyOctaveBank` | [Octaver.swift](Octaver.swift) | Heavy/Sub-octave effect. |
| `PhaserBank` | [Phaser.swift](Phaser.swift) | Traditional phaser effect. |
| `Phaser90EBank` | [Phaser.swift](Phaser.swift) | Script Phase 90 emulation. |
| `PitchShifterBank` | [PitchShifter.swift](PitchShifter.swift) | Pitch shifting parameters. |
| `RingModBank` | [RingMod.swift](RingMod.swift) | Ring modulation effect. |
| `RotaryBank` | [Rotary.swift](Rotary.swift) | Rotary speaker simulation. |
| `SlicerBank` | [Slicer.swift](Slicer.swift) | Pattern-based volume chopper. |
| `SlowGearBank` | [SlowGear.swift](SlowGear.swift) | Note attack softener. |
| `TremoloBank` | [Tremolo.swift](Tremolo.swift) | Volume modulation effect. |
| `UniVibeBank` | [UniVibe.swift](UniVibe.swift) | Classic psychedelic vibe effect. |
| `VibratoBank` | [Vibrato.swift](Vibrato.swift) | Pitch modulation effect. |
| `TWahBank` | [Wah.swift](Wah.swift) | Touch/T-Wah effect. |
| `AutoWahBank` | [Wah.swift](Wah.swift) | LFO-driven auto wah. |
| `WaveSynthBank` | [WaveSynth.swift](WaveSynth.swift) | Monophonic guitar synth. |

## Detailed File Content

### [ACSim.swift](ACSim.swift)
- **Banks**: `ACSimBank`

### [AcousticPro.swift](AcousticPro.swift)
- **Banks**: `AcousticProBank`
- **Other**: `AcousticProType` (enum)

### [Chorus.swift](Chorus.swift)
- **Banks**: `ChorusBank`, `DC30Bank`
- **Other**: `ChorusCrossoverFrequency` (enum), `DC30Type` (enum), `DC30OutputType` (enum)

### [Comp.swift](Comp.swift)
- **Banks**: `CompBank`
- **Other**: `CompType` (enum)

### [Flanger.swift](Flanger.swift)
- **Banks**: `FlangerBank`, `Flanger117EBank`
- **Other**: `FlangerLowCut` (enum)

### [GuitarSim.swift](GuitarSim.swift)
- **Banks**: `GuitarSimBank`
- **Other**: `GuitarSimType` (enum)

### [Harmonist.swift](Harmonist.swift)
- **Banks**: `HarmonistBank`
- **Other**: `HarmonistVoice` (enum), `HarmonistHarmony` (enum)

### [Humanizer.swift](Humanizer.swift)
- **Banks**: `HumanizerBank`
- **Other**: `HumanizerMode` (enum), `HumanizerWovel` (enum)

### [Limiter.swift](Limiter.swift)
- **Banks**: `LimiterBank`
- **Other**: `LimiterType` (enum), `LimiterRatio` (enum)

### [ModFxGraphicEQ.swift](ModFxGraphicEQ.swift)
- **Banks**: `ModFxGraphicEQBank`

### [ModFxParametricEQ.swift](ModFxParametricEQ.swift)
- **Banks**: `ModFxParametricEQBank`

### [Octaver.swift](Octaver.swift)
- **Banks**: `OctaverBank`, `HeavyOctaveBank`
- **Other**: `OctaverRange` (enum), `HeavyOctaveParameter` (enum)

### [Phaser.swift](Phaser.swift)
- **Banks**: `PhaserBank`, `Phaser90EBank`
- **Other**: `PhaserType` (enum), `Phaser90EParameter` (enum)

### [PitchShifter.swift](PitchShifter.swift)
- **Banks**: `PitchShifterBank`
- **Other**: `PitchShifterVoice` (enum), `PitchShifterMode` (enum)

### [RingMod.swift](RingMod.swift)
- **Banks**: `RingModBank`
- **Other**: `RingModMode` (enum)

### [Rotary.swift](Rotary.swift)
- **Banks**: `RotaryBank`

### [Slicer.swift](Slicer.swift)
- **Banks**: `SlicerBank`

### [SlowGear.swift](SlowGear.swift)
- **Banks**: `SlowGearBank`

### [Tremolo.swift](Tremolo.swift)
- **Banks**: `TremoloBank`

### [UniVibe.swift](UniVibe.swift)
- **Banks**: `UniVibeBank`

### [Vibrato.swift](Vibrato.swift)
- **Banks**: `VibratoBank`

### [Wah.swift](Wah.swift)
- **Banks**: `TWahBank`, `AutoWahBank`
- **Other**: `WahMode` (enum), `TWahPolarity` (enum)

### [WaveSynth.swift](WaveSynth.swift)
- **Banks**: `WaveSynthBank`
- **Other**: `WaveSynthType` (enum)
