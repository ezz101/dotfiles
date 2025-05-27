local ks = vim.keymap.set

require("telescope").load_extension("refactoring")

vim.keymap.set({ "n", "x" }, "<leader>rr", function()
	require("telescope").extensions.refactoring.refactors()
end)
ks("x", "<leader>re", ":Refactor extract ")
ks("x", "<leader>rf", ":Refactor extract_to_file ")
ks("x", "<leader>rv", ":Refactor extract_var ")
ks({ "n", "x" }, "<leader>ri", ":Refactor inline_var")
ks("n", "<leader>rI", ":Refactor inline_func")
ks("n", "<leader>rb", ":Refactor extract_block")
ks("n", "<leader>rbf", ":Refactor extract_block_to_file")
