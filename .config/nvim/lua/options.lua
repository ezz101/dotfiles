vim.lsp.inlay_hint.enable()
vim.diagnostic.config({ virtual_text = true })
vim.g.mapleader = " "

local opt = vim.opt
opt.clipboard = "unnamedplus"
opt.number = true
opt.numberwidth = 3
opt.relativenumber = true

opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2

opt.wrap = false
opt.colorcolumn = "80"
opt.scrolloff = 5

opt.list = true
opt.listchars = {
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

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.cls",
	callback = function()
		vim.bo.filetype = "tex"
	end,
})
