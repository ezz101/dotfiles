require("telescope").setup({
	defaults = {
		layout_config = {
			horizontal = {
				preview_width = 0.55,
				results_width = 0.8,
			},
		},
		mappings = {
			i = {
				["<C-h>"] = "which_key",
			},
		},
	},
	pickers = {},
	extensions = {},
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
