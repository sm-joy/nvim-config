return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
	    "L3MON4D3/LuaSnip",
        "hrsh7th/cmp-nvim-lsp",
	    "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-path",
    },
    config = function ()
        local cmp = require("cmp")
        cmp.setup({
            sources = {
                {name = "nvim_lsp"},
                { name = "path" },
                { name = "luasnip" }
            },
            snippet = {
                expand = function(args)
                    require("LuaSnip").lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<Tab>"] = cmp.mapping.confirm({ select = true })
            }),
            completion = {
                autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
                completeopt = "menu,menuone,noinsert",
            },
        })

    end
}