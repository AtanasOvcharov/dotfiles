return {
	{
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
					accept = "<C-g>",
					accept_word = "<M-w>",
					accept_line = "<M-Enter>",
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
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "copilot/fix-models-list-error",
		version = false,
		cmd = "CopilotChat",
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken",
		opts = function()
			local user = vim.env.USER or "User"
			user = user:sub(1, 1):upper() .. user:sub(2)
			return {
				model = "gpt-4o-mini-2024-07-18",
				auto_insert_mode = false,
				headers = {
					user = "  " .. user .. " ",
					assistant = "  Copilot ",
					tool = "󰊳  Tool ",
				},
				window = {
					width = 0.3,
				},
			}
		end,
		keys = {
			{ "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
			{ "<leader>a", "", desc = "+ai", mode = { "n", "x" } },
			{
				"<leader>aa",
				function()
					return require("CopilotChat").toggle()
				end,
				desc = "Toggle (CopilotChat)",
				mode = { "n", "x" },
			},
			{
				"<leader>ax",
				function()
					return require("CopilotChat").reset()
				end,
				desc = "Clear (CopilotChat)",
				mode = { "n", "x" },
			},
			{
				"<leader>aq",
				function()
					vim.ui.input({
						prompt = "Quick Chat: ",
					}, function(input)
						if input ~= "" then
							require("CopilotChat").ask(input)
						end
					end)
				end,
				desc = "Quick Chat (CopilotChat)",
				mode = { "n", "x" },
			},
			{
				"<leader>ap",
				function()
					require("CopilotChat").select_prompt()
				end,
				desc = "Prompt Actions (CopilotChat)",
				mode = { "n", "x" },
			},
		},
	},
}
