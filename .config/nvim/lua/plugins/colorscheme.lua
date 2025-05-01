local M = { "rose-pine/neovim" }

M.name = "rose-pine"
M.config = function()
	vim.cmd("colorscheme rose-pine-moon")
end

return M
