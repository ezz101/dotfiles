local M = {"rose-pine/neovim"}

M.priority = 1000
M.dependencies = {
	-- "feline-nvim/feline.nvim",
	"nvim-tree/nvim-web-devicons",
}

M.config = function()
	vim.cmd("colorscheme rose-pine-moon")
end

return M
