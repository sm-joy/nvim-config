return {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
        "mason-org/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local servers = {
            jsonls   = {},
            bashls   = {},
            html     = {},
            cssls    = {},
            yamlls   = {},
            marksman = {},
            pyright  = {},
            lua_ls   = {},
            clangd   = {
                cmd = { "clangd", "--background-index", "--clang-tidy", "--suggest-missing-includes", "--completion-style=detailed" },
                filetypes = { "c", "cpp", "objc", "objcpp" },
            },
        }

        require("mason-lspconfig").setup({
            ensure_installed = vim.tbl_keys(servers)
        })


        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP actions',
            callback = function(event)
                local opts = { buffer = event.buf }

                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
                vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
                vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts)
                vim.keymap.set({ 'n', 'x' }, '<F3>', function() vim.lsp.buf.format({ async = true }) end, opts)
            end
        })

        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            require("cmp_nvim_lsp").default_capabilities()
        )

        for server, config in pairs(servers) do
            config.capabilities = capabilities
            vim.lsp.config(server, config)
            vim.lsp.enable(server)
        end
    end
}
