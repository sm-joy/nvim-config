vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opts = { noremap = true, silent = true }

vim.keymap.set('n', "<A-Left>",  function() vim.cmd("wincmd h") end, opts)
vim.keymap.set('n', "<A-Right>", function() vim.cmd("wincmd l") end, opts)
vim.keymap.set('n', "<A-Up>",    function() vim.cmd("wincmd k") end, opts)
vim.keymap.set('n', "<A-Down>",  function() vim.cmd("wincmd j") end, opts)

vim.keymap.set('v', "<C-c>", function() vim.cmd('normal! "+y') end, opts)
vim.keymap.set('n', "<C-c>", function() vim.cmd('normal! "+yy') end, opts)

-- terminal remaps
vim.keymap.set('n', "<leader>tb",     function() vim.cmd("belowright split term://pwsh | resize 7<CR>") end, opts )
vim.keymap.set('n', "<leader>tr",     function() vim.cmd("topleft    split term://pwsh | resize 7<CR>") end, opts )
vim.keymap.set('n', "<leader>ta",     function() vim.cmd("aboveleft  split term://pwsh | resize 7<CR>") end, opts )
vim.keymap.set('n', "<leader>tl",     function() vim.cmd("leftbelow  split term://pwsh | resize 7<CR>") end, opts )
vim.keymap.set('t', "<Esc>",          function() vim.cmd("<C-\\><C-n>")                                 end, opts)


vim.keymap.set('n', "<leader>ex",
    function()
        vim.cmd("NERDTreeToggle")
        vim.cmd("wincmd p")
        vim.cmd('q')
    end,
    opts)

vim.keymap.set('n', "<A-d>", function() vim.cmd("normal! yyp")  end, opts)
vim.keymap.set('n', "<C-a>", function() vim.cmd("normal! ggVG") end, opts)

vim.keymap.set('n', '<leader>sb', function() vim.cmd("AerialToggle") end, opts)

vim.keymap.set('v', '<C-/>',  function() vim.cmd("gcc") end, opts)

vim.keymap.set('i', "<A-Up>",   function() vim.cmd("m .-2<CR>==")   end, opts)
vim.keymap.set('i', "<A-Down>", function() vim.cmd("m .+1<CR>==cc") end, opts)


vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true
})

local warning_error_text_off = true

function ToggleWarningError()
    warning_error_text_off = not warning_error_text_off
    vim.diagnostic.config({ virtual_text = not warning_error_text_off })
end

vim.api.nvim_set_keymap('n', "<leader>w", ":lua ToggleWarningError()<CR>", opts)

