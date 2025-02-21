require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "clangd", "cmake", "pylsp" },
})


vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set('n', 'K',    '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd',   '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD',   '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi',   '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go',   '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr',   '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs',   '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    vim.keymap.set({'n', 'x'},  '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
  end,
})

local cmp = require('cmp')
cmp.setup({
    sources = {
        {name = 'nvim_lsp'},
        { name = 'buffer' },
        { name = 'path' },
        { name = 'luasnip' }
    },
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-n>'] = cmp.mapping.select_next_item(),      -- Move to next suggestion
        ['<C-p>'] = cmp.mapping.select_prev_item(),      -- Move to previous suggestion
        ['<C-d>'] = cmp.mapping.scroll_docs(4),           -- Scroll documentation down
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),          -- Scroll documentation up
        ['<C-Space>'] = cmp.mapping.complete(),           -- Trigger completion
        ['<Tab>'] = cmp.mapping.confirm({ select = true })
    }),
    completion = {
        autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
        completeopt = "menu,menuone,noinsert",
    },
})



local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)



require("lspconfig").lua_ls.setup {
    filetypes = { "lua" }
}
require("lspconfig").clangd.setup {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--suggest-missing-includes",
        "--completion-style=detailed",
    },
    filetypes = { "c", "cpp", "objc", "objcpp" },
}
require("lspconfig").cmake.setup {}
require("lspconfig").pylsp.setup {}

local warning_error_text = false

function ToggleWarningError()
    warning_error_text = not warning_error_text
    if warning_error_text then
        vim.diagnostic.config({
            virtual_text = false,
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true
        })
    else
        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true
        })
    end
end


vim.api.nvim_set_keymap('n', '<leader>w', ':lua ToggleWarningError()<CR>', { noremap = true, silent = true })


require('aerial').setup({
    backends = { "treesitter", "lsp" },
    layout = {
        default_direction = "right",
    },
    attach_mode = "global",
})

