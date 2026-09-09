-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 80
config.initial_rows = 20

-- or, changing the font size and color scheme.
config.font_size = 14
config.color_scheme = 'Tokyo Night'

-- disable window padding
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0
}

-- force window size in integer character increments
config.use_resize_increments = true

-- tmux can handle this
config.enable_tab_bar = false

-- I don't want any keybinds by default
config.disable_default_key_bindings = true

-- define some minimal keybinds
config.keys = {
    -- copy and paste
    {
        key = 'c',
        mods = "CTRL|SHIFT",
        action = wezterm.action.CopyTo "Clipboard"
    },
    {
        key = 'v',
        mods = "CTRL|SHIFT",
        action = wezterm.action.PasteFrom "Clipboard"
    },
    {
        key = 'c',
        mods = "SUPER",
        action = wezterm.action.CopyTo "Clipboard"
    },
    {
        key = 'v',
        mods = "SUPER",
        action = wezterm.action.PasteFrom "Clipboard"
    },
    -- debug overlay
    {
        key = 'l',
        mods = "CTRL|SHIFT",
        action = wezterm.action.ShowDebugOverlay
    },
    -- command palette
    {
        key = 'p',
        mods = "CTRL|SHIFT",
        action = wezterm.action.ActivateCommandPalette
    },
    -- character selector
    {
        key = 'u',
        mods = "CTRL|SHIFT",
        action = wezterm.action.CharSelect
    },
}

config.mouse_bindings = {
    -- Use Left Click for primary selection only, disables opening links
    {
        event = { Up = { streak = 1, button = "Left"} },
        mods = "NONE",
        action = wezterm.action.CompleteSelection 'PrimarySelection',
    },
    -- Use Ctrl-Click Up to open links
    {
        event = { Up = { streak = 1, button = "Left"} },
        mods = "CTRL",
        action = wezterm.action.OpenLinkAtMouseCursor,
    },
    -- Disable Ctrl-Click Down event
    {
        event = { Down = { streak=1, button = "Left"} },
        mods = "CTRL",
        action = wezterm.action.Nop,
    },
}

config.command_palette_bg_color = "#202020"
config.char_select_bg_color = "#202020"

-- Finally, return the configuration to wezterm:
return config
