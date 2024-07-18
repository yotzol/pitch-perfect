package main

import rl       "vendor:raylib"

draw_piano :: proc()
{
    // draw white keys
    key_width := w_w / 7
    for i in 0..<7 {
        rl.DrawRectangle(i32(i) * key_width, 0, key_width, w_h, rl.WHITE)
        rl.DrawRectangleLines(i32(i) * key_width, 0, key_width, w_h, rl.BLACK)
    }

    // draw black keys (c#, d#, f#, g#, a#)
    black_keys : []i32 = {1, 2, 4, 5, 6}
    for i in black_keys {
        rl.DrawRectangle(
            i32(i) * key_width - key_width / 3,
            0,
            i32(f32(key_width) / 1.5),
            i32(f32(w_h) / 1.5),
            rl.BLACK
        )
    }

}
