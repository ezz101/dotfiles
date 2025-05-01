local M = {"Saecki/crates.nvim"}

M.ft = {"toml"}
M.tag = "stable"

M.opts = {
	completion = {
		cmp = {
			enabled = true,
		},
	},
}

return M
