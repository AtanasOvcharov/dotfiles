local function system_prefers_dark()
	-- macOS: AppleInterfaceStyle is "Dark" in dark mode.
	-- The setting is normally absent in light mode.
	if vim.fn.has("macunix") == 1 then
		local out = vim.fn.system({
			"defaults",
			"read",
			"-g",
			"AppleInterfaceStyle",
		})

		return vim.v.shell_error == 0
			and out:match("Dark") ~= nil
	end

	-- Ubuntu / GNOME.
	if vim.fn.executable("gsettings") == 1 then
		local out = vim.fn.system({
			"gsettings",
			"get",
			"org.gnome.desktop.interface",
			"color-scheme",
		})

		if vim.v.shell_error == 0 then
			return out:match("prefer%-dark") ~= nil
		end
	end

	-- Fallback for other environments.
	local appearance = vim.env.TERM_APPEARANCE
	if appearance == "dark" or appearance == "light" then
		return appearance == "dark"
	end

	return vim.o.background == "dark"
end

local function sync_theme()
	local dark = system_prefers_dark()
	local background = dark and "dark" or "light"
	local colorscheme = dark
		and "catppuccin-mocha"
		or "catppuccin-latte"

	if vim.o.background ~= background
		or vim.g.colors_name ~= colorscheme
	then
		vim.o.background = background
		vim.cmd.colorscheme(colorscheme)
	end
end

return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1001,
		config = function()
			vim.opt.termguicolors = true

			require("catppuccin").setup({
				flavour = "auto",
				background = {
					light = "latte",
					dark = "mocha",
				},
				transparent_background = false,
				integrations = {
					treesitter = true,
					native_lsp = { enabled = true },
				},
			})

			sync_theme()

			local group = vim.api.nvim_create_augroup(
				"DotfilesSystemTheme",
				{ clear = true }
			)

			vim.api.nvim_create_autocmd("FocusGained", {
				group = group,
				callback = function()
					vim.schedule(sync_theme)
				end,
			})
		end,
	},
	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
	},
}
