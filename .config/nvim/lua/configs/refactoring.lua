local M = {}

M.config = function()
		nmap("<M-e>b", ":Refactor extract_block<cr>", "Extract block")
		nmap("<M-e>", ":Refactor extract_block_to_file<cr>", "Extract block to file")
		nmap("<M-i>f", ":Refactor inline_func<cr>", "Inline function")
		vim.keymap.set("x", "<A-e>v", ":Refactor extract_var<cr>")
		vim.keymap.set("x", "<A-e>f", ":Refactor extract_to_file<cr>")
		vim.keymap.set({ "n", "x" }, "<A-i>v", ":Refactor inline_var<cr>dd")
		vim.keymap.set({ "n", "x" }, "<A-a>", require("telescope").extensions.refactoring.refactors)
	end

return M
