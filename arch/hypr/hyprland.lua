-- ~/.config/hypr/hyprland.lua

local mod = "SUPER"

local terminal = "kitty"  
local menu = "wofi --show drun"

-- Layout
hl.config({
    general = {
        gaps_in = 0,
        gaps_out = 0,
        border_size = 0,
        layout = "dwindle",
    },
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

-- Workspaces 
hl.bind(mod .. " + F1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mod .. " + F2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mod .. " + F3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mod .. " + F4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mod .. " + F5", hl.dsp.focus({ workspace = 5 }))

