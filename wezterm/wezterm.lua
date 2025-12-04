local wezterm = require 'wezterm'

local config = wezterm.config_builder()

local home = os.getenv("HOME")

-- config.initial_cols = 120
-- config.initial_rows = 28

config.font_size = 12
config.font = wezterm.font('JetBrains Mono', { weight = 100, italic = false })

config.color_scheme = 'TokyoNight'

config.foreground_text_hsb = {
    hue = 1.0,
    saturation = 1.0,
    brightness = 1.2,
}
config.background = {
    {
        source = {
            File = home .. '/terminal.png',
        },
        hsb = {
            brightness = 0.1
        },
        -- opacity = 0.95
    },
}

config.window_decorations = 'NONE'
config.enable_tab_bar = false
config.window_padding = {
    left = 8,
    right = 8,
    top = 8,
    bottom = 8,
}

config.max_fps = 60
config.animation_fps = 1
config.front_end = "WebGpu"
config.enable_wayland = false

return config
