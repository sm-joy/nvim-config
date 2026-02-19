return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    cmd = { "Neotree", "Ex", "ExRight", "Bex", "Gex" },
    keys = {
        {
            "<leader>fe",
            function()
                require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
            end,
            desc = "Explorer NeoTree (cwd)",
        },
        { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (cwd)", remap = true },
        {
            "<leader>ge",
            function()
                require("neo-tree.command").execute({ source = "git_status", toggle = true })
            end,
            desc = "Git Explorer",
        },
        {
            "<leader>be",
            function()
                require("neo-tree.command").execute({ source = "buffers", toggle = true })
            end,
            desc = "Buffer Explorer",
        },
    },
    deactivate = function()
        vim.cmd([[Neotree close]])
    end,
    init = function()
        vim.api.nvim_create_autocmd("VimEnter", {
            callback = function()
            local argc = vim.fn.argc()
            if argc == 0 then
                vim.cmd("Neotree position=current")
            else
                local arg = vim.fn.argv(0)
                if vim.fn.isdirectory(arg) == 1 then
                vim.cmd("Neotree position=current dir=" .. vim.fn.fnameescape(arg))
                end
            end
            end,
        })
    end,

    opts = {
        sources = { "filesystem", "buffers", "git_status" },
        open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
        filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        },
        window = {
        mappings = {
            ["l"] = "open",
            ["h"] = "close_node",
            ["<space>"] = "none",
            ["q"] = function(state)
                require("neo-tree.command").execute({ action = "close" })
            end,
            ["Y"] = {
                function(state)
                    local node = state.tree:get_node()
                    local path = node:get_id()
                    vim.fn.setreg("+", path, "c")
                end,
                desc = "Copy Path to Clipboard",
            },
            ["O"] = {
                function(state)
                    require("lazy.util").open(state.tree:get_node().path, { system = true })
                end,
                desc = "Open with System Application",
            },
            ["P"] = { "toggle_preview", config = { use_float = false } },
        },
        },
        default_component_configs = {
            indent = {
                with_expanders = true,
                expander_collapsed = "",
                expander_expanded = "",
                expander_highlight = "NeoTreeExpander",
            },
            git_status = {
                symbols = {
                unstaged = "󰄱",
                staged = "󰱒",
                },
            },
        },
        event_handlers = {
            {
                event = "file_opened",
                handler = function()
                    require("neo-tree.command").execute({ action = "close" })
                end,
            },
        },
    },
    config = function(_, opts)
        local function on_move(data)
            Snacks.rename.on_rename_file(data.source, data.destination)
        end

        local events = require("neo-tree.events")
        opts.event_handlers = opts.event_handlers or {}
        vim.list_extend(opts.event_handlers, {
            { event = events.FILE_MOVED, handler = on_move },
            { event = events.FILE_RENAMED, handler = on_move },
        })
        require("neo-tree").setup(opts)
        vim.api.nvim_create_autocmd("TermClose", {
            pattern = "*lazygit",
            callback = function()
                if package.loaded["neo-tree.sources.git_status"] then
                    require("neo-tree.sources.git_status").refresh()
                end
            end,
        })

        vim.api.nvim_create_user_command("Ex",
            function ()
                require("neo-tree.command").execute({
                    toggle = true,
                    dir = vim.uv.cwd(),
                })
                vim.cmd("wincmd p")
                vim.cmd('q')
            end,
            { desc = "Netrw Replacement" }
        )
    end,
}
