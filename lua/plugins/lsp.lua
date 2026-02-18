return {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = { 
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function ()
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "clangd", "cmake", "pylsp" },
        })

        
        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP actions',
            callback = function(event)
                local opts = {buffer = event.buf}

                vim.keymap.set('n', 'K',    vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gd',   vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'gD',   vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gi',   vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', 'go',   vim.lsp.buf.type_definition, opts)
                vim.keymap.set('n', 'gr',   vim.lsp.buf.references, opts)
                vim.keymap.set('n', 'gs',   vim.lsp.buf.signature_help, opts)
                vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
                vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts)
                vim.keymap.set({'n', 'x'},  '<F3>', function() vim.lsp.buf.format({async = true}) end, opts)
            end
        })

        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            require("cmp_nvim_lsp").default_capabilities()
        )

        vim.lsp.enable("cmake")
        vim.lsp.config("cmake", { capabilities = capabilities })
        vim.lsp.enable("pylsp")
        vim.lsp.config("pylsp", { capabilities = capabilities })
        vim.lsp.enable("lua_ls")
        vim.lsp.config("lua_ls", { capabilities = capabilities, filetypes = "lua" })
        vim.lsp.enable("clangd")
        vim.lsp.config("clangd",
            {
                capabilities = capabilities,
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--suggest-missing-includes",
                    "--completion-style=detailed",
                },
                filetypes = { "c", "cpp", "objc", "objcpp" },
            }
        )

    end
}

