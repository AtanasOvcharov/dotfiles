return {
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
		init = function()
			vim.g.tmux_navigator_no_mappings = 1
		end,
		config = function()
			local directions = {
				["<C-h>"] = "Left",
				["<C-j>"] = "Down",
				["<C-k>"] = "Up",
				["<C-l>"] = "Right",
			}

			for key, direction in pairs(directions) do
				local command = "<cmd>TmuxNavigate" .. direction .. "<cr>"
				vim.keymap.set("n", key, command, { silent = true, desc = "Navigate " .. direction:lower() })
				vim.keymap.set("t", key, "<C-\\><C-n>" .. command, {
					silent = true,
					desc = "Navigate " .. direction:lower(),
				})
			end
		end,
	},
}
