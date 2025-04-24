local M = {}

M.opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff" },
			rust = { "rustfmt" },
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			c = {"clang-format"},
			cpp = {"clang-format"},
		},
}

return M
