return {
	"nvim-telescope/telescope.nvim", version = '*',
    dependencies = {
		"nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
	lazy = true,
	config = function()
		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })

		vim.keymap.set("n", "<C-f>fg", builtin.git_files)

		vim.keymap.set("n", "<leader>fs", function()
			builtin.grep_string({
				search = vim.fn.input("Grep > "),
			})
		end)
  	end,
}
