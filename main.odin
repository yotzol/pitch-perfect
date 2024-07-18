package main

import rl       "vendor:raylib"

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

    play_note(.A, 1)

    for !rl.WindowShouldClose() {
        for i := 0; i < len(sound_manager.sounds); {
            if !rl.IsSoundPlaying(sound_manager.sounds[i]) {
                rl.UnloadSound(sound_manager.sounds[i])
                ordered_remove(&sound_manager.sounds, i)
            } else {
                i += 1
            }
        }

        rl.BeginDrawing()
        rl.ClearBackground(rl.WHITE)
        rl.EndDrawing()
    }
}

