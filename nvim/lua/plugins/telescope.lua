return {
    {
	'nvim-telescope/telescope.nvim', version = '*',
	dependencies = {
	    'nvim-lua/plenary.nvim',
	    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	},
	config = function()
	    local builtin = require('telescope.builtin')
	    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
	    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
	    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
	    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
	end
    },
    {
	'nvim-telescope/telescope-ui-select.nvim',
	config = function()
	    require("telescope").setup {
		extensions = {
		    ["ui-select"] = {
			require("telescope.themes").get_dropdown {
			}
		    }
		}
	    }
	    require("telescope").load_extension("ui-select")
	end
    },
    {
	"nvim-telescope/telescope-dap.nvim",
	dependencies = {
	    "nvim-telescope/telescope.nvim",
	    "mfussenegger/nvim-dap",
	},
	config = function()
	    require("telescope").load_extension("dap")

	    vim.keymap.set("n", "<leader>dc", function()
		require("telescope").extensions.dap.commands()
	    end, { desc = "DAP Commands" })

	    vim.keymap.set("n", "<leader>dC", function()
		require("telescope").extensions.dap.configurations()
	    end, { desc = "DAP Configurations" })

	    vim.keymap.set("n", "<leader>dB", function()
		require("telescope").extensions.dap.list_breakpoints()
	    end, { desc = "DAP Breakpoints" })

	    vim.keymap.set("n", "<leader>dv", function()
		require("telescope").extensions.dap.variables()
	    end, { desc = "DAP Variables" })

	    vim.keymap.set("n", "<leader>df", function()
		require("telescope").extensions.dap.frames()
	    end, { desc = "DAP Frames" })
	end,
    },
}

