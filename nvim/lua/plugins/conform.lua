vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		vim.b.disable_autoformat = true -- this buffer only
	else
		vim.g.disable_autoformat = true -- globally
	end
end, { bang = true })

vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, {})

return {
	{
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
				markdown = { "prettier" },
				["markdown.mdx"] = { "prettier" },
			},
			format_on_save = function(bufnr)
				-- respect global + per-buffer disable flags
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return { timeout_ms = 1000, lsp_fallback = true }
			end,
		},
	}
}
