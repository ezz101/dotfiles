local ks = vim.keymap.set

ks("n", "<M-h>", require("smart-splits").resize_left)
ks("n", "<M-j>", require("smart-splits").resize_down)
ks("n", "<M-k>", require("smart-splits").resize_up)
ks("n", "<M-l>", require("smart-splits").resize_right)

ks("n", "<C-h>", require("smart-splits").move_cursor_left)
ks("n", "<C-j>", require("smart-splits").move_cursor_down)
ks("n", "<C-k>", require("smart-splits").move_cursor_up)
ks("n", "<C-l>", require("smart-splits").move_cursor_right)
ks("n", "<C-\\>", require("smart-splits").move_cursor_previous)

ks("n", "<M-S>h", require("smart-splits").swap_buf_left)
ks("n", "<M-S>j", require("smart-splits").swap_buf_down)
ks("n", "<M-S>k", require("smart-splits").swap_buf_up)
ks("n", "<M-S>l", require("smart-splits").swap_buf_right)
