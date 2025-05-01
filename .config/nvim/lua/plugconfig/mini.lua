local M = { "echasnovski/mini.nvim" }

M.config =function()
	require('mini.comment').setup()
	require('mini.pairs').setup()
	require("mini.surround").setup()
end 

return M
