vim.opt.termguicolors = true
vim.cmd("colorscheme gruvbox-material-dark-hard")

require("lualine").setup({ theme = "auto" })

vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

require("fidget").setup()

require("ufo").setup({
	provider_selector = function(_, _, _)
		return { "treesitter", "indent" }
	end,
})
