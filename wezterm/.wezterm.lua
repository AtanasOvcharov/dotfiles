local wezterm = require 'wezterm'
local config = wezterm.config_builder()

----------  Appearance  ---------- 

-- Theme 
local function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'Catppuccin Mocha'   -- dark
  else
    return 'Catppuccin Latte'   -- light
  end
end

config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

-- Font
config.font = wezterm.font 'MesloLGS Nerd Font'

-- Window
config.enable_wayland = false
config.window_background_opacity = 0.90
config.window_decorations = 'RESIZE'
config.window_padding = { left = 10, right = 10, top = 8, bottom = 6 }

-- Dim panes you're not focused on 
config.inactive_pane_hsb = { saturation = 0.85, brightness = 0.7 }

-- Tab bar
config.enable_tab_bar = false

-- Make links clickable (Ctrl+click)
config.hyperlink_rules = wezterm.default_hyperlink_rules()

return config
