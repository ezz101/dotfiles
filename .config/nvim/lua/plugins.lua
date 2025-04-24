return {
	-- LSP
	{
		"williamboman/mason-lspconfig.nvim",
		opts = { ensure_installed = require("configs.lsp").servers },
		dependencies = { "williamboman/mason.nvim", opts = {}}
	},
	{
		"neovim/nvim-lspconfig",
		config = require('configs.lsp').config
	},
	{
		"chrisgrieser/nvim-lsp-endhints",
		event = "LspAttach",
		opts = require("configs.lsp").hints_opts,
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "InsertEnter",
		opts = {},
	},

	-- Colorscheme
	{
		"rose-pine/neovim",
		priority = 1000,
		dependencies = {
			-- "feline-nvim/feline.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = require("configs.colorscheme").config
	},

	-- Compeletions
	{
		"hrsh7th/nvim-cmp",
		config = require("configs.completions").cmp_config,
		dependencies = {
			"onsails/lspkind.nvim",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"codota/tabnine-nvim",
		build = "./dl_binaries.sh",
		config = require("configs.completions").tabnine_config,
	},

	-- Crates
	{
		"Saecki/crates.nvim",
		ft = { "toml" },
		tag = "stable",
		opts = require("configs.crates").opts,
	},

	-- Dap
	{
		"rcarriga/nvim-dap-ui",
		config = require("configs.dap").config,
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "mfussenegger/nvim-dap" },
			{ "nvim-neotest/nvim-nio" },
			{
				"jay-babu/mason-nvim-dap.nvim",
				opts = require("configs.dap").mason_opts,
			}
		},
		{
			"mfussenegger/nvim-dap-python"
		},
	},

	-- Formatting
	{
		"stevearc/conform.nvim",
		opts = require("configs.formatting").opts,
	},

	-- Git
	{ "lewis6991/gitsigns.nvim", opts = {} },
	{ "tpope/vim-fugitive", config = require("configs.git").fugitive_config},
	{ "sindrets/diffview.nvim" },
	{
		"Vigemus/iron.nvim",
		config = require('configs.iron').config,
	},
	{
		"echasnovski/mini.nvim",
		config = require("configs.mini").config,
	},
	{
		"ThePrimeagen/refactoring.nvim",
		config = require("configs.refactoring").config
	},
	{
		"mrjones2014/smart-splits.nvim",
		config = require("configs.smart-splits").config
	},
	{
		"nvim-telescope/telescope.nvim",
		opts = require("configs.telescope").otps,
		config = require('configs.telescope').config,
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"BurntSushi/ripgrep",
		},
	},
	{
		"vim-test/vim-test",
		dependencies = "preservim/vimux",
		config = require("configs.vim-test").config
	},
	{
		"stevearc/oil.nvim",
		config = require("configs.oil").config,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = require("configs.harpoon").config
	},
	{ "folke/snacks.nvim", opts = require("configs.extras").snacks_opts },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = require("configs.extras").treesitter_opts,
	},
	{"folke/which-key.nvim"},
	{
		"ethanholz/nvim-lastplace",
		opts = {},
	},
}
