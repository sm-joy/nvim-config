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

vim.g.maplocalleader = "\\"

local plugins = {
	{ 
		"nvim-telescope/telescope.nvim",
		dependencies = { {'nvim-lua/plenary.nvim'} }
	},
	{
		"nvim-treesitter/nvim-treesitter", 
		build = ":TSUpdate"
	},
	"vim-airline/vim-airline",
	"windwp/nvim-autopairs",
	"stevearc/aerial.nvim",
	{
		"catppuccin/nvim", 
		name = "catppuccin"
	},
	"rebelot/kanagawa.nvim",
	"preservim/nerdtree",
	"ryanoasis/vim-devicons",
	"tiagofumo/vim-nerdtree-syntax-highlight",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",
	"tpope/vim-commentary",
	"matze/vim-move"
}


require("lazy").setup(
    plugins,
    {
	install = { colorscheme = { "habamax" } },
	checker = { enabled = true },
    }
)
