return {
	{
		"williamboman/mason.nvim",
		config = true,
	},

	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"lua_ls",
				"clangd",
				"neocmake",
			},
			automatic_installation = true,
		},
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"williamboman/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
		},
		config = function()
			local caps = require("cmp_nvim_lsp").default_capabilities()

			local servers = require("lsp.servers")

			local specs = {
				servers.lua_ls(caps),
				servers.clangd(caps),
				servers.neocmake(caps),
			}

			local names = {}
			for _, spec in ipairs(specs) do
				vim.lsp.config(spec.name, spec.config)
				table.insert(names, spec.name)
			end

			vim.lsp.enable(names)
		end,
	},
}
