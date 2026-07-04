return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	build = ":Copilot auth",
	opts = {
		suggestion = {
			enabled = true,
			debounce = 75,
			auto_trigger = true,
			trigger_on_accept = true,
			hide_during_completions = true,
			keymap = {
				accept = "<C-i>",
				accept_word = "<C-w>",
				accept_line = "<C-I>",
				next = "<M-]>",
				prev = "<M-[>",
				dismiss = "<C-]>",
			},
		},
		panel = {
			enabled = false,
		},
		filetypes = {
			markdown = true,
			help = true,
			gitcommit = true,
		},
	},
	keys = {
		{
			"<leader>cp",
			function()
				require("copilot.suggestion").toggle_auto_trigger()
				local state = require("copilot.suggestion").is_visible() and "on" or "toggled"
				vim.notify("Copilot auto-trigger " .. state)
			end,
			desc = "Copilot: toggle auto-trigger",
		},
	},
}
