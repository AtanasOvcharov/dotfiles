return {
    {
	"hrsh7th/cmp-nvim-lsp"
    },
    {
	"L3MON4D3/LuaSnip",
	version = "v2.5",
	build = "make install_jsregexp",
	dependencies = {
	    "saadparwaiz1/cmp_luasnip",
	    "rafamadriz/friendly-snippets",
	},
    },
    {
	"hrsh7th/nvim-cmp",
	config = function()
	    local cmp = require("cmp")
	    require("luasnip.loaders.from_vscode").lazy_load()

	    cmp.setup({
		snippet = {
		    expand = function(args)
			require("luasnip").lsp_expand(args.body)
		    end,
		},
		window = {
		    completion = cmp.config.window.bordered(),
		    documentation = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert({
		    -- Completion trigger
		    ["<C-Space>"] = cmp.mapping.complete(),
		    -- Navigate items
		    ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		    ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		    -- Scroll docs
		    ["<C-f>"] = cmp.mapping.scroll_docs(4),
		    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
		    -- Abort/close
		    ["<C-e>"] = cmp.mapping.abort(),
		    -- Confirm on Enter 
		    ["<CR>"] = cmp.mapping.confirm({ select = true }),
		}),
		sources = cmp.config.sources({
		    { name = "nvim_lsp" },
		    { name = "luasnip" },
		}, {
		    { name = "buffer" },
		}),
	    })
	end,
    },
}
