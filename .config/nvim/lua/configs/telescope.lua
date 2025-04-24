local M = {}

M.opts = {
		require("telescope.themes").get_dropdown({}),
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
		require("telescope").load_extension("refactoring")
		require("telescope").load_extension("ui-select")

		nmap("gd", require("telescope.builtin").lsp_definitions, "Go to definition")
		nmap("gs", require("telescope.builtin").lsp_document_symbols, "List document symbols")
		nmap("gS", require("telescope.builtin").lsp_dynamic_workspace_symbols, "List workspace symbols")
		nmap("gi", require("telescope.builtin").lsp_implementations, "Go to implementation")
		nmap("gr", require("telescope.builtin").lsp_references, "Find references")
		nmap("<leader>F", require("telescope.builtin").find_files, "Find files")
		nmap("<leader>G", require("telescope.builtin").live_grep, "Live grep")
		nmap("<leader>D", require("telescope.builtin").diagnostics, "Show diagnostics")
		nmap("<leader>B", require("telescope.builtin").buffers, "List buffers")
		nmap("<leader>H", require("telescope.builtin").help_tags, "Find help tags")
	end

return M
