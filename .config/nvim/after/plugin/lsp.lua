local servers =
	{ "lua_ls", "pyright", "rust_analyzer", "clangd", "ts_ls", "tailwindcss", "vue_ls", "gopls", "svelte", "texlab" }

require("crates").setup()
require("tailwind-tools").setup()
require("outline").setup({})
require("nvim-treesitter.configs").setup({
	auto_install = true,
	highlight = { enable = true },
	text_objects = {
		select = {
			enable = {
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
					["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
				},
			},
		},
	},
})
require("trouble").setup()
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = servers,
})
require("lsp-endhints").setup({
	icons = {
		type = "=> ",
		parameter = "=> ",
		offspec = "=> ", -- hint kind not defined in official LSP spec
		unknown = "=> ", -- hint kind is nil
	},
})

vim.lsp.enable(servers)

local ks = vim.keymap.set

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(_)
		local function opts(desc)
			return { desc = "LSP: " .. desc, remap = false }
		end
		-- Use telescope for lsp navigation
		local builtin = require("telescope.builtin")
		-- Uncomment to disable LSP semantic highlighting if it looks ugly!
		--client.server_capabilities.semanticTokensProvider = nil
		ks("n", "gd", builtin.lsp_definitions, opts("goto definition"))
		ks("n", "gy", builtin.lsp_type_definitions, opts("goto type definition"))
		ks("n", "gi", builtin.lsp_implementations, opts("goto implementation"))

		ks("n", "gr", builtin.lsp_references, opts("find references"))
		ks("n", "K", vim.lsp.buf.hover, opts("hover over symbol under cursor"))
		ks("n", "<leader>s", builtin.lsp_dynamic_workspace_symbols, opts("dynamic LSP symbols"))

		ks("n", "<leader>vd", function()
			builtin.diagnostics({ bufnr = 0 })
		end, opts("local buffer diagnostics"))

		ks("n", "<leader>vwd", builtin.diagnostics, opts("workspace diagnostics"))

		ks("n", "[d", function()
			vim.diagnostic.jump({})
		end, opts("next diagnostic"))

		ks("n", "]d", function()
			vim.diagnostic.jump({})
		end, opts("prev diagnostic"))

		ks("n", "<leader>a", vim.lsp.buf.code_action, opts("code actions"))
		ks("n", "<leader>rn", vim.lsp.buf.rename, opts("rename"))
		ks("i", "<C-h>", vim.lsp.buf.signature_help, opts("signature help"))
	end,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local on_attach = function()
	require("nvim-treesitter.configs").setup({
		highlight = { enable = false },
	})
end
for _, server in ipairs(servers) do
	vim.lsp.config(server, { capabilities = capabilities, on_attach = on_attach })
end
vim.lsp.config("rust_analyzer", {
	capabilities = capabilities,
	on_attach = function()
		require("nvim-treesitter.configs").setup({ highlight = { enable = false } })
		-- vim.api.nvim_set_hl(0, "@variable", { fg = "#ebdbb2" })
		-- vim.api.nvim_set_hl(0, "@variable.parameter", { fg = "#ebdbb2" })
	end,
})
vim.lsp.config("lua_ls", {
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					vim.env.VIMRUNTIME,
				},
			},
		},
	},
})

ks("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

ks("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
ks("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
-- ks("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
-- ks(
-- 	"n",
-- 	"<leader>cl",
-- 	"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
-- 	{ desc = "LSP Definitions / references / ... (Trouble)" }
-- )
ks("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
ks("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })
