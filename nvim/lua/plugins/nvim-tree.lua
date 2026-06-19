return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
      require("nvim-tree").setup({
        view = { width = 32 },
        renderer = {
          icons = { show = { file = true, folder = true, folder_arrow = true, git = true } },
        },
        filters = { dotfiles = false },
      })
      -- keymaps
      vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Explorer" })
    end,
  },
}
