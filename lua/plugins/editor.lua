return {
    {
        "matze/vim-move",
        init = function()
            vim.g.move_key_modifier = "A"
            vim.g.move_key_modifier_visualmode = "A"
            vim.g.move_map_keys = 0 -- disable default mappings

            vim.keymap.set('n', '<A-Up>', '<Plug>MoveLineUp')
            vim.keymap.set('n', '<A-Down>', '<Plug>MoveLineDown')
            vim.keymap.set('v', '<A-Up>', '<Plug>MoveBlockUp')
            vim.keymap.set('v', '<A-Down>', '<Plug>MoveBlockDown')
        end
    },

    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true,
        opts = {
            check_ts = true,
            fast_wrap = {},
            disable_filetype = { "TelescopePrompt" }
        }
    },

    { "tpope/vim-commentary" }

}
