-- ~/.config/hypr/hyprland.lua

local mod = "SUPER"

local terminal = "kitty"  
local menu = "wofi --show drun"

-- Monitors
hl.monitor({
    output = "HDMI-A-1",
    mode = "2560x1440@143.91",
    position = "0x0",
    scale = 1,
})

-- Layout
hl.config({
    general = {
        gaps_in = 0,
        gaps_out = 0,
        border_size = 0,
        layout = "dwindle",
    },
})

hl.window_rule({
    name = "kitty-floating-window",
    match = { class = "floating_kitty" },
    float = true,
    pin = true,
    center = true,
    size = "800 600",
})

-- Decoration
hl.config({
    decoration = {
        rounding = 0,
        blur = {
            enabled = false,
        },
    },
})

-- Animations
hl.config({
    animations = {
        enabled = false,
    },
})

-- Keybinds
hl.bind(mod .. " + Q", hl.dsp.window.close())   
hl.bind(mod .. " + M", hl.dsp.exit())

hl.bind(mod .. " + BACKSPACE", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + SPACE", hl.dsp.exec_cmd(menu))

hl.bind("SUPER + W", hl.dsp.send_shortcut({ mods = "CTRL", key = "W" }))
hl.bind("SUPER + T", hl.dsp.send_shortcut({ mods = "CTRL", key = "T" }))
hl.bind("SUPER + R", hl.dsp.send_shortcut({ mods = "CTRL", key = "R" }))
hl.bind("SUPER + L", hl.dsp.send_shortcut({ mods = "CTRL", key = "L" }))

-- Workspaces 
hl.bind(mod .. " + F1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mod .. " + F2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mod .. " + F3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mod .. " + F4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mod .. " + F5", hl.dsp.focus({ workspace = 5 }))


