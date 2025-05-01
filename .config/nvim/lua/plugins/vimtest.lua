local M = { "vim-test/vim-test" }

M.dependencies = "preservim/vimux"

M.config = function()
	vim.g["test#strategy"] = "vimux"
end

return M
