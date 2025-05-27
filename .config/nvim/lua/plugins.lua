return {
	-- LSP Support
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	"folke/trouble.nvim",
	"chrisgrieser/nvim-lsp-endhints",

	-- Completion
	"onsails/lspkind.nvim",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-path",
	"saadparwaiz1/cmp_luasnip",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lua",
	"hrsh7th/cmp-nvim-lsp-signature-help",
	-- "ray-x/lsp_signature.nvim",
	"L3MON4D3/LuaSnip",
	"rafamadriz/friendly-snippets",

	-- Formatting
	"nvimtools/none-ls.nvim", -- required by Mason
	{ "jay-babu/mason-null-ls.nvim", event = { "BufReadPre", "BufNewFile" } },
	"stevearc/conform.nvim",
	"mfussenegger/nvim-lint",

	-- Debugging
	"jay-babu/mason-nvim-dap.nvim",
	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",
	"mfussenegger/nvim-dap-python",
	"SGauvin/ctest-telescope.nvim",
	-- { "mrcjkb/rustaceanvim", lazy = false },

	-- Testing
	"vim-test/vim-test",
	"preservim/vimux",

	-- UI
	"tinted-theming/tinted-vim",
	"nvim-lualine/lualine.nvim",
	"kevinhwang91/nvim-ufo",
	"luukvbaal/statuscol.nvim",
	"j-hui/fidget.nvim",
	"folke/snacks.nvim",

	-- Navigation
	"stevearc/oil.nvim",
	"mrjones2014/smart-splits.nvim",
	"nvim-telescope/telescope.nvim",
	"nvim-telescope/telescope-ui-select.nvim",
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

	-- Symbols
	{ "nvim-treesitter/nvim-treesitter", build = "TSBuild" },
	"nvim-treesitter/nvim-treesitter-textobjects",
	"hedyhli/outline.nvim",

	-- Git
	"tpope/vim-fugitive",
	"lewis6991/gitsigns.nvim",

	-- AI
	"github/copilot.vim",
	{ "yetone/avante.nvim", build = "make" },

	-- Web UI
	-- "princejoogie/tailwind-highlight.nvim",
	"windwp/nvim-ts-autotag",
	{ "luckasRanarison/tailwind-tools.nvim", build = ":UpdateRemotePlugins" },

	-- Helpers
	{ "windwp/nvim-autopairs", event = "InsertEnter", config = true },
	"ethanholz/nvim-lastplace",
	"ThePrimeagen/refactoring.nvim",
	"folke/which-key.nvim",
	"numToStr/Comment.nvim",
	"saecki/crates.nvim",

	-- Dependencies
	"nvim-lua/plenary.nvim",
	"nvim-tree/nvim-web-devicons",
	"mrjones2014/legendary.nvim",
	"kevinhwang91/promise-async",
	"nvim-neotest/nvim-nio",
	"MunifTanjim/nui.nvim",
}
