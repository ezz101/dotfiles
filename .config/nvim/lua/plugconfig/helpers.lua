local M = {}

local snack = {"folke/snacks.nvim"}
snack.opts = { input = { enabled = true } }
table.insert(M, snack)

-- local treesitter = {"nvim-treesitter/nvim-treesitter"}
-- treesitter.build = ":TSUpdate",
-- treesitter.opts = {
-- 	auto_install = true,
-- 	highlight = { enable = true },
-- 	indent = { enable = true },
-- }
-- 
-- table.insert(M, treesitter)

table.insert(M, {"folke/which-key.nvim"})
table.insert(M, { "ethanholz/nvim-lastplace", opts = {} })

return M
