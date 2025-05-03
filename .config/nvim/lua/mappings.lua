local ks = vim.keymap.set

ks("n", "<leader>'", ":vsplit<CR><C-w>l")
ks("n", '<leader>"', ":split<CR><C-j>l")
ks("n", "<leader>k", ":wa | :q<CR>")
ks("n", "<leader>w", ":wa<CR>")
ks("n", "<leader>c", ":silent make<CR>")
ks("n", "<leader>q", ":if empty(filter(getwininfo(), 'v:val.quickfix')) | copen | else | cclose | endif<CR>")
ks("n", "<leader>]", ":cnext<CR>")
ks("n", "<leader>[", ":cprev<CR><CR>")
ks("n", "<leader>x", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
