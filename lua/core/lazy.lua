local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)


local plugins = {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
            { "nvim-lua/plenary.nvim" }
        },
        lazy = true,
        cmd = "Telescope"
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
        lazy = true,
        event = "BufReadPost"
	},
	{ "hrsh7th/nvim-cmp" },
	{ "L3MON4D3/LuaSnip" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{
        "neovim/nvim-lspconfig",
        lazy = true,
        event = "BufReadPre",
    },
	{
        "williamboman/mason-lspconfig.nvim",
        lazy = true,
        event = "BufReadPre",
    },
	{ "preservim/nerdtree" },
	{
		"catppuccin/nvim",
		name = "catppuccin"
	},
	{ "matze/vim-move" },
	{ "stevearc/aerial.nvim" },
	{ "tpope/vim-commentary" },
	{ "windwp/nvim-autopairs" },
	{ "rebelot/kanagawa.nvim" },
	{ "ryanoasis/vim-devicons" },
	{ "vim-airline/vim-airline" },
	{
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall" }
    },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "tiagofumo/vim-nerdtree-syntax-highlight" },
}


require("lazy").setup(plugins,
{
    install = { colorscheme = { "habamax" } },
    checker = { enabled = true },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
