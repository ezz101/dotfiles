local M = { 'stevearc/oil.nvim' }

M.dependencies = "nvim-tree/nvim-web-devicons"
M.lazy = false

M.config = function()
	require("oil").setup({
		float = {
			padding = 2,
			max_width = 100,
			max_height = 0,
			border = "rounded",
			win_options = {
				winblend = 0,
			},
			preview_split = "right",
		},
	})
	Nmap(
		"<leader>f",
		function()
			pcall(vim.write)
			require("oil").toggle_float()
		end,
		{ desc = "Toggle file explorer (oil)" }
	)
end

return M
