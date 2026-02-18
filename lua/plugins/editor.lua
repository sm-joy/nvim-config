return {
	{ "matze/vim-move" },

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