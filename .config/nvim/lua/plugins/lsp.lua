local lspservers = {
	"rust_analyzer",
	"clangd",
	"lua_ls",
	"texlab",
	"pyright",
	"cmake",
	"ts_ls",
	"docker_compose_language_service",
	"dockerls",
	"yamlls",
	"volar",
	"bashls",
}

local clangdcmd = { "clangd", "--compile-commands-dir=build" }

local yamlls_settings = {
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
}

return {
	{ "williamboman/mason.nvim", opts = { ensure_installed = { "trivy" } } },
	{
		"williamboman/mason-lspconfig.nvim",
		opts = { ensure_installed = lspservers },
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			inlay_hints = { enabled = true },
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			for _, server in ipairs(lspservers) do
				lspconfig[server].setup({ capabilities = capabilities })
			end

			lspconfig.clangd.setup({ capabilities = capabilities, cmd = clangdcmd })
			lspconfig.yamlls.setup({ capabilities = capabilities, settings = yamlls_settings })
		end,
	},
}
