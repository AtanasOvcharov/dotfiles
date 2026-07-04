-- leader key
vim.g.mapleader = " "

-- save / quit (normal mode)
vim.keymap.set("n", "<leader>w", "<cmd>write<CR>", { desc = "Save" })
vim.keymap.set("n", "<leader>W", "<cmd>wall<CR>", { desc = "Save all" })

vim.keymap.set("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", "<cmd>qall<CR>", { desc = "Quit all" })

vim.keymap.set("n", "<leader>x", "<cmd>wq<CR>", { desc = "Save & quit" })

-- LSP attach maps
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local opts = { buffer = args.buf, silent = true }
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
	end,
})

vim.keymap.set("n", "gl", vim.diagnostic.open_float, { silent = true, desc = "Line diagnostics" })
