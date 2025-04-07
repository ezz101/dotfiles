return {
	"nvim-telescope/telescope.nvim",
	config = function()
		require("telescope").setup({
			require("telescope.themes").get_dropdown({}),
		})
		require("telescope").load_extension("refactoring")
		require("telescope").load_extension("ui-select")
	end,
	dependencies = {
		"nvim-telescope/telescope-fzf-native.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"BurntSushi/ripgrep",
	},
}
