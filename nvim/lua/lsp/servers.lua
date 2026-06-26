local M = {}

-- Each server function returns: { name = "...", config = {...} }
function M.lua_ls(caps)
	return {
		name = "lua_ls",
		config = {
			capabilities = caps,
			settings = { Lua = { diagnostics = { globals = { "vim" } } } },
		},
	}
end

function M.clangd(caps)
	return {
		name = "clangd",
		config = {
			capabilities = caps,
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--header-insertion=iwyu",
				"--completion-style=detailed",
				"--function-arg-placeholders",
				"--fallback-style=llvm",
			},
			init_options = {
				usePlaceholders = true,
				completeUnimported = true,
				clangdFileStatus = true,
			},
		},
	}
end

function M.neocmake(caps)
	return {
		name = "neocmake",
		config = {
			capabilities = caps,
			filetypes = { "cmake" },
			init_options = {
				format = { enable = false }, -- let gersemi handle formatting
				lint = { enable = true },
				scan_cmake_in_package = true,
			},
		},
	}
end

return M
