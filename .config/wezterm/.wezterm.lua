-- import and variable
local wezterm = require 'wezterm'
local act = wezterm.action

local config = {}
config.color_scheme_dirs = { "~/.config/wezterm/color_scheme" }
config.color_scheme = "Minimalist Dark"
config.window_decorations = "TITLE | RESIZE"
config.default_prog = { "C:/Users/mfiliatreaultheber/AppData/Local/Programs/Git/bin/bash.exe", "-i" }
config.font = wezterm.font "FiraCode Nerd Font"
config.window_background_opacity = 1
config.font_size = 12
config.line_height = 1.2
config.use_dead_keys = false
config.scrollback_lines = 5000
config.hide_tab_bar_if_only_one_tab = true
config.inactive_pane_hsb = { saturation = 0.8, brightness = 0.7 }
config.window_background_opacity = 0.8
config.automatically_reload_config = true

-- Debug configuration
-- config.exit_behavior = "Hold"
-- config.exit_behavior_messaging = "Verbose"

-- Add the keybinding to trigger the script using 'send-text'
config.keys = {
  -- Close the current activated pane without confirmation
  {
    key = "x",
    mods = "CTRL|ALT|SHIFT",
    action = act.CloseCurrentPane { confirm = false }
  },
}

return config
