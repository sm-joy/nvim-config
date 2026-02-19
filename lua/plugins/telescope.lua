return {
	"nvim-telescope/telescope.nvim",
	version = '*',
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	keys = {
		{ "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
		{ "<C-f>fg",    function() require("telescope.builtin").git_files() end,  desc = "Git files" },
		{
			"<leader>fs",
			function()
				require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
			end,
			desc = "Grep string"
		},
	},
	config = function()
		require("telescope").setup({
			defaults = {
				file_ignore_patterns = { "%.exe", "%.obj", "%.o", "%.dll", "node_modules", "%.git" },
			},
			extensions = { fzf = {} }
		})
		require("telescope").load_extension("fzf")
	end,
}
