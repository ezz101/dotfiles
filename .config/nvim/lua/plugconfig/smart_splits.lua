local M = { "mrjones2014/smart-splits.nvim" }

M.config = function()
	nmap("<C-h>", require("smart-splits").move_cursor_left, "Move cursor left")
	nmap("<C-j>", require("smart-splits").move_cursor_down, "Move cursor down")
	nmap("<C-k>", require("smart-splits").move_cursor_up, "Move cursor up")
	nmap("<C-l>", require("smart-splits").move_cursor_right, "Move cursor right")
	nmap("<C-\\>", require("smart-splits").move_cursor_previous, "Move to previous split")
	nmap("<M-h>", require("smart-splits").resize_left, "Resize split left")
	nmap("<M-j>", require("smart-splits").resize_down, "Resize split down")
	nmap("<M-k>", require("smart-splits").resize_up, "Resize split up")
	nmap("<M-l>", require("smart-splits").resize_right, "Resize split right")
	nmap("<M-H>", require("smart-splits").swap_buf_left, "Swap buffer left")
	nmap("<M-J>", require("smart-splits").swap_buf_down, "Swap buffer down")
	nmap("<M-K>", require("smart-splits").swap_buf_up, "Swap buffer up")
	nmap("<M-L>", require("smart-splits").swap_buf_right, "Swap buffer right")
end

return M
