package main

import rl       "vendor:raylib"

SAMPLE_RATE     :: 48000
AMPLITUDE       :: 0.2

WINDOW_TITLE    :: "Pitch Perfect"
WINDOW_W        :: 400
WINDOW_H        :: 400

main :: proc()
{
    rl.InitWindow(WINDOW_W, WINDOW_H, WINDOW_TITLE)
    defer rl.CloseWindow()

    rl.SetTargetFPS(60)

    rl.InitAudioDevice()
    defer rl.CloseAudioDevice()

    wave := sine_wave(440, 1)

    sound := rl.LoadSoundFromWave(wave)
    defer    rl.UnloadSound(sound)

    rl.PlaySound(sound)

    for !rl.WindowShouldClose() {
        rl.BeginDrawing()
        rl.ClearBackground(rl.WHITE)
        rl.EndDrawing()
    }
}

