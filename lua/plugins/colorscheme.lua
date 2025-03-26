color = color or "kanagawa"
vim.cmd.colorscheme(color)

require("catppuccin").setup {
    flavor = "frappe",
    color_overrides = {
        all = { text = "#ffffff" },
        frappe = {
        },
    }
}
