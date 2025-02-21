require("nvim-autopairs").setup({
    check_ts = true,
    fast_wrap = {},
    disable_filetype = { "TelescopePrompt" }
})


local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")

npairs.add_rules({
    --Rule("<", ">")
})
