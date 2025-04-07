local sources = {
	"black",
	"prettierd",
	"stylua",
	"ruff",
	"clang-format",
	"cpplint",
	"eslint_d",
}

local get_sources = function()
	return {
		-- formatters
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.formatting.prettierd,
		require("null-ls").builtins.formatting.black,
		require("null-ls").builtins.formatting.clang_format,
		require("null-ls").builtins.formatting.cmake_format,

		-- linters
		require("none-ls.diagnostics.eslint_d"),
		require("none-ls.diagnostics.ruff"),
		-- require("none-ls.diagnostics.cpplint"),
		-- require("none-ls.diagnostics.cmake-lint"),
	}
end

local format_on_save = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({
			group = vim.api.nvim_create_augroup("LspFormatting", {}),
			buffer = bufnr,
		})
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("LspFormatting", {}),
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format()
			end,
		})
	end
end

return {
	{
		"nvimtools/none-ls.nvim",
		config = function()
			require("null-ls").setup({
				on_attach = format_on_save,
				sources = get_sources(),
			})
		end,
		dependencies = {
			{ "jay-babu/mason-null-ls.nvim", opts = { ensure_installed = sources } },
			{ "nvimtools/none-ls-extras.nvim" },
		},
	},
}
