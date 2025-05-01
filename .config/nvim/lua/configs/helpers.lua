local M = {}

local snacks = {"folke/snacks.nvim"}
snacks.opts = { input = { enabled = true } }
table.insert(M, snacks)

local treesitter = { "nvim-treesitter/nvim-treesitter" }
treesitter.build = "TSUpdate"
treesitter.treesitter_opts = {
	auto_install = true,
	highlight = { enable = true },
	indent = { enable = true },
}
table.insert(M, treesitter)

table.insert(M, { "folke/which-key.nvim" })

table.insert(M, { "ethanholz/nvim-lastplace", opts = {} })

return M

/003   crates.lua
/011   dap.lua
/006   git.lua
/010   harpoon.lua
/008   helpers.lua
/005   iron.lua
/007   mini.lua
/013   oil.lua
/009   refactoring.lua
/004   smart_splits.lua
/001   telescope.lua
/014   vim-test.lua
