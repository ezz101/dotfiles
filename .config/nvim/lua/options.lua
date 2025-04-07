vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

vim.opt.wrap = false
vim.opt.colorcolumn = "80"
vim.opt.scrolloff = 5
vim.opt.termguicolors = true

vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
	pattern = "*",
	command = "normal! zR",
})

vim.g.mapleader = " "

-- Enable list characters
vim.opt.list = true
vim.opt.listchars = {
	tab = "· ",
	trail = "·",
	extends = "»",
	precedes = "«",
	nbsp = "░",
}

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*/.config/i3/config.d/*" },
	callback = function()
		if vim.bo.filetype ~= "oil" then -- Prevents overriding Oil.nvim
			vim.cmd("set filetype=i3config")
		end
	end,
})
