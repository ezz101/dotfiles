require("gitsigns").setup()

local ks = vim.keymap.set

ks("n", "<leader>va", ":silent w | :silent G add %<CR>")
ks("n", "<leader>vc", ":silent G commit<CR>")
