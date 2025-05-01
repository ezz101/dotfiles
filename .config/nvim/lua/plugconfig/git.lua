local fugitive_config = function()
	nmap("<leader>ga", ":w<CR>:Git add %<CR>", "Stage current file")
	nmap("<leader>gc", ":w<CR>:Git commit<CR>i", "Commit current staged files")
end

local M = {}

table.insert(M, { "lewis6991/gitsigns.nvim", opts = {} })
table.insert(M, { "tpope/vim-fugitive", config = fugitive_config})
table.insert(M, { "sindrets/diffview.nvim" })

return M
