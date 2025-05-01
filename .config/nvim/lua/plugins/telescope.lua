local M = { "nvim-telescope/telescope.nvim" }

M.opts = {
	defaults = {
		layout_config = {
			horizontal = {
				preview_width = 0.6,
				results_width = 0.8,
			},
		},
	}
}

M.config = function()
	require("telescope").load_extension("ui-select")
	require("telescope").load_extension("refactoring")

	Nmap("gd", require("telescope.builtin").lsp_definitions, { desc = "Go to definition" })
	Nmap("gs", require("telescope.builtin").lsp_document_symbols, { desc = "List document symbols" })
	Nmap("gS", require("telescope.builtin").lsp_dynamic_workspace_symbols, { desc = "List workspace symbols" })
	Nmap("gi", require("telescope.builtin").lsp_implementations, { desc = "Go to implementation" })
	Nmap("gr", require("telescope.builtin").lsp_references, { desc = "Find references" })
	Nmap("<leader>F", require("telescope.builtin").find_files, { desc = "Find files" })
	Nmap("<leader>G", require("telescope.builtin").live_grep, { desc = "Live grep" })
	Nmap("<leader>D", require("telescope.builtin").diagnostics, { desc = "Show diagnostics" })
	Nmap("<leader>B", require("telescope.builtin").buffers, { desc = "List buffers" })
	Nmap("<leader>H", require("telescope.builtin").help_tags, { desc = "Find help tags" })
end

M.dependencies = {
	"nvim-telescope/telescope-fzf-native.nvim",
	"nvim-telescope/telescope-ui-select.nvim",
	"BurntSushi/ripgrep",
}

return M
