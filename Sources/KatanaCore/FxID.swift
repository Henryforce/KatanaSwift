public enum FxID: Sendable, Hashable, CaseIterable {
  // MARK - ACSim
  case acSimHigh
  case acSimBody
  case acSimLow
  case acSimLevel

  // MARK - AcousticPro
  case acousticProType
  case acousticProBass
  case acousticProMiddle
  case acousticProMidFrequency
  case acousticProTreble
  case acousticProPresence
  case acousticProLevel

  // MARK - AutoWah
  case autoWahMode
  case autoWahFrequency
  case autoWahPeak
  case autoWahRate
  case autoWahDepth
  case autoWahEffectLevel
  case autoWahDirectLevel

  // MARK - Chorus
  case chorusCrossoverFrequency
  case chorusLowRate
  case chorusLowDepth
  case chorusLowPreDelay
  case chorusLowLevel
  case chorusHighRate
  case chorusHighDepth
  case chorusHighPreDelay
  case chorusHighLevel
  case chorusDirectMix

  // MARK - Comp
  case compType
  case compSustain
  case compAttack
  case compTone
  case compLevel

  // MARK - DC30
  case dc30Type
  case dc30InputVolume
  case dc30ChorusIntensity
  case dc30RepeatTime
  case dc30EchoIntensity
  case dc30Volume
  case dc30Tone
  case dc30OutputType

  // MARK - Flanger
  case flangerRate
  case flangerDepth
  case flangerManual
  case flangerResonance
  case flangerLowCut
  case flangerEffectLevel
  case flangerDirectLevel

  // MARK - Flanger117E
  case flanger117EManual
  case flanger117EWidth
  case flanger117ESpeed
  case flanger117ERegen

  // MARK - GuitarSim
  case guitarSimType
  case guitarSimLow
  case guitarSimHigh
  case guitarSimBody
  case guitarSimLevel

  // MARK - Harmonist
  case harmonistVoice
  case harmonistH1Harmony
  case harmonistH1PreDelay
  case harmonistH1Level
  case harmonistH2Harmony
  case harmonistH2PreDelay
  case harmonistH2Level
  case harmonistH1Feedback
  case harmonistDirectLevel

  // MARK - HeavyOctave
  case heavyOctaveOctaveMinus1
  case heavyOctaveOctaveMinus2
  case heavyOctaveDirectMix

  // MARK - Humanizer
  case humanizerMode
  case humanizerVowel1
  case humanizerVowel2
  case humanizerSens
  case humanizerRate
  case humanizerDepth
  case humanizerManual
  case humanizerLevel

  // MARK - Limiter
  case limiterType
  case limiterAttack
  case limiterThreshold
  case limiterRatio
  case limiterRelease
  case limiterLevel

  // MARK - ModFxGraphicEQ
  case modFxGraphicEQBand31Hz
  case modFxGraphicEQBand62Hz
  case modFxGraphicEQBand125Hz
  case modFxGraphicEQBand250Hz
  case modFxGraphicEQBand500Hz
  case modFxGraphicEQBand1kHz
  case modFxGraphicEQBand2kHz
  case modFxGraphicEQBand4kHz
  case modFxGraphicEQBand8kHz
  case modFxGraphicEQBand16kHz
  case modFxGraphicEQLevel

  // MARK - ModFxParametricEQ
  case modFxParametricEQLowCut
  case modFxParametricEQLowGain
  case modFxParametricEQLowMidFreq
  case modFxParametricEQLowMidQ
  case modFxParametricEQLowMidGain
  case modFxParametricEQHighMidFreq
  case modFxParametricEQHighMidQ
  case modFxParametricEQHighMidGain
  case modFxParametricEQHighGain
  case modFxParametricEQHighCut
  case modFxParametricEQLevel

  // MARK - EQ
  case eqStatus
  case eqPosition
  case eqType

  // MARK - ParametricEQ
  case parametricEQLowCut
  case parametricEQLowGain
  case parametricEQLowMidFreq
  case parametricEQLowMidQ
  case parametricEQLowMidGain
  case parametricEQHighMidFreq
  case parametricEQHighMidQ
  case parametricEQHighMidGain
  case parametricEQHighGain
  case parametricEQHighCut
  case parametricEQLevel

  // MARK - GraphicEQ
  case graphicEQBand31Hz
  case graphicEQBand62Hz
  case graphicEQBand125Hz
  case graphicEQBand250Hz
  case graphicEQBand500Hz
  case graphicEQBand1kHz
  case graphicEQBand2kHz
  case graphicEQBand4kHz
  case graphicEQBand8kHz
  case graphicEQBand16kHz
  case graphicEQLevel

  // MARK - Octaver
  case octaverRange
  case octaverLevel
  case octaverDirectLevel

  // MARK - Phaser
  case phaserType
  case phaserRate
  case phaserDepth
  case phaserManual
  case phaserResonance
  case phaserStepRate
  case phaserEffectLevel
  case phaserDirectLevel

  // MARK - Phaser90E
  case phaser90EScriptStatus
  case phaser90ESpeed

  // MARK - PitchShifter
  case pitchShifterVoice
  case pitchShifterPs1Mode
  case pitchShifterPs1Pitch
  case pitchShifterPs1Fine
  case pitchShifterPs1PreDelay
  case pitchShifterPs1Level
  case pitchShifterPs2Mode
  case pitchShifterPs2Pitch
  case pitchShifterPs2Fine
  case pitchShifterPs2PreDelay
  case pitchShifterPs2Level
  case pitchShifterPs1Feedback
  case pitchShifterDirectLevel

  // MARK - RingMod
  case ringModMode
  case ringModFrequency
  case ringModEffectLevel
  case ringModDirectMix

  // MARK - Rotary
  case rotaryRate
  case rotaryDepth
  case rotaryLevel

  // MARK - Slicer
  case slicerPattern
  case slicerRate
  case slicerTriggerSens
  case slicerEffectLevel
  case slicerDirectMix

  // MARK - SlowGear
  case slowGearSens
  case slowGearRiseTime
  case slowGearLevel

  // MARK - TWah
  case tWahMode
  case tWahPolarity
  case tWahSens
  case tWahFrequency
  case tWahPeak
  case tWahEffectLevel
  case tWahDirectLevel

  // MARK - Tremolo
  case tremoloWaveShape
  case tremoloRate
  case tremoloDepth
  case tremoloLevel

  // MARK - Univibe
  case univibeRate
  case univibeDepth
  case univibeLevel

  // MARK - Vibrato
  case vibratoRate
  case vibratoDepth
  case vibratoLevel

  // MARK - WaveSynth
  case waveSynthType
  case waveSynthCutoff
  case waveSynthResonance
  case waveSynthFilterSens
  case waveSynthFilterDecay
  case waveSynthFilterDepth
  case waveSynthSynthLevel
  case waveSynthDirectMix
}
