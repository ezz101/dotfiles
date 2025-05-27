vim.cmd("colorscheme " .. os.getenv("THEME"))
vim.opt.termguicolors = true

require("fidget").setup()
require("lualine").setup()
require("snacks").setup({
	input = { enabled = true },
})

vim.cmd("set statuscolumn cursorline")
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[foldopen:,foldclose:,fold: ,foldsep: ,eob: ]]

local builtin = require("statuscol.builtin")
require("statuscol").setup({
	relculright = false,
	segments = {
		{ text = { "%s" }, click = "v:lua.ScSa" },
		{ text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
		{ text = { " " } },
		{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
		{ text = { " " } },
	},
})

require("ufo").setup({
	provider_selector = function(_, _, _)
		return { "treesitter", "indent" }
	end,
})
vim.api.nvim_set_hl(0, "FoldColumn", { fg = "#888888", bg = "NONE" })
vim.api.nvim_set_hl(0, "Folded", { fg = "#888888", bg = "NONE", italic = true })
vim.api.nvim_set_hl(0, "UfoFoldedEllipsis", { fg = "#888888" })
