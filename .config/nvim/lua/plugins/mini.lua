local M = { "echasnovski/mini.nvim" }

M.version = "*"

M.config = function()
	require("mini.pairs")
	require("mini.surround")
	require("mini.comment")
	require("mini.move")
end

return M
