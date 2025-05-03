vim.g["test#strategy"] = "vimux"

local ks = vim.keymap.set

ks("n", "<leader>t", ":TestNearest<CR>")
ks("n", "<leader>T", ":TestFile<CR>")
ks("n", "<leader>a", ":TestSuite<CR>")
ks("n", "<leader>l", ":TestLast<CR>")
ks("n", "<leader>g", ":TestVisit<CR>")
