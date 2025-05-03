require("trouble").setup()
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "pyright", "rust_analyzer" },
})

vim.lsp.enable({ "lua_ls", "pyright", "rust_analyzer", "clangd" })

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
		vim.keymap.set("n", "gd", builtin.lsp_definitions, opts("goto definition"))
		vim.keymap.set("n", "gy", builtin.lsp_type_definitions, opts("goto type definition"))
		vim.keymap.set("n", "gi", builtin.lsp_implementations, opts("goto implementation"))

		vim.keymap.set("n", "gr", builtin.lsp_references, opts("find references"))
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("hover over symbol under cursor"))
		vim.keymap.set("n", "<leader>s", builtin.lsp_dynamic_workspace_symbols, opts("dynamic LSP symbols"))

		vim.keymap.set("n", "<leader>vd", function()
			builtin.diagnostics({ bufnr = 0 })
		end, opts("local buffer diagnostics"))

		vim.keymap.set("n", "<leader>vwd", builtin.diagnostics, opts("workspace diagnostics"))

		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump({})
		end, opts("next diagnostic"))

		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump({})
		end, opts("prev diagnostic"))

		vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts("code actions"))
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("rename"))
		vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts("signature help"))
	end,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
vim.lsp.config("lua_ls", {
	capabilities = capabilities,
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
vim.lsp.config("pyright", { capabilities = capabilities })
vim.lsp.config("rust_analyzer", { capabilities = capabilities })
vim.lsp.config("clangd", { capabilities = capabilities })

require("lsp-endhints").setup({
	icons = {
		type = "=> ",
		parameter = "=> ",
		offspec = "=> ", -- hint kind not defined in official LSP spec
		unknown = "=> ", -- hint kind is nil
	},
})

local ks = vim.keymap.set

ks("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
require("outline").setup({})

ks("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
ks("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
ks("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
ks(
	"n",
	"<leader>cl",
	"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
	{ desc = "LSP Definitions / references / ... (Trouble)" }
)
ks("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
ks("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })
