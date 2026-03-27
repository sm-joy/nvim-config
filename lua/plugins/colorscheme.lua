return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    opts = {
        flavor = "frappe",
    },
    config = function(_, opts)
        vim.cmd.colorscheme("catppuccin")
    end,
}
