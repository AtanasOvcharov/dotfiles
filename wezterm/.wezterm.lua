local wezterm = require 'wezterm'
local act = wezterm.action
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
wezterm.plugin
    .require('https://github.com/yriveiro/wezterm-tabs')
    .apply_to_config(config)

---------- Keybinds ----------

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  -- Splits: Ctrl+a then | (vertical divide) or - (horizontal)
  { key = '|', mods = 'LEADER', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = '-', mods = 'LEADER', action = act.SplitVertical   { domain = 'CurrentPaneDomain' } },

    -- Move between panes (vim hjkl)
  { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
  { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },
  { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
  { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },

  -- Resize panes (hold after leader)
  { key = 'H', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize { 'Left', 5 } },
  { key = 'L', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize { 'Right', 5 } },
  { key = 'K', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize { 'Up', 5 } },
  { key = 'J', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize { 'Down', 5 } },

  -- Pane management
  { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState },          -- fullscreen a pane
  { key = 'x', mods = 'LEADER', action = act.CloseCurrentPane { confirm = true } },

  -- Tabs
  { key = 'c', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'n', mods = 'LEADER', action = act.ActivateTabRelative(1) },
  { key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) },

  -- Copy mode (vi-like scrollback selection/search) + quick paste
  { key = '[', mods = 'LEADER', action = act.ActivateCopyMode },
  { key = ']', mods = 'LEADER', action = act.PasteFrom 'Clipboard' },

  -- Reload config without restarting
  { key = 'r', mods = 'LEADER', action = act.ReloadConfiguration },
}

-- Quick tab switching: Ctrl+1..9
for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i), mods = 'CTRL', action = act.ActivateTab(i - 1),
  })
end

-- Make links clickable (Ctrl+click)
config.hyperlink_rules = wezterm.default_hyperlink_rules()

return config
