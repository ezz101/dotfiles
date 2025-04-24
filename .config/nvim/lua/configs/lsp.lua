local M = {}

local markdown_on_attach = function()
	vim.cmd("set makeprg=pandoc\\ %\\ -o\\ '%:r.pdf'\\ --pdf-engine=xelatex\\ &")
	vim.keymap.set("n", "<leader>S", ":make<CR> :!zathura '%:r.pdf' & <CR><CR>")
end

local setup_pyright = function(capabilities)
vim.lsp.config("pyright", {
	capabilities = capabilities,
	on_attach = function()
	vim.opt_local.tabstop = 4
	vim.opt_local.shiftwidth = 4
	vim.opt_local.expandtab = true
	vim.opt_local.autoindent = true

	vim.api.nvim_buf_set_keymap(
		0,
		"n",
		"<leader>r",
		"<cmd>w<cr><cmd>lua RunPythonFile()<CR>",
		{ noremap = true, silent = true }
	)

end
})
end

local setup_rust_analyzer = function()
	vim.lsp.config("rust_analyzer", {
		capabilities = capabilities,
		on_attach = function()
			vim.lsp.enable("rust-analyzer")
			vim.cmd("set makeprg=cargo\\ build")
		end
	})
end

local setup_yamlls = function(capabilities)
vim.lsp.config("yaml_ls", {
	capabilities = capabilities,
	settings = {
		yaml = {
			schemas = {
				["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
				["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/v1.32.1-standalone-strict/all.json"] = {
					"/*.k8s.yaml",
					"/*.k8s.yml",
					"/*.kubernetes.yaml",
					"/*.kubernetes.yml",
					"/*deployment*.yaml",
					"/*service*.yaml",
					"/*ingress*.yaml",
					"/*pod*.yaml",
					"/*configmap*.yaml",
					"/*secret*.yaml",
					"/*statefulset*.yaml",
					"/*daemonset*.yaml",
					"/*job*.yaml",
					"/*cronjob*.yaml",
				},
			},
		},
	},
})
end

local setup_clangd = function(capabilities)
	vim.lsp.config("clangd", {
		cmd = { 'clangd' },
		root_markers = { '.clangd', 'compile_commands.json' },
		filetypes = { 'c', 'cpp' },
		capabilities = capabilities,
		on_attach = function ()
			vim.opt_local.tabstop = 2
			vim.opt_local.shiftwidth = 2
			vim.opt_local.expandtab = true
			vim.opt_local.autoindent = true
			vim.opt_local.makeprg = "cmake -B build"
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = { "*.c", "*.cpp", "*.h" },
				callback = function()
					vim.lsp.buf.format({ async = false })
				end,
			})
		end
	})
end

M.servers = {
	"rust_analyzer",
	"clangd",
	"yamlls",
	"lua_ls",
	"texlab",
	"pyright",
	"cmake",
	"ts_ls",
	"docker_compose_language_service",
	"dockerls",
	"volar",
	"bashls",
}

M.configs = function()
			vim.lsp.enable(servers)

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			for _, lsp in ipairs(servers) do
				vim.lsp.config(lsp, {capabilities = capabilities})
			end

			vim.lsp.config("rust_analyzer", {
				capabailities = capabilities,
				on_attach = rust.on_attach,
			})

			vim.lsp.config("pyright", {
				capabailities = capabilities,
				on_attach = python.on_attach,
			})

			vim.lsp.config("clangd", {
				capabailities = capabilities,
				on_attach = cpp.on_attach,
				table.unpack(cpp.config)
			})

			vim.lsp.config("yaml_ls", {
				capabailities = capabilities,
				on_attach = yaml.on_attach,
				table.unpack(yaml.config)
			})

			nmap("gD", vim.lsp.buf.declaration, "Go to declaration")
			nmap("ga", vim.lsp.buf.code_action, "Code actions")
			nmap("<leader>h", vim.lsp.buf.signature_help, "Show signature help")
			nmap("<leader>D", vim.diagnostic.open_float, "Show diagnostics in floating window")
			nmap("K", vim.lsp.buf.hover, "Show hover information")
			nmap("<M-r>", vim.lsp.buf.rename, "Rename symbol")
end

M.hints_opts = {
			icons = {
				type = "=> ",
				parameter = "=> ",
				offspec = "=> ",
				unknown = "=> ",
			},
		}

return M
