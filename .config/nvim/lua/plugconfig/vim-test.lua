local M = { "vim-test/vim-test" }

M.dependencies = "preservim/vimux"

M.config = function()
		vim.g["test#strategy"] = "vimux"
		nmap("<leader>tn", ":w<CR>:TestNearest<cr>", "Run nearest test")
		nmap("<leader>tf", ":w<CR>:TestFile<cr>", "Run tests in file")
		nmap("<leader>ts", ":w<CR>:TestSuite<cr>", "Run test suite")
		nmap("<leader>tl", ":w<CR>:TestLast<cr>", "Run last test")
		nmap("<leader>tg", ":w<CR>:TestVisit<cr>", "Visit last test")
	end

return M
