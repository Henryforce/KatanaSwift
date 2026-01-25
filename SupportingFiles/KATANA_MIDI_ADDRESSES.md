# KATANA MIDI ADDRESSES

The following addresses are for the Katana GO and the address column is in hexadecimal string representation (20003000 is equivalent to a byte array of [0x20, 0x00, 0x30, 0x00]).

| Name | Address (Desc) | Max value | Value type |
| :--- | :--- | :--- | :--- |
| BOOSTER: On/Off | 20003000 | 1 | Boolean |
| BOOSTER: Type | 20004000 | 21 | BOOSTER_TYPE (UInt8) |
| BOOSTER: Drive | 20004001 | 100 | UInt8 |
| BOOSTER: Bottom Level | 20004002 | 100 | UInt8 |
| BOOSTER: Tone | 20004003 | 100 | UInt8 |
| BOOSTER: SOLO SW | 20004004 | 1 | Boolean |
| BOOSTER: SOLO Level | 20004005 | 100 | UInt8 |
| BOOSTER: Effect Level | 20004006 | 100 | UInt8 |
| BOOSTER: Direct Mix | 20004007 | 100 | UInt8 |
| PREAMP: Gain | 20002000 | 100 | UInt8 |
| PREAMP: Volume | 20002001 | 100 | UInt8 |
| PREAMP BASS: Tone Shape | 20002002 | 100 | PREAMP_BASS_SHAPE (UInt8) |
| PREAMP: Bass | 20002003 | 100 | UInt8 |
| PREAMP: Middle | 20002004 | 100 | UInt8 |
| PREAMP: Treble | 20002005 | 100 | UInt8 |
| PREAMP BASS: Low Mid Gain | 20002006 | 100 | UInt8 |
| PREAMP BAS: Low Mid Freq | 20002007 | 27 | EQ_MID_FREQ (UInt8) |
| PREAMP BASS: Hi Mid Gain | 20002008 | 100 | UInt8 |
| PREAMP BASS: Hi Mid Freq | 20002009 | 27 | EQ_MID_FREQ (UInt8) |
| PREAMP: Presence | 2000200A | 100 | UInt8 |
| POWERAMP: Variation | 2000200B | 1 | POWERAMP_VARIATION (UInt8) |
| PREAMP: Type | 2000200C | 4 | PREAMP_TYPE (UInt8) |
| PREAMP Guitar: Variation | 2000200D | 1 | Boolean |
| SOLO: Solo Sw | 20015000 | 1 | Boolean |
| SOLO: Solo Level | 20015001 | 100 | UInt8 |
| SOLO EQ: Position | 20016000 | 1 | EQ_POSITION (UInt8) |
| SOLO EQ: Off/On | 20016001 | 1 | Boolean |
| SOLO EQ: Low Cut | 20016002 | 17 | EQ_LOW_CUT (UInt8) |
| SOLO EQ: Low Gain | 20016003 | 24 | UInt8 |
| SOLO EQ: Mid Freq | 20016004 | 27 | EQ_MID_FREQ (UInt8) |
| SOLO EQ: Mid Q | 20016005 | 5 | EQ_MID_Q (UInt8) |
| SOLO EQ: Mid Gain | 20016006 | 24 | UInt8 |
| SOLO EQ: Hi Gain | 20016007 | 24 | UInt8 |
| SOLO EQ: Hi Cut | 20016008 | 14 | EQ_HI_CUT (UInt8) |
| SOLO EQ: Level | 20016009 | 24 | UInt8 |
| EQ1: Signal chain position | 20026000 | 1 | EQPosition |
| EQ1: On/Off | 20026001 | 1 | Boolean |
| EQ1: Selection | 20026002 | 1 | EQ_TYPE (UInt8) |
| PEQ1: Low Cut | 20030000 | 17 | EQ_LOW_CUT (UInt8) |
| PEQ1: Low Gain | 20030001 | 40 | UInt8 |
| PEQ1: Lo Mid Freq | 20030002 | 27 | EQ_MID_FREQ (UInt8) |
| PEQ1: Lo Mid Q  | 20030003 | 5 | EQ_MID_Q (UInt8) |
| PEQ1: Lo Mid Gain | 20030004 | 40 | UInt8 |
| PEQ1: Hi Mid Freq | 20030005 | 27 | EQ_MID_FREQ (UInt8) |
| PEQ1: Hi Mid Q | 20030006 | 5 | EQ_MID_Q (UInt8) |
| PEQ1: Hi Mid Gain | 20030007 | 40 | UInt8 |
| PEQ1: Hi Gain | 20030008 | 40 | UInt8 |
| PEQ1: Hi Cut | 20030009 | 14 | EQ_HI_CUT (UInt8) |
| PEQ1: Level | 2003000A | 40 | UInt8 |
| GEQ1: 31Hz | 20032000 | 48 | UInt8 |
| GEQ1: 62Hz | 20032001 | 48 | UInt8 |
| GEQ1: 125Hz | 20032002 | 48 | UInt8 |
| GEQ1: 250Hz | 20032003 | 48 | UInt8 |
| GEQ1: 500Hz | 20032004 | 48 | UInt8 |
| GEQ1: 1KHz | 20032005 | 48 | UInt8 |
| GEQ1: 2KHz | 20032006 | 48 | UInt8 |
| GEQ1: 4KHz | 20032007 | 48 | UInt8 |
| GEQ1: 8KHz | 20032008 | 48 | UInt8 |
| GEQ1: 16KHz | 20032009 | 48 | UInt8 |
| GEQ1: Level | 2003200A | 48 | UInt8 |
| EQ2: Signal chain position | 20027000 | 1 | EQPosition |
| EQ2: On/Off | 20027001 | 1 | Boolean |
| EQ2: Selection | 20027002 | 1 | EQ_TYPE (UInt8) |
| PEQ2: Low Cut | 20031000 | 17 | EQ_LOW_CUT (UInt8) |
| PEQ2: Low Gain | 20031001 | 40 | UInt8 |
| PEQ2: Lo Mid Freq | 20031002 | 27 | EQ_MID_FREQ (UInt8) |
| PEQ2: Lo Mid Q  | 20031003 | 5 | EQ_MID_Q (UInt8) |
| PEQ2: Lo Mid Gain | 20031004 | 40 | UInt8 |
| PEQ2: Hi Mid Freq | 20031005 | 27 | EQ_MID_FREQ (UInt8) |
| PEQ2: Hi Mid Q | 20031006 | 5 | EQ_MID_Q (UInt8) |
| PEQ2: Hi Mid Gain | 20031007 | 40 | UInt8 |
| PEQ2: Hi Gain | 20031008 | 40 | UInt8 |
| PEQ2: Hi Cut | 20031009 | 14 | EQ_HI_CUT (UInt8) |
| PEQ2: Level | 2003100A | 40 | UInt8 |
| GEQ2: 31Hz | 20033000 | 48 | UInt8 |
| GEQ2: 62Hz | 20033001 | 48 | UInt8 |
| GEQ2: 125Hz | 20033002 | 48 | UInt8 |
| GEQ2: 250Hz | 20033003 | 48 | UInt8 |
| GEQ2: 500Hz | 20033004 | 48 | UInt8 |
| GEQ2: 1KHz | 20033005 | 48 | UInt8 |
| GEQ2: 2KHz | 20033006 | 48 | UInt8 |
| GEQ2: 4KHz | 20033007 | 48 | UInt8 |
| GEQ2: 8KHz | 20033008 | 48 | UInt8 |
| GEQ2: 16KHz | 20033009 | 48 | UInt8 |
| GEQ2: Level | 2003300A | 48 | UInt8 |
| MOD: Off/On | 20003001 | 1 | Boolean |
| MOD: Type | 20006000 | 30 | MODFX_TYPE (UInt8) |
| MOD: 2X2-Chorus Crossover f | 20010000 | 100 | UInt8 |
| MOD: 2X2-Chorus Low Rate | 20010001 | 100 | UInt8 |
| MOD: 2X2-Chorus Low Depth | 20010002 | 100 | UInt8 |
| MOD: 2X2-Chorus Low Pre Delay | 20010003 | 80 | UInt8 |
| MOD: 2X2-Chorus Low Level | 20010004 | 100 | UInt8 |
| MOD: 2X2-Chorus High Rate | 20010005 | 100 | UInt8 |
| MOD: 2X2-Chorus High Depth | 20010006 | 100 | UInt8 |
| MOD: 2X2-Chorus High Pre Delay | 20010007 | 80 | UInt8 |
| MOD: 2X2-Chorus High Level | 20010008 | 100 | UInt8 |
| MOD: 2X2-Chorus Direct Mix | 20010009 | 100 | UInt8 |
| MOD: Flanger Rate | 2001000A | 100 | UInt8 |
| MOD: Flanger Depth | 2001000B | 100 | UInt8 |
| MOD: Flanger Manual | 2001000C | 100 | UInt8 |
| MOD: Flanger Resonance | 2001000D | 100 | UInt8 |
| MOD: Flanger Low Cut | 2001000E | 10 | FLANGER_LOW_CUT (UInt8) |
| MOD: Flanger Effect Level | 2001000F | 100 | UInt8 |
| MOD: Flanger Direct Level | 20010010 | 100 | UInt8 |
| MOD: Phaser Type | 20010011 | 3 | PHASER_TYPE (UInt8) |
| MOD: Phaser Rate | 20010012 | 100 | UInt8 |
| MOD: Phaser Depth | 20010013 | 100 | UInt8 |
| MOD: Phaser Manual | 20010014 | 100 | UInt8 |
| MOD: Phaser Resonance | 20010015 | 100 | UInt8 |
| MOD: Phaser Step Rate | 20010016 | 100 | UInt8 |
| MOD: Phaser Effect Level | 20010017 | 100 | UInt8 |
| MOD: Phaser Direct Level | 20010018 | 100 | UInt8 |
| MOD: Uni-Vibe Rate | 20010019 | 100 | UInt8 |
| MOD: Uni-Vibe Depth | 2001001A | 100 | UInt8 |
| MOD: Uni-Vibe Level | 2001001B | 100 | UInt8 |
| MOD: Tremolo Wave Shape | 2001001C | 100 | UInt8 |
| MOD: Tremolo Rate | 2001001D | 100 | UInt8 |
| MOD: Tremolo Depth | 2001001E | 100 | UInt8 |
| MOD: Tremolo Level | 2001001F | 100 | UInt8 |
| MOD: Vibrato Rate | 20010020 | 100 | UInt8 |
| MOD: Vibrato Depth | 20010021 | 100 | UInt8 |
| MOD: Vibrato Level | 20010022 | 100 | UInt8 |
| MOD: Rotary Rate | 20010023 | 100 | UInt8 |
| MOD: Rotary Depth | 20010024 | 100 | UInt8 |
| MOD: Rotary Level | 20010025 | 100 | UInt8 |
| MOD: Ring-Mod Mode | 20010026 | 1 | RING_MOD_MODE (UInt8) |
| MOD: Ring-Mod Frequency | 20010027 | 100 | UInt8 |
| MOD: Ring-Mod Effect Level | 20010028 | 100 | UInt8 |
| MOD: Ring-Mod Direct Mix | 20010029 | 100 | UInt8 |
| MOD: Slow-Gear Sens | 2001002A | 100 | UInt8 |
| MOD: Slow-Gear RiseTime | 2001002B | 100 | UInt8 |
| MOD: Slow-Gear Level | 2001002C | 100 | UInt8 |
| MOD: Slicer Pattern | 2001002D | 19 | UInt8 |
| MOD: Slicer Rate | 2001002E | 100 | UInt8 |
| MOD: Slicer Trigger Sens | 2001002F | 100 | UInt8 |
| MOD: Slicer Effect Level | 20010030 | 100 | UInt8 |
| MOD: Slicer Direct Mix | 20010031 | 100 | UInt8 |
| MOD: Adv-Comp Type | 20010032 | 6 | COMP_TYPE (UInt8) |
| MOD: Adv-Comp Sustain | 20010033 | 100 | UInt8 |
| MOD: Adv-Comp Attack | 20010034 | 100 | UInt8 |
| MOD: Adv-Comp Tone | 20010035 | 100 | UInt8 |
| MOD: Adv-Comp Level | 20010036 | 100 | UInt8 |
| MOD: Limiter Type | 20010037 | 2 | LIMITER_TYPE (UInt8) |
| MOD: Limiter Attack | 20010038 | 100 | UInt8 |
| MOD: Limiter Threshold | 20010039 | 100 | UInt8 |
| MOD: Limiter Ratio | 2001003A | 17 | LIMITER_RATIO (UInt8) |
| MOD: Limiter Release | 2001003B | 100 | UInt8 |
| MOD: Limiter Level | 2001003C | 100 | UInt8 |
| MOD: T-Wah Mode | 2001003D | 1 | WAH_MODE (UInt8) |
| MOD: T-Wah Polarity | 2001003E | 1 | TWAH_POLARITY (UInt8) |
| MOD: T-Wah Sens | 2001003F | 100 | UInt8 |
| MOD: T-Wah Frequency | 20010040 | 100 | UInt8 |
| MOD: T-Wah Peak | 20010041 | 100 | UInt8 |
| MOD: T-Wah Effect Level | 20010042 | 100 | UInt8 |
| MOD: T-Wah Direct Level | 20010043 | 100 | UInt8 |
| MOD: A-Wah Mode | 20010044 | 1 | WAH_MODE (UInt8) |
| MOD: A-Wah Frequency | 20010045 | 100 | UInt8 |
| MOD: A-Wah Peak | 20010046 | 100 | UInt8 |
| MOD: A-Wah Rate | 20010047 | 100 | UInt8 |
| MOD: A-Wah Depth | 20010048 | 100 | UInt8 |
| MOD: A-Wah Effect Level | 20010049 | 100 | UInt8 |
| MOD: A-Wah Direct Level | 2001004A | 100 | UInt8 |
| MOD: Graphic-EQ 31Hz | 2001004B | 40 | UInt8 |
| MOD: Graphic-EQ 62Hz | 2001004C | 40 | UInt8 |
| MOD: Graphic-EQ 125Hz | 2001004D | 40 | UInt8 |
| MOD: Graphic-EQ 250Hz | 2001004E | 40 | UInt8 |
| MOD: Graphic-EQ 500Hz | 2001004F | 40 | UInt8 |
| MOD: Graphic-EQ 1kHz | 20010050 | 40 | UInt8 |
| MOD: Graphic-EQ 2kHz | 20010051 | 40 | UInt8 |
| MOD: Graphic-EQ 4kHz | 20010052 | 40 | UInt8 |
| MOD: Graphic-EQ 8kHz | 20010053 | 40 | UInt8 |
| MOD: Graphic-EQ 16kHz | 20010054 | 40 | UInt8 |
| MOD: Graphic-EQ Level | 20010055 | 40 | UInt8 |
| MOD: Para-EQ Low Cut | 20010056 | 17 | EQ_LOW_CUT (UInt8) |
| MOD: Para-EQ Low Gain | 20010057 | 40 | UInt8 |
| MOD: Para-EQ Low-Mid Freq | 20010058 | 27 | EQ_MID_FREQ (UInt8) |
| MOD: Para-EQ Low-Mid Q | 20010059 | 5 | EQ_MID_Q (UInt8) |
| MOD: Para-EQ Low-Mid Gain | 2001005A | 40 | UInt8 |
| MOD: Para-EQ Hi-Mid Freq | 2001005B | 27 | EQ_MID_FREQ (UInt8) |
| MOD: Para-EQ Hi-Mid Q | 2001005C | 5 | EQ_MID_Q (UInt8) |
| MOD: Para-EQ High-Mid Gain | 2001005D | 40 | UInt8 |
| MOD: Para-EQ High Gain | 2001005E | 40 | UInt8 |
| MOD: Para-EQ High Cut | 2001005F | 14 | EQ_HI_CUT (UInt8) |
| MOD: Para-EQ Level | 20010060 | 40 | UInt8 |
| MOD: Guitar-Sim Type | 20010061 | 7 | GUITAR_SIM_TYPE (UInt8) |
| MOD: Guitar-Sim Low | 20010062 | 100 | UInt8 |
| MOD: Guitar-Sim High | 20010063 | 100 | UInt8 |
| MOD: Guitar-Sim Body | 20010064 | 100 | UInt8 |
| MOD: Guitar-Sim Level | 20010065 | 100 | UInt8 |
| MOD: AC-Sim High | 20010066 | 100 | UInt8 |
| MOD: AC-Sim Body | 20010067 | 100 | UInt8 |
| MOD: AC-Sim Low | 20010068 | 100 | UInt8 |
| MOD: AC-Sim Level | 20010069 | 100 | UInt8 |
| MOD: Acoustic-Pro Type | 2001006A | 3 | ACOUSTIC_PRO_TYPE (UInt8) |
| MOD: Acoustic-Pro Bass | 2001006B | 100 | UInt8 |
| MOD: Acoustic-Pro Middle | 2001006C | 100 | UInt8 |
| MOD: Acoustic-Pro Mid Freq | 2001006D | 27 | EQ_MID_FREQ (UInt8) |
| MOD: Acoustic-Pro Treble | 2001006E | 100 | UInt8 |
| MOD: Acoustic-Pro Presence | 2001006F | 100 | UInt8 |
| MOD: Acoustic-Pro Level | 20010070 | 100 | UInt8 |
| MOD: Wave-Synth Wave | 20010071 | 1 | WAVE_SYNTH_TYPE (UInt8) |
| MOD: Wave-Synth Cutoff | 20010072 | 100 | UInt8 |
| MOD: Wave-Synth Resonance | 20010073 | 100 | UInt8 |
| MOD: Wave-Synth Filter Sens | 20010074 | 100 | UInt8 |
| MOD: Wave-Synth Filter Decay | 20010075 | 100 | UInt8 |
| MOD: Wave-Synth Filter Depth | 20010076 | 100 | UInt8 |
| MOD: Wave-Synth Synth Level | 20010077 | 100 | UInt8 |
| MOD: Wave-Synth Direct Mix | 20010078 | 100 | UInt8 |
| MOD: Octaver Range | 20010079 | 3 | OCTAVER_RANGE (UInt8) |
| MOD: Octaver Octaverave Level | 2001007A | 100 | UInt8 |
| MOD: Octaver Direct Level | 2001007B | 100 | UInt8 |
| MOD HOC: Octave -1 | 2001007C | 100 | UInt8 |
| MOD HOC: Octave -2 | 2001007D | 100 | UInt8 |
| MOD HOC: Direct Mix | 2001007E | 100 | UInt8 |
| MOD: Pitch-S Voice | 2001007F | 1 | PITCH_SHIFTER_VOICE (UInt8) |
| MOD: Pitch-S Pitch-S1 Mode | 20010100 | 3 | PITCH_SHIFTER_MODE (UInt8) |
| MOD: Pitch-S Pitch-S1 Pitch | 20010101 | 100 | UInt8 |
| MOD: Pitch-S Pitch-S1 Fine | 20010102 | 100 | UInt8 |
| MOD: Pitch-S Pitch-S1 Pre Delay | 20010103 | 300 | UInt16 (4Byte encoding) |
| MOD: Pitch-S Pitch-S1 Level | 20010107 | 100 | UInt8 |
| MOD: Pitch-S Pitch-S2 Mode | 20010108 | 3 | PITCH_SHIFTER_MODE (UInt8) |
| MOD: Pitch-S Pitch-S2 Pitch | 20010109 | 100 | UInt8 |
| MOD: Pitch-S Pitch-S2 Fine | 2001010A | 100 | UInt8 |
| MOD: Pitch-S Pitch-S2 Pre Delay | 2001010B | 300 | UInt16 (4Byte encoding) |
| MOD: Pitch-S Pitch-S2 Level | 2001010F | 100 | UInt8 |
| MOD: Pitch-S Pitch-S1 Feedback | 20010110 | 100 | UInt8 |
| MOD: Pitch-S Direct Level | 20010111 | 100 | UInt8 |
| MOD: Harmonist Voice | 20010112 | 1 | HARMONIST_VOICE (UInt8) |
| MOD: Harmonist Harmonist1 Harmony | 20010113 | 100 | UInt8 |
| MOD: Harmonist Harmonist1 Pre Delay | 20010114 | 300 | UInt16 (4Byte encoding) |
| MOD: Harmonist Harmonist1 Level | 20010118 | 100 | UInt8 |
| MOD: Harmonist Harmonist2 Harmony | 20010119 | 100 | UInt8 |
| MOD: Harmonist Harmonist2 Pre Delay | 2001011A | 300 | UInt16 (4Byte encoding) |
| MOD: Harmonist Harmonist2 Level | 2001011E | 100 | UInt8 |
| MOD: Harmonist Harmonist1 Feedback | 2001011F | 100 | UInt8 |
| MOD: Harmonist Direct Level | 20010120 | 100 | UInt8 |
| MOD: Humanizer Mode | 20010139 | 1 | HUMANIZER_MODE (UInt8) |
| MOD: Humanizer Vowel 1 | 2001013A | 4 | HUMANIZER_VOWEL (UInt8) |
| MOD: Humanizer Vowel 2 | 2001013B | 4 | HUMANIZER_VOWEL (UInt8) |
| MOD: Humanizer Sens | 2001013C | 100 | UInt8 |
| MOD: Humanizer Rate | 2001013D | 100 | UInt8 |
| MOD: Humanizer Depth | 2001013E | 100 | UInt8 |
| MOD: Humanizer Manual | 2001013F | 100 | UInt8 |
| MOD: Humanizer Level | 20010140 | 100 | UInt8 |
| MOD: Phaser 90E Script | 20010141 | 1 | Boolean |
| MOD: Phaser 90E Speed | 20010142 | 100 | UInt8 |
| MOD: Flanger 117E Manual | 20010143 | 100 | UInt8 |
| MOD: Fanger 117E Width | 20010144 | 100 | UInt8 |
| MOD: Flanger 117E Speed | 20010145 | 100 | UInt8 |
| MOD: Flanger 117E Regen | 20010146 | 100 | UInt8 |
| MOD DC30: Selector | 20010147 | 1 | DC30_TYPE (UInt8) |
| MOD DC30: Input | 20010148 | 100 | UInt8 |
| MOD DC30: Intensity | 20010149 | 100 | UInt8 |
| MOD DC30: Repeat Rate | 2001014A | 600 | UInt16 (4Byte encoding) |
| MOD DC30: Intensity | 2001014E | 100 | UInt8 |
| MOD DC30: Volume | 2001014F | 100 | UInt8 |
| MOD DC30: Tone | 20010150 | 100 | UInt8 |
| MOD DC30: Output Select | 20010151 | 1 | DC30_OUTPUT_TYPE (UInt8) |
| MOD BASS ENH: Sense | 20010152 | 100 | UInt8 |
| MOD BASS ENH: Low Level | 20010153 | 100 | UInt8 |
| MOD BASS ENH: Low Freq | 20010154 | 27 | EQ_MID_FREQ (UInt8) |
| MOD BASS ENH: High Level | 20010155 | 100 | UInt8 |
| MOD BASS ENH: High Freq | 20010156 | 27 | EQ_MID_FREQ (UInt8) |
| MOD BASS SIM: Type | 20010157 | 1 | BASS_SIM_TYPE (UInt8) |
| MOD BASS SIM: Low | 20010158 | 100 | UInt8 |
| MOD BASS SIM: High | 20010159 | 100 | UInt8 |
| MOD BASS SIM: Level | 2001015A | 100 | UInt8 |
| MOD BASS SIM: Body | 2001015B | 100 | UInt8 |
| MOD BASS DEFR: Sense | 2001015C | 100 | UInt8 |
| MOD BASS DEFR: Attack | 2001015D | 100 | UInt8 |
| MOD BASS DEFR: Depth | 2001015E | 100 | UInt8 |
| MOD BASS DEFR: Resonance | 2001015F | 100 | UInt8 |
| MOD BASS DEFR: Tone | 20010160 | 100 | UInt8 |
| MOD BASS DEFR: Effect | 20010161 | 100 | UInt8 |
| MOD BASS DEFR: Direct Mix | 20010162 | 100 | UInt8 |
| MOD BASS OCT: Octave -1 | 20010163 | 100 | UInt8 |
| MOD BASS OCT: Octave -2 | 20010164 | 100 | UInt8 |
| MOD BASS OCT: Direct Mix | 20010165 | 100 | UInt8 |
| MOD BASS: T-Wah Mode | 20010166 | 1 | WAH_MODE (UInt8) |
| MOD BASS: T-Wah Polarity | 20010167 | 1 | TWAH_POLARITY (UInt8) |
| MOD BASS: T-Wah Sens | 20010168 | 100 | UInt8 |
| MOD BASS: T-Wah Frequency | 20010169 | 100 | UInt8 |
| MOD BASS: T-Wah Peak | 2001016A | 100 | UInt8 |
| MOD BASS: T-Wah Effect Level | 2001016B | 100 | UInt8 |
| MOD BASS: T-Wah Direct Level | 2001016C | 100 | UInt8 |
| MOD BASS: Wave-Synth Wave | 2001016D | 1 | WAVE_SYNTH_TYPE (UInt8) |
| MOD BASS: Wave-Synth Cutoff | 2001016E | 100 | UInt8 |
| MOD BASS: Wave-Synth Resonance | 2001016F | 100 | UInt8 |
| MOD BASS: Wave-Synth Filter Sens | 20010170 | 100 | UInt8 |
| MOD BASS: Wave-Synth Filter Decay | 20010171 | 100 | UInt8 |
| MOD BASS: Wave-Synth Filter Depth | 20010172 | 100 | UInt8 |
| MOD BASS: Wave-Synth Synth Level | 20010173 | 100 | UInt8 |
| MOD BASS: Wave-Synth Direct Mix | 20010174 | 100 | UInt8 |
| FX: Off/On | 20003002 | 1 | Boolean |
| FX: Type | 20007000 | 30 | MODFX_TYPE (UInt8) |
| FX: 2X2-Chorus Crossover f | 20011000 | 100 | UInt8 |
| FX: 2X2-Chorus Low Rate | 20011001 | 100 | UInt8 |
| FX: 2X2-Chorus Low Depth | 20011002 | 100 | UInt8 |
| FX: 2X2-Chorus Low Pre Dly | 20011003 | 80 | UInt8 |
| FX: 2X2-Chorus Low Level | 20011004 | 100 | UInt8 |
| FX: 2X2-Chorus High Rate | 20011005 | 100 | UInt8 |
| FX: 2X2-Chorus High Depth | 20011006 | 100 | UInt8 |
| FX: 2X2-Chorus High Pre Dly | 20011007 | 80 | UInt8 |
| FX: 2X2-Chorus High Level | 20011008 | 100 | UInt8 |
| FX: 2X2-Chorus Direct Mix | 20011009 | 100 | UInt8 |
| FX: Flanger Rate | 2001100A | 100 | UInt8 |
| FX: Flanger Depth | 2001100B | 100 | UInt8 |
| FX: Flanger Manual | 2001100C | 100 | UInt8 |
| FX: Flanger Resonance | 2001100D | 100 | UInt8 |
| FX: Flanger Low Cut | 2001100E | 10 | FLANGER_LOW_CUT (UInt8) |
| FX: Flanger Effect Level | 2001100F | 100 | UInt8 |
| FX: Flanger Direct Level | 20011010 | 100 | UInt8 |
| FX: Phaser Type | 20011011 | 3 | PHASER_TYPE (UInt8) |
| FX: Phaser Rate | 20011012 | 100 | UInt8 |
| FX: Phaser Depth | 20011013 | 100 | UInt8 |
| FX: Phaser Manual | 20011014 | 100 | UInt8 |
| FX: Phaser Resonance | 20011015 | 100 | UInt8 |
| FX: Phaser Step Rate | 20011016 | 100 | UInt8 |
| FX: Phaser Effect Level | 20011017 | 100 | UInt8 |
| FX: Phaser Direct Level | 20011018 | 100 | UInt8 |
| FX: Uni-Vibe Rate | 20011019 | 100 | UInt8 |
| FX: Uni-Vibe Depth | 2001101A | 100 | UInt8 |
| FX: Uni-Vibe Level | 2001101B | 100 | UInt8 |
| FX: Tremolo Wave Shape | 2001101C | 100 | UInt8 |
| FX: Tremolo Rate | 2001101D | 100 | UInt8 |
| FX: Tremolo Depth | 2001101E | 100 | UInt8 |
| FX: Tremolo Level | 2001101F | 100 | UInt8 |
| FX: Vibrato Rate | 20011020 | 100 | UInt8 |
| FX: Vibrato Depth | 20011021 | 100 | UInt8 |
| FX: Vibrato Level | 20011022 | 100 | UInt8 |
| FX: Rotary Rate | 20011023 | 100 | UInt8 |
| FX: Rotary Depth | 20011024 | 100 | UInt8 |
| FX: Rotary Level | 20011025 | 100 | UInt8 |
| FX: Ring-FX Mode | 20011026 | 1 | RING_MOD_MODE (UInt8) |
| FX: Ring-FX Frequency | 20011027 | 100 | UInt8 |
| FX: Ring-FX Effect Level | 20011028 | 100 | UInt8 |
| FX: Ring-FX Direct Mix | 20011029 | 100 | UInt8 |
| FX: Slow-Gear Sens | 2001102A | 100 | UInt8 |
| FX: Slow-Gear RiseTime | 2001102B | 100 | UInt8 |
| FX: Slow-Gear Level | 2001102C | 100 | UInt8 |
| FX: Slicer Pattern | 2001102D | 19 | UInt8 |
| FX: Slicer Rate | 2001102E | 100 | UInt8 |
| FX: Slicer Trigger Sens | 2001102F | 100 | UInt8 |
| FX: Slicer Effect Level | 20011030 | 100 | UInt8 |
| FX: Slicer Direct Mix | 20011031 | 100 | UInt8 |
| FX: Adv-Comp Type | 20011032 | 6 | COMP_TYPE (UInt8) |
| FX: Adv-Comp Sustain | 20011033 | 100 | UInt8 |
| FX: Adv-Comp Attack | 20011034 | 100 | UInt8 |
| FX: Adv-Comp Tone | 20011035 | 100 | UInt8 |
| FX: Adv-Comp Level | 20011036 | 100 | UInt8 |
| FX: Limiter Type | 20011037 | 2 | LIMITER_TYPE (UInt8) |
| FX: Limiter Attack | 20011038 | 100 | UInt8 |
| FX: Limiter Threshold | 20011039 | 100 | UInt8 |
| FX: Limiter Ratio | 2001103A | 17 | LIMITER_RATIO (UInt8) |
| FX: Limiter Release | 2001103B | 100 | UInt8 |
| FX: Limiter Level | 2001103C | 100 | UInt8 |
| FX: T-Wah Mode | 2001103D | 1 | WAH_MODE (UInt8) |
| FX: T-Wah Polarity | 2001103E | 1 | TWAH_POLARITY (UInt8) |
| FX: T-Wah Sens | 2001103F | 100 | UInt8 |
| FX: T-Wah Frequency | 20011040 | 100 | UInt8 |
| FX: T-Wah Peak | 20011041 | 100 | UInt8 |
| FX: T-Wah Effect Level | 20011042 | 100 | UInt8 |
| FX: T-Wah Direct Level | 20011043 | 100 | UInt8 |
| FX: A-Wah Mode | 20011044 | 1 | WAH_MODE (UInt8) |
| FX: A-Wah Frequency | 20011045 | 100 | UInt8 |
| FX: A-Wah Peak | 20011046 | 100 | UInt8 |
| FX: A-Wah Rate | 20011047 | 100 | UInt8 |
| FX: A-Wah Depth | 20011048 | 100 | UInt8 |
| FX: A-Wah Effect Level | 20011049 | 100 | UInt8 |
| FX: A-Wah Direct Level | 2001104A | 100 | UInt8 |
| FX: Graphic-EQ 31Hz | 2001104B | 40 | UInt8 |
| FX: Graphic-EQ 62Hz | 2001104C | 40 | UInt8 |
| FX: Graphic-EQ 125Hz | 2001104D | 40 | UInt8 |
| FX: Graphic-EQ 250Hz | 2001104E | 40 | UInt8 |
| FX: Graphic-EQ 500Hz | 2001104F | 40 | UInt8 |
| FX: Graphic-EQ 1kHz | 20011050 | 40 | UInt8 |
| FX: Graphic-EQ 2kHz | 20011051 | 40 | UInt8 |
| FX: Graphic-EQ 4kHz | 20011052 | 40 | UInt8 |
| FX: Graphic-EQ 8kHz | 20011053 | 40 | UInt8 |
| FX: Graphic-EQ 16kHz | 20011054 | 40 | UInt8 |
| FX: Graphic-EQ Level | 20011055 | 40 | UInt8 |
| FX: Para-EQ Low Cut | 20011056 | 17 | EQ_LOW_CUT (UInt8) |
| FX: Para-EQ Low Gain | 20011057 | 40 | UInt8 |
| FX: Para-EQ Low-Mid Freq | 20011058 | 27 | EQ_MID_FREQ (UInt8) |
| FX: Para-EQ Low-Mid Q | 20011059 | 5 | EQ_MID_Q (UInt8) |
| FX: Para-EQ Low-Mid Gain | 2001105A | 40 | UInt8 |
| FX: Para-EQ Hi-Mid Freq | 2001105B | 27 | EQ_MID_FREQ (UInt8) |
| FX: Para-EQ Hi-Mid Q | 2001105C | 5 | EQ_MID_Q (UInt8) |
| FX: Para-EQ High-Mid Gain | 2001105D | 40 | UInt8 |
| FX: Para-EQ High Gain | 2001105E | 40 | UInt8 |
| FX: Para-EQ High Cut | 2001105F | 14 | EQ_HI_CUT (UInt8) |
| FX: Para-EQ Level | 20011060 | 40 | UInt8 |
| FX: Guitar-Sim Type | 20011061 | 7 | GUITAR_SIM_TYPE (UInt8) |
| FX: Guitar-Sim Low | 20011062 | 100 | UInt8 |
| FX: Guitar-Sim High | 20011063 | 100 | UInt8 |
| FX: Guitar-Sim Body | 20011064 | 100 | UInt8 |
| FX: Guitar-Sim Level | 20011065 | 100 | UInt8 |
| FX: AC-Sim High | 20011066 | 100 | UInt8 |
| FX: AC-Sim Body | 20011067 | 100 | UInt8 |
| FX: AC-Sim Low | 20011068 | 100 | UInt8 |
| FX: AC-Sim Level | 20011069 | 100 | UInt8 |
| FX: Acoustic-Pro Type | 2001106A | 3 | ACOUSTIC_PRO_TYPE (UInt8) |
| FX: Acoustic-Pro Bass | 2001106B | 100 | UInt8 |
| FX: Acoustic-Pro Middle | 2001106C | 100 | UInt8 |
| FX: Acoustic-Pro Mid Freq | 2001106D | 27 | EQ_MID_FREQ (UInt8) |
| FX: Acoustic-Pro Treble | 2001106E | 100 | UInt8 |
| FX: Acoustic-Pro Presence | 2001106F | 100 | UInt8 |
| FX: Acoustic-Pro Level | 20011070 | 100 | UInt8 |
| FX: Wave-Synth Wave | 20011071 | 1 | WAVE_SYNTH_TYPE (UInt8) |
| FX: Wave-Synth Cutoff | 20011072 | 100 | UInt8 |
| FX: Wave-Synth Resonance | 20011073 | 100 | UInt8 |
| FX: Wave-Synth Filter Sens | 20011074 | 100 | UInt8 |
| FX: Wave-Synth Filter Decay | 20011075 | 100 | UInt8 |
| FX: Wave-Synth Filter Depth | 20011076 | 100 | UInt8 |
| FX: Wave-Synth Synth Level | 20011077 | 100 | UInt8 |
| FX: Wave-Synth Direct Mix | 20011078 | 100 | UInt8 |
| FX: Octaver Range | 20011079 | 3 | OCTAVER_RANGE (UInt8) |
| FX: Octaver Octaverave Level | 2001107A | 100 | UInt8 |
| FX: Octaver Direct Level | 2001107B | 100 | UInt8 |
| FX HOC: Octave -1 | 2001107C | 100 | UInt8 |
| FX HOC: Octave -2 | 2001107D | 100 | UInt8 |
| FX HOC: Direct Mix | 2001107E | 100 | UInt8 |
| FX: Pitch-S Voice | 2001107F | 1 | PITCH_SHIFTER_VOICE (UInt8) |
| FX: Pitch-S Pitch-S1 Mode | 20011100 | 3 | PITCH_SHIFTER_MODE (UInt8) |
| FX: Pitch-S Pitch-S1 Pitch | 20011101 | 100 | UInt8 |
| FX: Pitch-S Pitch-S1 Fine | 20011102 | 100 | UInt8 |
| FX: Pitch-S Pitch-S1 Pre Delay | 20011103 | 300 | UInt16 (4Byte encoding) |
| FX: Pitch-S Pitch-S1 Level | 20011107 | 100 | UInt8 |
| FX: Pitch-S Pitch-S2 Mode | 20011108 | 3 | PITCH_SHIFTER_MODE (UInt8) |
| FX: Pitch-S Pitch-S2 Pitch | 20011109 | 100 | UInt8 |
| FX: Pitch-S Pitch-S2 Fine | 2001110A | 100 | UInt8 |
| FX: Pitch-S Pitch-S2 Pre Delay | 2001110B | 300 | UInt16 (4Byte encoding) |
| FX: Pitch-S Pitch-S2 Level | 2001110F | 100 | UInt8 |
| FX: Pitch-S Pitch-S1 Feedback | 20011110 | 100 | UInt8 |
| FX: Pitch-S Direct Level | 20011111 | 100 | UInt8 |
| FX: Harmonist Voice | 20011112 | 1 | HARMONIST_VOICE (UInt8) |
| FX: Harmonist Harmonist1 Harmony | 20011113 | 100 | UInt8 |
| FX: Harmonist Harmonist1 Pre Delay | 20011114 | 300 | UInt16 (4Byte encoding) |
| FX: Harmonist Harmonist1 Level | 20011118 | 100 | UInt8 |
| FX: Harmonist Harmonist2 Harmony | 20011119 | 100 | UInt8 |
| FX: Harmonist Harmonist2 Pre Delay | 2001111A | 300 | UInt16 (4Byte encoding) |
| FX: Harmonist Harmonist2 Level | 2001111E | 100 | UInt8 |
| FX: Harmonist Harmonist1 Feedback | 2001111F | 100 | UInt8 |
| FX: Harmonist Direct Level | 20011120 | 100 | UInt8 |
| FX: Humanizer Mode | 20011139 | 1 | HUMANIZER_MODE (UInt8) |
| FX: Humanizer Vowel 1 | 2001113A | 4 | HUMANIZER_VOWEL (UInt8) |
| FX: Humanizer Vowel 2 | 2001113B | 4 | HUMANIZER_VOWEL (UInt8) |
| FX: Humanizer Sens | 2001113C | 100 | UInt8 |
| FX: Humanizer Rate | 2001113D | 100 | UInt8 |
| FX: Humanizer Depth | 2001113E | 100 | UInt8 |
| FX: Humanizer Manual | 2001113F | 100 | UInt8 |
| FX: Humanizer Level | 20011140 | 100 | UInt8 |
| FX: Phaser 90E Script | 20011141 | 1 | Boolean |
| FX: Phaser 90E Speed | 20011142 | 100 | UInt8 |
| FX: Flanger 117E Manual | 20011143 | 100 | UInt8 |
| FX: Fanger 117E Width | 20011144 | 100 | UInt8 |
| FX: Flanger 117E Speed | 20011145 | 100 | UInt8 |
| FX: Flanger 117E Regen | 20011146 | 100 | UInt8 |
| FX DC30: Selector | 20011147 | 1 | DC30_TYPE (UInt8) |
| FX DC30: Input | 20011148 | 100 | UInt8 |
| FX DC30: Intensity | 20011149 | 100 | UInt8 |
| FX DC30: Repeat Rate | 2001114A | 600 | UInt16 (4Byte encoding) |
| FX DC30: Intensity | 2001114E | 100 | UInt8 |
| FX DC30: Volume | 2001114F | 100 | UInt8 |
| FX DC30: Tone | 20011150 | 100 | UInt8 |
| FX DC30: Output Select | 20011151 | 1 | DC30_OUTPUT_TYPE (UInt8) |
| FX BASS ENH: Sense | 20011152 | 100 | UInt8 |
| FX BASS ENH: Low Level | 20011153 | 100 | UInt8 |
| FX BASS ENH: Low Freq | 20011154 | 27 | EQ_MID_FREQ (UInt8) |
| FX BASS ENH: High Level | 20011155 | 100 | UInt8 |
| FX BASS ENH: High Freq | 20011156 | 27 | EQ_MID_FREQ (UInt8) |
| FX BASS SIM: Type | 20011157 | 1 | BASS_SIM_TYPE (UInt8) |
| FX BASS SIM: Low | 20011158 | 100 | UInt8 |
| FX BASS SIM: High | 20011159 | 100 | UInt8 |
| FX BASS SIM: Level | 2001115A | 100 | UInt8 |
| FX BASS SIM: Body | 2001115B | 100 | UInt8 |
| FX BASS DEFR: Sense | 2001115C | 100 | UInt8 |
| FX BASS DEFR: Attack | 2001115D | 100 | UInt8 |
| FX BASS DEFR: Depth | 2001115E | 100 | UInt8 |
| FX BASS DEFR: Resonance | 2001115F | 100 | UInt8 |
| FX BASS DEFR: Tone | 20011160 | 100 | UInt8 |
| FX BASS DEFR: Effect | 20011161 | 100 | UInt8 |
| FX BASS DEFR: Direct Mix | 20011162 | 100 | UInt8 |
| FX BASS OCT: Octave -1 | 20011163 | 100 | UInt8 |
| FX BASS OCT: Octave -2 | 20011164 | 100 | UInt8 |
| FX BASS OCT: Direct Mix | 20011165 | 100 | UInt8 |
| FX BASS: T-Wah Mode | 20011166 | 1 | WAH_MODE (UInt8) |
| FX BASS: T-Wah Polarity | 20011167 | 1 | TWAH_POLARITY (UInt8) |
| FX BASS: T-Wah Sens | 20011168 | 100 | UInt8 |
| FX BASS: T-Wah Frequency | 20011169 | 100 | UInt8 |
| FX BASS: T-Wah Peak | 2001116A | 100 | UInt8 |
| FX BASS: T-Wah Effect Level | 2001116B | 100 | UInt8 |
| FX BASS: T-Wah Direct Level | 2001116C | 100 | UInt8 |
| FX BASS: Wave-Synth Wave | 2001116D | 1 | WAVE_SYNTH_TYPE (UInt8) |
| FX BASS: Wave-Synth Cutoff | 2001116E | 100 | UInt8 |
| FX BASS: Wave-Synth Resonance | 2001116F | 100 | UInt8 |
| FX BASS: Wave-Synth Filter Sens | 20011170 | 100 | UInt8 |
| FX BASS: Wave-Synth Filter Decay | 20011171 | 100 | UInt8 |
| FX BASS: Wave-Synth Filter Depth | 20011172 | 100 | UInt8 |
| FX BASS: Wave-Synth Synth Level | 20011173 | 100 | UInt8 |
| FX BASS: Wave-Synth Direct Mix | 20011174 | 100 | UInt8 |
| DELAY 1: D1 On/Off | 20003003 | 1 | Boolean |
| DELAY 1: D1 Type | 20012000 | 10 | DELAY_TYPE (UInt8) |
| DELAY 1: D1 Time | 20012001 | 2000 | UInt16 (4Byte encoding) |
| DELAY 1: D1 Feedback | 20012005 | 100 | UInt8 |
| DELAY 1: D1 High Cut | 20012006 | 14 | DELAY_HIGH_CUT (UInt8) |
| DELAY 1: Effect Level | 20012007 | 100 | UInt8 |
| DELAY 1: Direct Mix | 20012008 | 100 | UInt8 |
| DELAY 1: Pan Tap Time | 20012009 | 100 | UInt8 |
| DELAY 1: Modulate Rate | 2001200A | 100 | UInt8 |
| DELAY 1: Modulate Depth | 2001200B | 100 | UInt8 |
| DELAY 1: Vint LPF Sw | 2001200C | 1 | Boolean |
| DELAY 1: Vint Filter | 2001200D | 1 | DELAY_FILTER (UInt8) |
| DELAY 1: Vint F.B. Phase | 2001200E | 1 | DELAY_PHASE (UInt8) |
| DELAY 1: Vint Effect Phase | 2001200F | 1 | DELAY_PHASE (UInt8) |
| DELAY 1: Modulate Sw | 20012010 | 1 | Boolean |
| DELAY 2: D1 On/Off | 20003004 | 1 | Boolean |
| DELAY 2: D1 Type | 20013000 | 10 | DELAY_TYPE (UInt8) |
| DELAY 2: D1 Time | 20013001 | 2000 | UInt16 (4Byte encoding) |
| DELAY 2: D1 Feedback | 20013005 | 100 | UInt8 |
| DELAY 2: D1 High Cut | 20013006 | 14 | DELAY_HIGH_CUT (UInt8) |
| DELAY 2: Effect Level | 20013007 | 100 | UInt8 |
| DELAY 2: Direct Mix | 20013008 | 100 | UInt8 |
| DELAY 2: Pan Tap Time | 20013009 | 100 | UInt8 |
| DELAY 2: Modulate Rate | 2001300A | 100 | UInt8 |
| DELAY 2: Modulate Depth | 2001300B | 100 | UInt8 |
| DELAY 2: Vint LPF Sw | 2001300C | 1 | Boolean |
| DELAY 2: Vint Filter | 2001300D | 1 | DELAY_FILTER (UInt8) |
| DELAY 2: Vint F.B. Phase | 2001300E | 1 | DELAY_PHASE (UInt8) |
| DELAY 2: Vint Effect Phase | 2001300F | 1 | DELAY_PHASE (UInt8) |
| DELAY 2: Modulate Sw | 20013010 | 1 | Boolean |
| REVERB: On/Off | 20003005 | 1 | Boolean |
| REVERB: Type | 20014000 | 6 | REVERB_TYPE (UInt8) |
| REVERB: REVERB Time | 20014002 | 100 | UInt8 |
| REVERB: Pre Delay | 20014003 | 500 | UInt16 (4Byte encoding) |
| REVERB: Low Cut | 20014007 | 17 | EQ_LOW_CUT (UInt8) |
| REVERB: High Cut | 20014008 | 14 | EQ_HI_CUT (UInt8) |
| REVERB: Density | 20014009 | 100 | UInt8 |
| REVERB: Effect Level | 2001400A | 100 | UInt8 |
| REVERB: Direct Mix | 2001400B | 100 | UInt8 |
| REVERB: Spring Sens | 2001400C | 100 | UInt8 |
| Pedal FX Off/On | 20024001 | 1 | Boolean |
| Pedal FX Type | 20024002 | 1 | PEDAL_FX_TYPE (UInt8) |
| PFX WAH: Type | 20025000 | 1 | WAH_TYPE (UInt8) |
| PFX WAH: PDL Pos | 20025001 | 100 | UInt8 |
| PFX WAH: PDL Min | 20025002 | 100 | UInt8 |
| PFX WAH: PDL Max | 20025003 | 100 | UInt8 |
| PFX WAH: Effect Level | 20025004 | 100 | UInt8 |
| PFX WAH: Direct Mix | 20025005 | 100 | UInt8 |
| PFX PBEND: Pitch Max | 20025006 | 48 | UInt8 |
| PFX PBEND: Pedal Position | 20025007 | 100 | UInt8 |
| PFX PBEND: Effect | 20025008 | 100 | UInt8 |
| PFX PBEND: Direct Mix | 20025009 | 100 | UInt8 |
| PFX WAH95: Pedal Pos | 2002500A | 100 | UInt8 |
| PFX WAH95: Pedal Min | 2002500B | 100 | UInt8 |
| PFX WAH95: Pedal Max | 2002500C | 100 | UInt8 |
| PFX WAH95: Effect Level | 2002500D | 100 | UInt8 |
| PFX WAH95: Direct Mix | 2002500E | 100 | UInt8 |
| FV: Foot Volume Level | 20024003 | 100 | UInt8 |
| BASS COMP/LIM: Off/on | 20003006 | 1 | Boolean |
| BASS COMP/LIM: Mode | 20005000 | 1 | BASS_COMP_LIM_MODE (UInt8) |
| BASS COMP: Type | 20005001 | 6 | COMP_TYPE (UInt8) |
| BASS COMP: Sustain | 20005002 | 100 | UInt8 |
| BASS COMP: Attack | 20005003 | 100 | UInt8 |
| BASS COMP: Tone | 20005004 | 100 | UInt8 |
| BASS COMP: Effect | 20005005 | 100 | UInt8 |
| BASS LIM: Type | 20005006 | 2 | LIMITER_TYPE (UInt8) |
| BASS LIM: Attack | 20005007 | 100 | UInt8 |
| BASS LIM: Threshold | 20005008 | 100 | UInt8 |
| BASS LIM: Ratio | 20005009 | 17 | LIMITER_RATIO (UInt8) |
| BASS LIM: Release | 2000500A | 100 | UInt8 |
| BASS LIM: Effect | 2000500B | 100 | UInt8 |
| NS: On/Off | 20034000 | 1 | Boolean |
| NS: Threshold | 20034001 | 100 | UInt8 |
| NS: Release | 20034002 | 100 | UInt8 |
| MASTER: Patch Key | 20001003 | 11 | PATCH_KEY (UInt8) |
| Contour: Off/On | 20020000 | 1 | Boolean |
| Contour: Contour Select | 20020000 | 3 | CONTOUR_SELECT (UInt8) |
| Contour 1: Contour Type | 20021000 | 2 | Contour_Type (UInt8) |
| Contour 1: Freq Shift | 20021001 | 100 | UInt8 |
| Contour 2: Contour Type | 20022000 | 2 | Contour_Type (UInt8) |
| Contour 2: Freq Shift | 20022001 | 100 | UInt8 |
| Contour 3: Contour Type | 20023000 | 2 | Contour_Type (UInt8) |
| Contour 3: Freq Shift | 20023001 | 100 | UInt8 |
| Cabinet Resonance | 20001001 | 3 | CABINET_RESONANCE (UInt8) |
| Signal chain : Pedal FX | 20024000 | 30 | UInt8 |
| Signal Chain order: Type 1~7 | 20001000 | 6 | UInt8 |
| Tuner: On/Off | 10000000 | 1 | Boolean |
| GLOBAL EQ: Off/On | 10001000 | 1 | Boolean |
| GLOBAL EQ: Low Cut | 10002000 | 17 | EQ_LOW_CUT (UInt8) |
| GLOBAL EQ: Low Gain | 10002001 | 40 | UInt8 |
| GLOBAL EQ: Lo Mid Freq | 10002002 | 27 | EQ_MID_FREQ (UInt8) |
| GLOBAL EQ: Lo Mid Q  | 10002003 | 5 | EQ_MID_Q (UInt8) |
| GLOBAL EQ: Lo Mid Gain | 10002004 | 40 | UInt8 |
| GLOBAL EQ: Hi Mid Freq | 10002005 | 27 | EQ_MID_FREQ (UInt8) |
| GLOBAL EQ: Hi Mid Q | 10002006 | 5 | EQ_MID_Q (UInt8) |
| GLOBAL EQ: Hi Mid Gain | 10002007 | 40 | UInt8 |
| GLOBAL EQ: Hi Gain | 10002008 | 40 | UInt8 |
| GLOBAL EQ: Hi Cut | 10002009 | 14 | EQ_HI_CUT (UInt8) |
| GLOBAL EQ: Level | 1000200A | 40 | UInt8 |
| STAGE FEEL: Select | 10003000 | 3 | STAGE_FEEL_SELECT (UInt8) |
| STAGE FEEL: Custom  Guitar Position | 10006000 | 100 | UInt8 |
| STAGE FEEL: Audio Position | 10006001 | 100 | UInt8 |
| STAGE FEEL: Ambience type | 10006002 | 2 | AMBIENCE_TYPE (UInt8) |
| STAGE FEEL: Ambience Level | 10006003 | 100 | UInt8 |
| USB: Input Level | 10007000 | 100 | UInt8 |
| USB: Output Level | 10007001 | 100 | UInt8 |
