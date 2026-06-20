-- Leader key
vim.g.mapleader = " "

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })

-- save / quit (normal mode)
vim.keymap.set("n", "<leader>w", "<cmd>write<CR>", { desc = "Save" })
vim.keymap.set("n", "<leader>W", "<cmd>wall<CR>", { desc = "Save all" })

vim.keymap.set("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", "<cmd>qall<CR>", { desc = "Quit all" })

vim.keymap.set("n", "<leader>x", "<cmd>wq<CR>", { desc = "Save & quit" })

-- lazy
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- Alows lsp to jump acros diferent files
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf, silent = true }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts) 
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) 
  end
})

vim.keymap.set("n", "gl", vim.diagnostic.open_float, { silent = true, desc = "Line diagnostics" })

