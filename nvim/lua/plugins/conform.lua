return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			c = { "clang_format" },
			h = { "clang_format" },
			cpp = { "clang_format" },
			cmake = { "gersemi" },
			cmake_lists = { "gersemi" },
		},
		format_on_save = {
			timeout_ms = 1000,
			lsp_fallback = true,
		},
	},
}
