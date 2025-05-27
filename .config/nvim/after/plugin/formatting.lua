require("mason-null-ls").setup({
	ensure_installed = {
		"stylua",
		"ruff",
		"clang-format",
		"cpplint",
		"prettierd",
		"eslint_d",
		"gofumpt",
		"goimports-reviser",
	},
})

require("lint").linters_by_ft = {
	python = { "ruff" },
	cpp = { "cpplint" },
	javascript = { "eslint_d" },
	-- typescript = { "eslint_d" },
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
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		vue = { "prettierd" },
		html = { "prettierd" },
		css = { "prettierd" },
		go = { "gofumpt", "goimports-reviser" },
	},
})
