vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- require("supermaven-nvim").setup({})
require("chatgpt").setup({
	openai_params = {
		model = "deepseek-chat",
		frequency_penalty = 0,
		presence_penalty = 0,
		max_tokens = 4095,
		temperature = 0.2,
		top_p = 0.1,
		n = 1,
	},
})

local cmp = require("cmp")
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	mapping = {
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	},
	sources = {
		-- { name = "supermaven" },
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "luasnip" },
		{ name = "nvim_lsp_signature_help" },
		{
			name = "spell",
			option = {
				keep_all_entries = false,
				enable_in_context = function()
					return true
				end,
			},
		},
	},
	{
		name = "buffer",
	},
	formatting = {
		format = require("lspkind").cmp_format({
			mode = "symbol",
			maxwidth = { menu = 50, abbr = 50 },
			ellipsis_char = "...",
			show_labelDetails = true,
			symbol_map = { Supermaven = "" },
		}),
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
})
