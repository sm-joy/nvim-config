vim.opt.nu = true
vim.opt.relativenumber = true
vim.o.autoindent = true
vim.o.smarttab = true
vim.opt.mouse = 'a'
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldlevel = 99


--vim.cmd([[ autocmd StdinReadPre * let s:std_in=1]])
--vim.cmd([[ autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif]])

vim.cmd([[ autocmd BufRead,BufNewFile *.hpp set filetype=cpp ]])
vim.cmd([[ autocmd BufRead,BufNewFile *.h   set filetype=c   ]])

--vim.g.loaded_netrw       = 1
--vim.g.loaded_netrwPlugin = 1


