-- Games
hl.window_rule({ match = { class = "steam_app_.*" }, tag = "+game" })
hl.window_rule({ match = { class = "[Mm]inecraft" }, tag = "+game" })
hl.window_rule({ match = { tag = "game" }, immediate = true })

-- PiP
hl.window_rule({ match = { title = "discord\\.com/popout" }, tag = "+pip" })
hl.window_rule({ match = { title = "Picture%-in%-Picture" }, tag = "+pip" })
hl.window_rule({
    match = { tag = "pip" },
    float = true,
    keep_aspect_ratio = true,
    move = { "monitor_w-window_w-16", "monitor_h-window_h-16" },
    size = { "monitor_w*0.25", "monitor_h*0.25" },
    no_initial_focus = true,
    pin = true,
    opacity = "1",
    no_blur = true,
    no_dim = true,
    opaque = true,
})

-- Shimeji
hl.window_rule({ match = { title = "oneko" }, tag = "+shimeji" })
hl.window_rule({
    match = { tag = "shimeji" },
    border_size = 0,
    float = true,
    no_blur = true,
    no_focus = true,
    no_shadow = true,
})
