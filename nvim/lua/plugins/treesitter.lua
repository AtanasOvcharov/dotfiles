return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
	highlight = { enable = true },
	indent = { enable = true },

	ensure_installed = {
	    "c", "cpp", "cmake", "make", "asm",
	    "bash", "python",
	    "lua", "vim", "vimdoc",
	    "markdown", "markdown_inline",
	    "json", "yaml", "toml",
	    "gitignore", "regex",
	},

	auto_install = true,
    },
}
