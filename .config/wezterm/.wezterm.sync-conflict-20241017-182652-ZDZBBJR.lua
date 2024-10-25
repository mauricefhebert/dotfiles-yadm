local wezterm = require 'wezterm'
local act = wezterm.action
local mux = wezterm.mux

-- Config
local config = {}
config.color_scheme_dirs = { "~/.config/wezterm/color_scheme" }
config.color_scheme = "Minimalist Dark"
config.window_decorations = "TITLE | RESIZE"
config.default_prog = { "C:/Program Files/Git/bin/bash.exe", "-i" }
config.font = wezterm.font "FiraCode Nerd Font"
config.window_background_opacity = 1
config.font_size = 12
config.line_height = 1.2
config.use_dead_keys = false
config.scrollback_lines = 5000
config.hide_tab_bar_if_only_one_tab = true
config.inactive_pane_hsb = { saturation = 0.8, brightness = 0.7 }

-- Add the keybinding to trigger the script using 'send-text'
-- config.keys = {
--   {
--     key = "b",
--     mods = "CTRL",
--     action = '
--   },
-- }

return config
