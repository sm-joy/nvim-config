return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    lazy = false,

    config = function()
        vim.keymap.set('n', "<leader>nf", function() vim.cmd("NERDTreeFocus")  end, opts)
        vim.keymap.set('n', "<leader>nn", function() vim.cmd("NERDTree")       end, opts)
        vim.keymap.set('n', "<leader>nt", function() vim.cmd("NERDTreeToggle") end, opts)
        vim.keymap.set('n', "<leader>ns", function() vim.cmd("NERDTreeFind")   end, opts)
    end
}
