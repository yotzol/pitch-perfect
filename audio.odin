package main

import rl       "vendor:raylib"
import          "core:math"


sine_wave :: proc(frequency: f32, duration_seconds: f32) -> rl.Wave
{
    sample_count := i32(SAMPLE_RATE * duration_seconds)
    samples      := make([]f32, sample_count)

    for i in 0..<sample_count{
        t := f32(i) / f32(SAMPLE_RATE)
        samples[i] = math.sin_f32(2 * math.PI * frequency * t)
        samples[i] *= AMPLITUDE
    }

    wave := rl.Wave{
        sampleRate = SAMPLE_RATE,
        sampleSize = 32,
        channels   = 1,
        frameCount = u32(len(samples)),
        data       = raw_data(samples),
    }

    return wave
}

