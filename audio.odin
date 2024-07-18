package main

import rl       "vendor:raylib"
import          "core:math"


SAMPLE_RATE     :: 48000
FADE_TIME       :: 0.05
VOLUME          :: 0.2

FADE_SAMPLES    :: i32(FADE_TIME * f32(SAMPLE_RATE))

SoundManager :: struct {
    sounds: [dynamic]rl.Sound
}

sound_manager : SoundManager

init_sound_manager :: proc()
{
    sound_manager.sounds = make([dynamic]rl.Sound)
}

Note :: enum {
    A, AS, B, C, CS, D, DS, E, F, FS, G, GS
}

Frequencies := [Note]f32 {
    .A  = 440.0,
    .AS = 466.16,
    .B  = 493.88,
    .C  = 523.25,
    .CS = 554.37,
    .D  = 587.33,
    .DS = 622.25,
    .E  = 659.25,
    .F  = 698.46,
    .FS = 739.99,
    .G  = 783.99,
    .GS = 830.61,
}

play_note :: proc(note: Note, duration_seconds: f32)
{
    frequency    := Frequencies[note]
    sample_count := i32(SAMPLE_RATE * duration_seconds)
    samples      := make([]f32, sample_count)

    for i in 0..<sample_count{
        t := f32(i) / f32(SAMPLE_RATE)
        samples[i]  = math.sin_f32(2 * math.PI * frequency * t)

        if t < FADE_TIME {
            samples[i] *= f32(i) / f32(FADE_SAMPLES)
        } else if t > duration_seconds - FADE_TIME {
            samples[i] *= f32(sample_count - i) / f32(FADE_SAMPLES)
        }
    }

    wave := rl.Wave{
        sampleRate = SAMPLE_RATE,
        sampleSize = 32,
        channels   = 1,
        frameCount = u32(len(samples)),
        data       = raw_data(samples),
    }

    sound := rl.LoadSoundFromWave(wave)
    rl.SetSoundVolume(sound, VOLUME)
    rl.PlaySound(sound)

    append(&sound_manager.sounds, sound)
}

