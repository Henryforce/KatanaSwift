# KatanaGoData Documentation

This document provides an overview of the files and objects within the `Sources/KatanaGoData` directory of the KatanaSwift project. This module contains data structures and bank definitions specifically tailored for the Katana:GO device.

## Overview

Similar to the main effects module, `KatanaGoData` defines "Banks" (structs marked with `@KatanaBank` or implementing `KatanaGoBank`) that represent the memory layout for various settings on the Katana:GO, including amplifiers, effects, signal chains, and system settings.

## List of Banks

Below is a list of key `@KatanaBank` objects found in this directory:

| Bank Name | File | Description |
|-----------|------|-------------|
| `AmpBank` | [Amp.swift](Amp.swift) | Main amplifier parameters. |
| `BassAmpBank` | [BassAmp.swift](BassAmp.swift) | Bass-specific amplifier parameters. |
| `BassCompLimBank` | [BassComp.swift](BassComp.swift) | Bass compressor and limiter settings. |
| `BassEnhancerBank` | [BassFx.swift](BassFx.swift) | Bass enhancer effect. |
| `BassSimulatorBank` | [BassFx.swift](BassFx.swift) | Bass guitar simulation. |
| `BassDeFretterBank` | [BassFx.swift](BassFx.swift) | Fretless bass simulation. |
| `BassOctaveBank` | [BassFx.swift](BassFx.swift) | Bass octave effect. |
| `BassTWahBank` | [BassFx.swift](BassFx.swift) | Bass touch-wah effect. |
| `BassSynthBank` | [BassFx.swift](BassFx.swift) | Bass synthesizer parameters. |
| `BassCompressorBank` | [BassFx.swift](BassFx.swift) | Standard bass compressor. |
| `BoostBank` | [Boost.swift](Boost.swift) | Specialized boost effects. |
| `DelayBank` | [Delay.swift](Delay.swift) | Delay effect with channel support. |
| `EQSelectionBank` | [EQ.swift](EQ.swift) | Switch between EQ types. |
| `ParametricEQBank` | [EQ.swift](EQ.swift) | Parametric EQ parameters. |
| `GraphicEQBank` | [EQ.swift](EQ.swift) | Graphic EQ parameters. |
| `GlobalEQBank` | [GlobalEQ.swift](GlobalEQ.swift) | System-wide global EQ. |
| `GlobalEQSwitchBank` | [GlobalEQ.swift](GlobalEQ.swift) | Global EQ toggle. |
| `SignalChainBank` | [SignalChain.swift](SignalChain.swift) | Effect ordering and routing. |
| `SoloBank` | [Solo.swift](Solo.swift) | Solo boost parameters. |
| `SoloSwitchLevelBank` | [Solo.swift](Solo.swift) | Solo toggle and level. |
| `StageFeelBank` | [StageFeel.swift](StageFeel.swift) | Katana:GO Stage Feel settings. |
| `StageFeelCustomBank` | [StageFeel.swift](StageFeel.swift) | Custom Stage Feel user presets. |
| `ModSelectionBank` | [ModFx.swift](ModFx.swift) | MOD block effect selection. |
| `FxSelectionBank` | [ModFx.swift](ModFx.swift) | FX block effect selection. |
| `ModFxBank` | [ModFx.swift](ModFx.swift) | General MOD/FX parameters. |
| `NoiseGateBank` | [NoiseGate.swift](NoiseGate.swift) | Noise suppression settings. |
| `ReverbBank` | [Reverb.swift](Reverb.swift) | Reverb effect parameters. |
| `SignalChainPedalFxBank` | [PedalFx.swift](PedalFx.swift) | Pedal FX (Wah/Pitch) in signal chain. |
| `PedalFxWahBank` | [PedalFx.swift](PedalFx.swift) | Wah pedal parameters. |
| `PedalFxBendBank` | [PedalFx.swift](PedalFx.swift) | Pedal bend (pitch) parameters. |
| `PedalFxWah95Bank` | [PedalFx.swift](PedalFx.swift) | "Wah 95" specific parameters. |
| `ModeBank` | [Mode.swift](Mode.swift) | Katana:GO operating mode. |
| `BatteryBank` | [Battery.swift](Battery.swift) | Device battery status data. |
| `TunerBank` | [Tuner.swift](Tuner.swift) | Chromatic tuner data. |
| `EffectStatusBank` | [EffectStatus.swift](EffectStatus.swift) | On/Off status for all effect blocks. |
| `USBSettingsBank` | [USBSettings.swift](USBSettings.swift) | USB audio and routing settings. |

## Detailed File Content

### [Amp.swift](Amp.swift)
- **Banks**: `AmpBank`
- **Other**: `AmpType` (enum)

### [BassAmp.swift](BassAmp.swift)
- **Banks**: `BassAmpBank`
- **Other**: `BassAmpType` (enum)

### [BassComp.swift](BassComp.swift)
- **Banks**: `BassCompLimBank`
- **Other**: `BassCompLimMode` (enum), `BassCompType` (enum), `BassLimType` (enum)

### [BassFx.swift](BassFx.swift)
- **Banks**: `BassEnhancerBank`, `BassSimulatorBank`, `BassDeFretterBank`, `BassOctaveBank`, `BassTWahBank`, `BassSynthBank`, `BassCompressorBank`
- **Other**: `BassModFXType` (enum), `BassSimType` (enum), `BassLowFrequency` (enum), `BassHighFrequency` (enum)

### [Battery.swift](Battery.swift)
- **Banks**: `BatteryBank`

### [Boost.swift](Boost.swift)
- **Banks**: `BoostBank`
- **Other**: `BoostType` (enum), `BassBoostType` (enum)

### [Contour.swift](Contour.swift)
- **Banks**: `ContourBank`
- **Other**: `ContourType` (enum)

### [Delay.swift](Delay.swift)
- **Banks**: `DelayBank`
- **Other**: `DelayBankChannel` (enum), `DelayType` (enum), `DelayHighCutFrequency` (enum), `DelayFilterRange` (enum), `DelayPhase` (enum)

### [EQ.swift](EQ.swift)
- **Banks**: `EQSelectionBank`, `ParametricEQBank`, `GraphicEQBank`
- **Other**: `EQBankChannel` (enum)

### [EffectStatus.swift](EffectStatus.swift)
- **Banks**: `EffectStatusBank`

### [GlobalEQ.swift](GlobalEQ.swift)
- **Banks**: `GlobalEQSwitchBank`, `GlobalEQBank`

### [ModFx.swift](ModFx.swift)
- **Banks**: `ModSelectionBank`, `FxSelectionBank`, `ModFxBank`
- **Other**: `ModFxType` (enum)

### [Mode.swift](Mode.swift)
- **Banks**: `ModeBank`
- **Other**: `KatanaGoMode` (enum)

### [NoiseGate.swift](NoiseGate.swift)
- **Banks**: `NoiseGateBank`

### [PedalFx.swift](PedalFx.swift)
- **Banks**: `SignalChainPedalFxBank`, `PedalFxWahBank`, `PedalFxBendBank`, `PedalFxWah95Bank`
- **Other**: `PedalFxBanks` (struct), `PedalFxType` (enum), `PedalFxWahType` (enum)

### [Preset.swift](Preset.swift)
- **Other**: `Preset` (enum)

### [Reverb.swift](Reverb.swift)
- **Banks**: `ReverbBank`
- **Other**: `ReverbType` (enum)

### [SignalChain.swift](SignalChain.swift)
- **Banks**: `SignalChainBank`
- **Other**: `PatchKey` (enum), `Chain` (enum), `CabinetResonance` (enum)

### [Solo.swift](Solo.swift)
- **Banks**: `SoloSwitchLevelBank`, `SoloBank`

### [StageFeel.swift](StageFeel.swift)
- **Banks**: `StageFeelBank`, `StageFeelCustomBank`
- **Other**: `StageFeelSelect` (enum), `AmbienceType` (enum)

### [Tuner.swift](Tuner.swift)
- **Banks**: `TunerBank`

### [USBSettings.swift](USBSettings.swift)
- **Banks**: `USBSettingsBank`
