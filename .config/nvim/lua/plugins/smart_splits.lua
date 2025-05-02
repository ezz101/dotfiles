local M = { 'mrjones2014/smart-splits.nvim' }

M.opts = {
	ignored_buftypes = {
		'nofile',
		'quickfix',
		'prompt',
	},
	ignored_filetypes = { 'NvimTree' },
	default_amount = 3,
	at_edge = 'wrap',
	float_win_behavior = 'previous',
	move_cursor_same_row = false,
	cursor_follows_swapped_bufs = false,
	resize_mode = {
		quit_key = '<ESC>',
		resize_keys = { 'h', 'j', 'k', 'l' },
		silent = false,
		hooks = {
			on_enter = nil,
			on_leave = nil,
		},
	},
	ignored_events = {
		'BufEnter',
		'WinEnter',
	},
	multiplexer_integration = nil,
	disable_multiplexer_nav_when_zoomed = true,
	kitty_password = nil,
	log_level = 'info',
}

M.config = function()
	Nmap("<C-h>", require("smart-splits").move_cursor_left, { desc = "Move cursor left" })
	Nmap("<C-j>", require("smart-splits").move_cursor_down, { desc = "Move cursor down" })
	Nmap("<C-k>", require("smart-splits").move_cursor_up, { desc = "Move cursor up" })
	Nmap("<C-l>", require("smart-splits").move_cursor_right, { desc = "Move cursor right" })
	Nmap("<C-\\>", require("smart-splits").move_cursor_previous, { desc = "Move to previous split" })
	Nmap("<M-h>", require("smart-splits").resize_left, { desc = "Resize split left" })
	Nmap("<M-j>", require("smart-splits").resize_down, { desc = "Resize split down" })
	Nmap("<M-k>", require("smart-splits").resize_up, { desc = "Resize split up" })
	Nmap("<M-l>", require("smart-splits").resize_right, { desc = "Resize split right" })
	Nmap("<M-H>", require("smart-splits").swap_buf_left, { desc = "Swap buffer left" })
	Nmap("<M-J>", require("smart-splits").swap_buf_down, { desc = "Swap buffer down" })
	Nmap("<M-K>", require("smart-splits").swap_buf_up, { desc = "Swap buffer up" })
	Nmap("<M-L>", require("smart-splits").swap_buf_right, { desc = "Swap buffer right" })
end


return M
