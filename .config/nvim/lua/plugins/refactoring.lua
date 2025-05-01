local M = { "ThePrimeagen/refactoring.nvim" }

M.dependencies = {
	"nvim-lua/plenary.nvim",
	"nvim-treesitter/nvim-treesitter",
}
M.lazy = false
M.opts = {}
M.config = function()
	require("refactoring").setup()

	Xmap("<leader>re", ":Refactor extract<CR>")
	Xmap("<leader>rf", ":Refactor extract_to_file <CR>")
	Xmap("<leader>rv", ":Refactor extract_var <CR>")
	Nmap("<leader>ri", ":Refactor inline_var<CR>")
	Nmap("<leader>rI", ":Refactor inline_func<CR>")
	Nmap("<leader>rb", ":Refactor extract_block<CR>")
	Nmap("<leader>rbf", ":Refactor extract_block_to_file<CR>")
end

return M
