function Nmap(key, func, opts)
	vim.keymap.set("n", key, func, opts)
end

function Imap(key, func, opts)
	vim.keymap.set("i", key, func, opts)
end

function Xmap(key, func, opts)
	vim.keymap.set("x", key, func, opts)
end

vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end


vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup({
	spec = {
		require 'plugins.coc',
		require 'plugins.colorscheme',
		require 'plugins.avante',
		require 'plugins.dap',
		require 'plugins.git',
		require 'plugins.mini',
		require 'plugins.oil',
		require 'plugins.smart_splits',
		require 'plugins.refactoring',
		require 'plugins.telescope',
		require 'plugins.harpoon',
		require 'plugins.whichkey',
		require 'plugins.vimtest',
		require 'plugins.snacks',
	},
	install = { colorscheme = { "habamax" } },
	checker = { enabled = true },
})

require("options")
require("keymaps")
