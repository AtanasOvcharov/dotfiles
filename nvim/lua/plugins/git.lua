return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			signcolumn = true,
			numhl = false,
			linehl = false,
			current_line_blame = false,

			on_attach = function(bufnr)
				local gs = require("gitsigns")
				local map = function(m, l, r, desc)
					vim.keymap.set(m, l, r, { buffer = bufnr, desc = desc })
				end

				map("n", "]h", gs.next_hunk, "Next hunk")
				map("n", "[h", gs.prev_hunk, "Prev hunk")
				map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
				map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
			end,
		})
	end,
}
