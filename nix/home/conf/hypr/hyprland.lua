-- ~/.config/hypr/hyprland.lua

local mod = "SUPER"

local terminal = "ghostty"  
local menu = "wofi --show drun"

-- Monitors
hl.monitor({
    output = "HDMI-A-1",
    mode = "2560x1440@143.91",
    position = "0x0",
    scale = 1,
})

hl.config({
  startup = {
    exec_once = {
      "hyprpaper",
    },
  },
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

hl.config({
  general = {
    gaps_in          = 3,
    gaps_out         = 6,

    allow_tearing    = false,
    layout           = "dwindle",
  },

  decoration = {
    rounding         = 4,
    rounding_power   = 3,
    active_opacity   = 1.0,
    inactive_opacity = 0.9,
    fullscreen_opacity = 1.0,

    shadow           = {
      enabled      = true,
      range        = 8,
      render_power = 3,
      color        = 0xee1a1a1a,
      color_inactive = 0x661a1a1a,
    },

    blur = {
      enabled = true;
      size = 14;
      passes = 3;
      ignore_opacity = true;
      new_optimizations = true;
      noise = 0.01;
      contrast = 0.8;
      brightness = 0.7;
      vibrancy = 0.4;
      vibrancy_darkness = 0.0;
      popups = true;
      xray = true;
    }
  },

  animations = {
    enabled = false,
  },

  dwindle = {
    preserve_split = true,
  },

  misc = {
    force_default_wallpaper = false,
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

hl.bind(mod .. " + SHIFT + N", hl.dsp.send_shortcut({ mods = "CTRL SHIFT", key = "N", window = "class:helium", }))

-- Clipboard
hl.bind(mod .. " + C", hl.dsp.send_shortcut({ mods = "CTRL", key = "C" }))
hl.bind(mod .. " + V", hl.dsp.send_shortcut({ mods = "CTRL", key = "V" }))

-- Workspaces 
hl.bind(mod .. " + F1", hl.dsp.focus({ workspace = 2 }))
hl.bind(mod .. " + F2", hl.dsp.focus({ workspace = 3 }))
hl.bind(mod .. " + F3", hl.dsp.focus({ workspace = 4 }))
hl.bind(mod .. " + F4", hl.dsp.focus({ workspace = 5 }))
hl.bind(mod .. " + F5", hl.dsp.focus({ workspace = 6 }))

hl.bind(mod .. " + SHIFT + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + SHIFT + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mod .. " + SHIFT + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + SHIFT + L", hl.dsp.focus({ direction = "right" }))

hl.window_rule({
  match = {
    class = "com.mitchellh.ghostty",
  },

  opacity = "0.9",
})





