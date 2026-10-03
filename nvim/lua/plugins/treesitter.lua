return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local parsers = {
				"c",
				"cpp",
				"cmake",
				"make",
				"asm",
				"bash",
				"python",
				"lua",
				"vim",
				"vimdoc",
				"markdown",
				"markdown_inline",
				"json",
				"yaml",
				"toml",
				"gitignore",
				"regex",
			}
			local parser_by_filetype = {
				c = "c",
				cpp = "cpp",
				cmake = "cmake",
				make = "make",
				asm = "asm",
				sh = "bash",
				python = "python",
				lua = "lua",
				vim = "vim",
				help = "vimdoc",
				markdown = "markdown",
				json = "json",
				yaml = "yaml",
				toml = "toml",
				gitignore = "gitignore",
				regex = "regex",
			}

			require("nvim-treesitter").install(parsers)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = vim.tbl_keys(parser_by_filetype),
				callback = function(args)
					local filetype = vim.bo[args.buf].filetype
					vim.treesitter.start(args.buf, parser_by_filetype[filetype])
				end,
			})
		end,
	},
}
