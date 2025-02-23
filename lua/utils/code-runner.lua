local M = {}

M.config =
{
    split_term_style = "vertical",
    split_term_resize_cmd = "vertical resize 40"
}

function M.run_in_terminal(command)
    vim.cmd('rightbelow vnew')
    if M.config.split_term_resize_cmd then
        vim.cmd(M.config.split_term_resize_cmd)
    end

    vim.cmd("term " .. command)
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.cmd('startinsert')

    vim.api.nvim_create_autocmd(
    "BufEnter",
    {
        buffer = 0,
        command = 'startinsert'
    })
end

function M.compile_and_run(lang, clean)
    local filename = vim.fn.expand('%')
    local exe = vim.fn.expand("%:t:r")
    local compiler = lang == "c" and "gcc" or "g++"
    local command = string.format("%s %s -o %s.exe && %s.exe", compiler, filename, exe, exe)

    if clean then
        command = command .. string.format(" && del %s.exe", exe)
    end

    M.run_in_terminal(command)
end

function M.run_py()
    local filename = vim.fn.expand('%')
    local command = string.format("python %s", filename)
    M.run_in_terminal(command)
end


local augroup = vim.api.nvim_create_augroup("CodeRunnerToolKit", { clear = true })

vim.api.nvim_create_autocmd(
"FileType",
{
    pattern = "cpp",
    group = augroup,
    callback = function()
        vim.keymap.set('n', "<leader>rr", function() M.compile_and_run("c++", false) end, { buffer = true })
        vim.keymap.set('n', "<leader>rd", function() M.compile_and_run("c++", true)  end, { buffer = true })
    end
})

vim.api.nvim_create_autocmd(
"FileType",
{
    pattern = 'c',
    group = augroup,
    callback = function()
        vim.keymap.set('n', "<leader>rr", function() M.compile_and_run("c", false) end, { buffer = true })
        vim.keymap.set('n', "<leader>rd", function() M.compile_and_run("c", true)  end, { buffer = true })
   end
})


vim.api.nvim_create_autocmd(
"FileType",
{
    pattern = "python",
    group = augroup,
    callback = function()
        vim.keymap.set('n', "<leader>rr", M.run_py, { buffer = true })
   end
})

return M

