require("mason-null-ls").setup({
	ensure_installed = { "stylua", "ruff", "clang-format", "cpplint" },
})

require("lint").linters_by_ft = {
	python = { "ruff" },
	cpp = { "cpplint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
require("conform").setup({
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff" },
		rust = { "rustfmt", lsp_format = "fallback" },
		cpp = { "clang-format" },
		c = { "clang-format" },
	},
})
