local wezterm = require("wezterm")
local config = wezterm.config_builder()

----------  Appearance  ----------

-- Theme
local appearance = wezterm.gui.get_appearance()
local is_dark = appearance:find("Dark") ~= nil

config.color_scheme = is_dark and "Catppuccin Mocha" or "Catppuccin Latte"
config.set_environment_variables = {
	TERM_APPEARANCE = is_dark and "dark" or "light",
}

-- Font
config.font = wezterm.font("MesloLGS Nerd Font")

-- Window
config.enable_wayland = false
config.window_background_opacity = 0.98
config.window_decorations = "TITLE | RESIZE"
config.window_padding = { left = 10, right = 10, top = 8, bottom = 6 }

-- Dim panes you're not focused on
config.inactive_pane_hsb = { saturation = 0.85, brightness = 0.7 }

-- Tab bar
config.enable_tab_bar = false

-- Make links clickable (Ctrl+click)
config.hyperlink_rules = wezterm.default_hyperlink_rules()

return config
