return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"L3MON4D3/LuaSnip",
		"hrsh7th/cmp-nvim-lsp",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-omni",
	},
	config = function()
		local cmp = require("cmp")
		cmp.setup({
			sources = {
				{ name = "nvim_lsp" },
				{ name = "path" },
				{ name = "luasnip" },
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<Tab>"] = cmp.mapping.confirm({ select = true }),
			}),
			completion = {
				autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
				completeopt = "menu,menuone,noinsert",
			},
		})

		cmp.setup.filetype({ "tex" }, {
			sources = cmp.config.sources({
				{ name = "omni", priority = 1000 },
				{ name = "luasnip", priority = 900 },
				{ name = "nvim_lsp", priority = 800 },
			}),
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "tex",
			callback = function()
				vim.opt_local.omnifunc = "vimtex#complete#omnifunc"
			end,
		})
	end,
}
