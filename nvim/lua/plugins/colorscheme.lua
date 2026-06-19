local function set_colorscheme(name)
  local ok, _ = pcall(vim.cmd, "colorscheme " .. name)
  if not ok then
    vim.notify("colorscheme not found: " .. name, vim.log.levels.warn)
  end
end

local theme = {
  dark = {
    name = "catppuccin",
    background = "dark",
  },
  light = {
    name = "github_light",
    background = "light",
  },
}

local function apply_theme(mode)
  if mode == "light" then
    vim.o.background = theme.light.background
    set_colorscheme(theme.light.name)
  else
    vim.o.background = theme.dark.background
    set_colorscheme(theme.dark.name)
  end
end

local function system_prefers_dark()
  local out = vim.fn.system("gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null")
  return out:match("prefer%-dark") ~= nil
end


-- Make background transparent
local function enable_transparency()
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })	
end

local function sync_with_system()
  if system_prefers_dark() then
    apply_theme("dark")
  else
    apply_theme("light")
  end
    enable_transparency()
end

return {
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({
        options = {
        },
      })
    end,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        integrations = {
          treesitter = true,
          native_lsp = { enabled = true },
        },
      })
    end,
  },

  -- OneDark 
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1001, -- load very early
    config = function()
      require("onedark").setup({
        style = "darker", -- dark, darker, cool, deep, warm, warmer, light
      })
      sync_with_system()
    end,
  },
}
