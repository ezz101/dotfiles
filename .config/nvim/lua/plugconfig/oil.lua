local M = {}

M.config = function()
		require("oil").setup({
			lsp_file_methods = {
				autosave_changes = true,
			},
			view_options = {
				show_hidden = true,
			},
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
    nmap("<leader>f", require("oil").toggle_float, "Toggle file explorer (oil)")
  end

return M
