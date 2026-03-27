return {
	"lervag/vimtex",
	lazy = false,
	init = function()
        vim.g.vimtex_format_enabled = 1
		vim.g.vimtex_view_method = "general"
		vim.g.vimtex_view_general_viewer = "SumatraPDF"
		vim.g.vimtex_view_general_options = "-reuse-instance @tex @line @pdf"
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_compiler_latexmk = {
            out_dir = "build",
			continuous = 1,
			options = {
				"-pdf",
				"-interaction=nonstopmode",
				"-file-line-error",
				"-shell-escape",
			},
		}

		vim.g.vimtex_complete_enabled = 0
		vim.g.vimtex_mappings_enabled = 0
		vim.g.vimtex_quickfix_mode = 0

		vim.opt.conceallevel = 2

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "tex",
			callback = function()
				local opts = { buffer = true, noremap = true, silent = true }
				vim.keymap.set("n", "<leader>ll", "<cmd>VimtexCompile<cr>", opts)
				vim.keymap.set("n", "<leader>ls", "<cmd>VimtexCompileSS<cr>", opts)
				vim.keymap.set("n", "<leader>lv", "<cmd>VimtexView<cr>", opts)
				vim.keymap.set("n", "<leader>lc", "<cmd>VimtexClean<cr>", opts)
				vim.keymap.set("n", "<leader>le", "<cmd>VimtexErrors<cr>", opts)
				vim.keymap.set("n", "<leader>lt", "<cmd>VimtexTocToggle<cr>", opts)
			end,
		})
	end,
}
