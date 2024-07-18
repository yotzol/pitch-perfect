package main

import rl       "vendor:raylib"
import          "core:c"


WINDOW_TITLE    :: "Pitch Perfect"
DEFAULT_W_W     :: 400
DEFAULT_W_H     :: 400

w_w, w_h : c.int

main :: proc()
{
    w_w, w_h = DEFAULT_W_W, DEFAULT_W_H

    rl.InitWindow(w_w, w_h, WINDOW_TITLE)
    defer rl.CloseWindow()

    rl.SetTargetFPS(60)

    rl.InitAudioDevice()
    defer rl.CloseAudioDevice()

    play_note(.A, 1)
    for !rl.WindowShouldClose() {
        clear_finished_sounds()

        if rl.IsWindowResized() {
            w_w = rl.GetScreenWidth()
            w_h = rl.GetScreenHeight()
        }

        rl.BeginDrawing()
        rl.ClearBackground(rl.GRAY)

        draw_piano()

        rl.EndDrawing()
    }
}

