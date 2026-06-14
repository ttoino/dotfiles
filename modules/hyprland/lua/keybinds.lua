local apps = require("02-apps")

local mainMod = "SUPER"

-- Terminal, browser, file explorer, editor, discord
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(apps.terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(apps.browser))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd(apps.secondary_browser))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(apps.file_explorer))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd(apps.editor))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd(apps.discord))

-- Screenshots
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(apps.grimblast_copy))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(apps.grimblast_copy_area))

-- Color picker
hl.bind(mainMod .. " + CTRL + C", hl.dsp.exec_cmd(apps.hyprpicker_cmd))

-- Window management
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.window.pin())

-- PiP video setup
hl.bind(mainMod .. " + SHIFT + V", function()
    hl.dispatch(hl.dsp.window.float({ action = "set" }))
    hl.dispatch(hl.dsp.window.pin())
    hl.dispatch(hl.dsp.window.set_prop({ prop = "opaque", value = "toggle" }))
    hl.dispatch(
        hl.dsp.window.resize({ x = "25%", y = "25%", relative = false })
    )
    hl.dispatch(hl.dsp.window.move({ direction = "r" }))
    hl.dispatch(hl.dsp.window.move({ direction = "d" }))
end)

-- Media
hl.bind(mainMod .. " + Period", hl.dsp.exec_cmd(apps.playerctl_next))
hl.bind(
    "XF86AudioNext",
    hl.dsp.exec_cmd(apps.playerctl_next),
    { locked = true }
)
hl.bind(mainMod .. " + Comma", hl.dsp.exec_cmd(apps.playerctl_previous))
hl.bind(
    "XF86AudioPrev",
    hl.dsp.exec_cmd(apps.playerctl_previous),
    { locked = true }
)
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(apps.playerctl_play_pause))
-- These should be different, but keyboards with both are rare
hl.bind(
    "XF86AudioPlay",
    hl.dsp.exec_cmd(apps.playerctl_play_pause),
    { locked = true }
)
hl.bind(
    "XF86AudioPause",
    hl.dsp.exec_cmd(apps.playerctl_play_pause),
    { locked = true }
)

-- Move focus
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))

-- Move window
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "d" }))

-- Switch workspaces
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
end

-- Move window to workspace
for i = 1, 10 do
    local key = i % 10
    hl.bind(
        mainMod .. " + SHIFT + " .. key,
        hl.dsp.window.move({ workspace = i })
    )
end

-- Scroll workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Resize window (repeating)
hl.bind(
    mainMod .. " + CTRL + left",
    hl.dsp.window.resize({ x = -10, y = 0, relative = true }),
    { repeating = true }
)
hl.bind(
    mainMod .. " + CTRL + right",
    hl.dsp.window.resize({ x = 10, y = 0, relative = true }),
    { repeating = true }
)
hl.bind(
    mainMod .. " + CTRL + up",
    hl.dsp.window.resize({ x = 0, y = -10, relative = true }),
    { repeating = true }
)
hl.bind(
    mainMod .. " + CTRL + down",
    hl.dsp.window.resize({ x = 0, y = 10, relative = true }),
    { repeating = true }
)

-- Brightness (repeating)
hl.bind(
    "XF86MonBrightnessDown",
    hl.dsp.exec_cmd(apps.brightnessctl_down),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86MonBrightnessUp",
    hl.dsp.exec_cmd(apps.brightnessctl_up),
    { locked = true, repeating = true }
)

-- Audio (repeating)
hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd(apps.wpctl_mute),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd(apps.wpctl_vol_down),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd(apps.wpctl_vol_up),
    { locked = true, repeating = true }
)

-- Mouse binds
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Gestures
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "down", action = "close" })
hl.gesture({ fingers = 3, direction = "up", action = "fullscreen" })
