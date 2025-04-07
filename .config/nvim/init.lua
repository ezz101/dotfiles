vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

if not (vim.uv or vim.loop).fs_stat(vim.fn.stdpath("data") .. "/lazy/lazy.nvim") then
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{
				"Failed to clone lazy.nvim:\n",
				"ErrorMsg",
			},
			{
				vim.fn.system({
					"git",
					"clone",
					"--filter=blob:none",
					"--branch=stable",
					"https://github.com/folke/lazy.nvim.git",
					vim.fn.stdpath("data") .. "/lazy/lazy.nvim",
				}),
				"WarningMsg",
			},
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

require("lazy").setup({
	install = { colorscheme = { "rose-pine" } },
	spec = { import = "plugins" },
	checker = { enabled = true, notify = false },
})

require("options")
require("keymaps")
dofile(vim.fn.stdpath("config") .. "/after/options.lua")
dofile(vim.fn.stdpath("config") .. "/after/keymaps.lua")
