local M = { "yetone/avante.nvim" }

M.event = VeryLazy
M.version = false
M.opts = {
	provider = "openai",
	openai = {
		endpoint = "https://generativelanguage.googleapis.com/v1beta/openai/",
		model = "gemini-2.0-flash",
		timeout = 30000,
		temperature = 0,
		max_completion_tokens = 8192,
	},
}
M.build = "make"
M.dependencies = {
	"nvim-treesitter/nvim-treesitter",
	"stevearc/dressing.nvim",
	"nvim-lua/plenary.nvim",
	"MunifTanjim/nui.nvim",
	"echasnovski/mini.pick",
	"nvim-telescope/telescope.nvim",
	"hrsh7th/nvim-cmp",
	"ibhagwan/fzf-lua",
	"nvim-tree/nvim-web-devicons",
	{
		"HakonHarnes/img-clip.nvim",
		event = "VeryLazy",
		opts = {
			default = {
				embed_image_as_base64 = false,
				prompt_for_file_name = false,
				drag_and_drop = {
					insert_mode = true,
				},
			},
		},
	},
	{
		'MeanderingProgrammer/render-markdown.nvim',
		opts = {
			file_types = { "markdown", "Avante" },
		},
		ft = { "markdown", "Avante" },
	},
}
