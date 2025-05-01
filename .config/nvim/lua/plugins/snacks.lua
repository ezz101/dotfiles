local M = { "folke/snacks.nvim" }

M.priority = 1000
M.lazy = false
M.opts = {}

M.opts.bigfile = {enabled = true}
M.opts.input = {enabled = true}
M.opts.words = {enabled = true}

return M
