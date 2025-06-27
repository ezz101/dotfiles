-- AI Assistant Plugin for Neovim
-- Helps integrate with AI chatbots by copying code with prompts and handling diffs

local M = {}

-- Plugin configuration
M.config = {
	keymaps = {
		copy_file_with_prompt = "<leader>af",
		copy_multiple_files = "<leader>am",
		diff_whole_file = "<leader>ad",
		diff_selected_lines = "<leader>as",
	},
	prompt_template = {
		single_file = [[{user_prompt}

File: {file_path}
```{file_type}
{file_content}
```]],
		multiple_files = [[{user_prompt}

Another files:
{files_content}]],
	},
}

-- Utility functions
local function get_file_type(filepath)
	local extension = filepath:match("%.([^%.]+)$")
	if not extension then
		return "text"
	end

	local type_map = {
		lua = "lua",
		py = "python",
		js = "javascript",
		ts = "typescript",
		jsx = "jsx",
		tsx = "tsx",
		html = "html",
		css = "css",
		scss = "scss",
		java = "java",
		cpp = "cpp",
		c = "c",
		h = "c",
		hpp = "cpp",
		rs = "rust",
		go = "go",
		rb = "ruby",
		php = "php",
		sh = "bash",
		yml = "yaml",
		yaml = "yaml",
		json = "json",
		xml = "xml",
		md = "markdown",
		txt = "text",
		vim = "vim",
	}

	return type_map[extension] or extension
end

local function get_relative_path(filepath)
	local cwd = vim.fn.getcwd()
	if filepath:sub(1, #cwd) == cwd then
		return filepath:sub(#cwd + 2) -- +2 to remove the leading slash
	end
	return filepath
end

local function copy_to_clipboard(content)
	-- Use xclip to copy to system clipboard
	local handle = io.popen("xclip -selection clipboard", "w")
	if handle then
		handle:write(content)
		handle:close()
		vim.notify("Content copied to clipboard!", vim.log.levels.INFO)
	else
		vim.notify("Failed to copy to clipboard. Make sure xclip is installed.", vim.log.levels.ERROR)
	end
end

local function get_user_input(prompt_text)
	local input = vim.fn.input(prompt_text .. ": ")
	if input == "" then
		vim.notify("Operation cancelled - no prompt provided", vim.log.levels.WARN)
		return nil
	end
	return input
end

local function read_file_content(filepath)
	local file = io.open(filepath, "r")
	if not file then
		vim.notify("Cannot read file: " .. filepath, vim.log.levels.ERROR)
		return nil
	end

	local content = file:read("*all")
	file:close()
	return content
end

-- Feature 1: Copy whole file with prompt
function M.copy_file_with_prompt()
	local filepath = vim.fn.expand(":p")
	local filename = vim.fn.expand(":t")
	if filepath == "" then
		vim.notify("No file is currently open", vim.log.levels.WARN)
		return
	end

	local user_prompt = get_user_input("Enter your prompt")
	if not user_prompt then
		return
	end

	local file_content = read_file_content(filepath)
	if not file_content then
		return
	end

	local relative_path = get_relative_path(filepath)
	local file_type = get_file_type(filename)

	local formatted_content = M.config.prompt_template.single_file
		:gsub("{user_prompt}", user_prompt)
		:gsub("{file_path}", relative_path)
		:gsub("{file_type}", file_type)
		:gsub("{file_content}", file_content)

	copy_to_clipboard(formatted_content)
end

-- Feature 2: Copy multiple files with telescope
function M.copy_multiple_files()
	local has_telescope, telescope = pcall(require, "telescope")
	if not has_telescope then
		vim.notify("Telescope is required for this feature", vim.log.levels.ERROR)
		return
	end

	local user_prompt = get_user_input("Enter your prompt")
	if not user_prompt then
		return
	end

	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")
	local conf = require("telescope.config").values
	local previewers = require("telescope.previewers")

	local selected_files = {}

	local function toggle_selection(prompt_bufnr)
		local selection = action_state.get_selected_entry()
		if selection then
			local filepath = selection.path or selection.value
			if selected_files[filepath] then
				selected_files[filepath] = nil
				vim.notify("Removed: " .. vim.fn.fnamemodify(filepath, ":t"), vim.log.levels.INFO)
			else
				selected_files[filepath] = true
				vim.notify("Added: " .. vim.fn.fnamemodify(filepath, ":t"), vim.log.levels.INFO)
			end
			-- Move to next entry after selection
			actions.move_selection_next(prompt_bufnr)
		end
	end

	local function finish_selection(prompt_bufnr)
		actions.close(prompt_bufnr)

		if vim.tbl_isempty(selected_files) then
			vim.notify("No files selected", vim.log.levels.WARN)
			return
		end

		local files_content = ""
		for filepath, _ in pairs(selected_files) do
			local content = read_file_content(filepath)
			if content then
				local relative_path = get_relative_path(filepath)
				local file_type = get_file_type(filepath)
				files_content = files_content
					.. string.format("\nFile: %s\n```%s\n%s\n```\n", relative_path, file_type, content)
			end
		end

		local formatted_content = M.config.prompt_template.multiple_files
			:gsub("{user_prompt}", user_prompt)
			:gsub("{files_content}", files_content)

		copy_to_clipboard(formatted_content)
	end

	pickers
		.new({}, {
			prompt_title = "Select Files (Tab to toggle, Enter to finish)",
			finder = finders.new_oneshot_job({ "find", ".", "-type", "f", "-not", "-path", "./.git/*" }),
			sorter = conf.file_sorter({}),
			previewer = previewers.vim_buffer_cat.new({
				define_preview = function(self, entry)
					local filepath = entry.path or entry.value
					if vim.fn.filereadable(filepath) == 1 then
						return filepath
					end
				end,
			}),
			layout_config = {
				horizontal = {
					preview_width = 0.55,
					results_width = 0.8,
				},
			},
			attach_mappings = function(prompt_bufnr, map)
				map("i", "<Tab>", toggle_selection)
				map("n", "<Tab>", toggle_selection)
				map("i", "<CR>", finish_selection)
				map("n", "<CR>", finish_selection)
				return true
			end,
		})
		:find()
end

-- Feature 3: Diff whole file from clipboard
function M.diff_whole_file()
	local current_file = vim.fn.expand("%:p")
	if current_file == "" then
		vim.notify("No file is currently open", vim.log.levels.WARN)
		return
	end

	-- Get clipboard content
	local handle = io.popen("xclip -selection clipboard -o")
	if not handle then
		vim.notify("Failed to read clipboard. Make sure xclip is installed.", vim.log.levels.ERROR)
		return
	end

	local clipboard_content = handle:read("*all")
	handle:close()

	if clipboard_content == "" then
		vim.notify("Clipboard is empty", vim.log.levels.WARN)
		return
	end

	-- Create a temporary buffer with clipboard content
	local temp_buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(temp_buf, 0, -1, false, vim.split(clipboard_content, "\n"))

	-- Set up diff view
	local current_win = vim.api.nvim_get_current_win()
	local original_buf = vim.api.nvim_get_current_buf()
	vim.cmd("vsplit")
	local new_win = vim.api.nvim_get_current_win()

	vim.api.nvim_win_set_buf(new_win, temp_buf)

	-- Set filetype for syntax highlighting
	local original_filetype = vim.api.nvim_buf_get_option(original_buf, "filetype")
	vim.api.nvim_buf_set_option(temp_buf, "filetype", original_filetype)

	-- Handle buffer naming safely to prevent conflicts
	local buffer_name = "[AI Response]"
	local counter = 1
	while pcall(vim.api.nvim_buf_set_name, temp_buf, buffer_name) == false do
		buffer_name = string.format("[AI Response %d]", counter)
		counter = counter + 1
	end

	-- Configure diff options for better visualization
	vim.opt_local.diffopt = "filler,internal,algorithm:histogram,indent-heuristic"

	-- Enable diff mode
	vim.api.nvim_set_current_win(current_win)
	vim.cmd("diffthis")
	vim.api.nvim_set_current_win(new_win)
	vim.cmd("diffthis")

	-- Configure diff colors and highlighting
	vim.cmd([[
    highlight DiffAdd    ctermbg=22 guibg=#003300
    highlight DiffDelete ctermbg=52 guibg=#330000
    highlight DiffChange ctermbg=17 guibg=#000033
    highlight DiffText   ctermbg=53 guibg=#330033
  ]])

	-- Set up diff-specific key mappings for both buffers
	local diff_keymaps = {
		{
			"n",
			"[c",
			function()
				if vim.wo.diff then
					vim.cmd("normal! [c")
				end
			end,
			{ desc = "Previous diff" },
		},
		{
			"n",
			"]c",
			function()
				if vim.wo.diff then
					vim.cmd("normal! ]c")
				end
			end,
			{ desc = "Next diff" },
		},
		{
			"n",
			"do",
			function()
				if vim.wo.diff then
					vim.cmd("diffget")
				end
			end,
			{ desc = "Diff obtain (accept from other)" },
		},
		{
			"n",
			"dp",
			function()
				if vim.wo.diff then
					vim.cmd("diffput")
				end
			end,
			{ desc = "Diff put (give to other)" },
		},
		{
			"n",
			"<leader>da",
			function()
				if vim.wo.diff then
					vim.cmd(":%diffget")
					vim.notify("All changes accepted", vim.log.levels.INFO)
				end
			end,
			{ desc = "Accept all diffs" },
		},
		{
			"n",
			"<leader>dr",
			function()
				if vim.wo.diff then
					vim.cmd(":%diffput")
					vim.notify("All changes rejected", vim.log.levels.INFO)
				end
			end,
			{ desc = "Reject all diffs" },
		},
		{
			"n",
			"<leader>du",
			function()
				vim.cmd("diffupdate")
				vim.notify("Diff updated", vim.log.levels.INFO)
			end,
			{ desc = "Update diff" },
		},
	}

	-- Apply keymaps to both buffers
	for _, keymap in ipairs(diff_keymaps) do
		vim.keymap.set(
			keymap[1],
			keymap[2],
			keymap[3],
			{ buffer = temp_buf, noremap = true, silent = true, desc = keymap[4].desc }
		)
		vim.keymap.set(
			keymap[1],
			keymap[2],
			keymap[3],
			{ buffer = original_buf, noremap = true, silent = true, desc = keymap[4].desc }
		)
	end

	-- Focus on first diff if exists
	vim.schedule(function()
		vim.cmd("normal! ]c")
	end)

	vim.notify(
		"Diff view created! [c/]c: navigate, do/dp: single diff, <leader>da/<leader>dr: all diffs",
		vim.log.levels.INFO
	)
end

-- Feature 4: Diff selected lines from clipboard
function M.diff_selected_lines()
	local mode = vim.fn.mode()
	if mode ~= "v" and mode ~= "V" and mode ~= "\22" then -- \22 is visual block mode
		vim.notify("Please select lines in visual mode first", vim.log.levels.WARN)
		return
	end

	-- Get selected lines
	local start_line = vim.fn.line("'<")
	local end_line = vim.fn.line("'>")
	local selected_lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
	local original_buf = vim.api.nvim_get_current_buf()
	local original_filetype = vim.api.nvim_buf_get_option(original_buf, "filetype")

	-- Get clipboard content
	local handle = io.popen("xclip -selection clipboard -o")
	if not handle then
		vim.notify("Failed to read clipboard. Make sure xclip is installed.", vim.log.levels.ERROR)
		return
	end

	local clipboard_content = handle:read("*all")
	handle:close()

	if clipboard_content == "" then
		vim.notify("Clipboard is empty", vim.log.levels.WARN)
		return
	end

	-- Create temporary buffers
	local original_selection_buf = vim.api.nvim_create_buf(false, true)
	local clipboard_buf = vim.api.nvim_create_buf(false, true)

	vim.api.nvim_buf_set_lines(original_selection_buf, 0, -1, false, selected_lines)
	vim.api.nvim_buf_set_lines(clipboard_buf, 0, -1, false, vim.split(clipboard_content, "\n"))

	-- Create diff layout in new tab
	vim.cmd("tabnew")

	-- Left window - original selection
	vim.api.nvim_win_set_buf(0, original_selection_buf)
	vim.api.nvim_buf_set_option(original_selection_buf, "filetype", original_filetype)

	-- Handle buffer naming safely for original
	local original_name = "[Original Selection]"
	local counter = 1
	while pcall(vim.api.nvim_buf_set_name, original_selection_buf, original_name) == false do
		original_name = string.format("[Original Selection %d]", counter)
		counter = counter + 1
	end

	-- Right window - clipboard content
	vim.cmd("vsplit")
	local right_win = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_buf(right_win, clipboard_buf)
	vim.api.nvim_buf_set_option(clipboard_buf, "filetype", original_filetype)

	-- Handle buffer naming safely for clipboard
	local clipboard_name = "[AI Response]"
	counter = 1
	while pcall(vim.api.nvim_buf_set_name, clipboard_buf, clipboard_name) == false do
		clipboard_name = string.format("[AI Response %d]", counter)
		counter = counter + 1
	end

	-- Configure diff options for better visualization
	vim.opt_local.diffopt = "filler,internal,algorithm:histogram,indent-heuristic"

	-- Enable diff mode for both windows
	vim.cmd("windo diffthis")

	-- Configure diff colors and highlighting
	vim.cmd([[
    highlight DiffAdd    ctermbg=22 guibg=#003300
    highlight DiffDelete ctermbg=52 guibg=#330000
    highlight DiffChange ctermbg=17 guibg=#000033
    highlight DiffText   ctermbg=53 guibg=#330033
  ]])

	-- Set up diff-specific key mappings for both buffers
	local diff_keymaps = {
		{
			"n",
			"[c",
			function()
				if vim.wo.diff then
					vim.cmd("normal! [c")
				end
			end,
			{ desc = "Previous diff" },
		},
		{
			"n",
			"]c",
			function()
				if vim.wo.diff then
					vim.cmd("normal! ]c")
				end
			end,
			{ desc = "Next diff" },
		},
		{
			"n",
			"do",
			function()
				if vim.wo.diff then
					vim.cmd("diffget")
				end
			end,
			{ desc = "Diff obtain (accept from other)" },
		},
		{
			"n",
			"dp",
			function()
				if vim.wo.diff then
					vim.cmd("diffput")
				end
			end,
			{ desc = "Diff put (give to other)" },
		},
		{
			"n",
			"<leader>da",
			function()
				if vim.wo.diff then
					vim.cmd(":%diffget")
					vim.notify("All changes accepted", vim.log.levels.INFO)
				end
			end,
			{ desc = "Accept all diffs" },
		},
		{
			"n",
			"<leader>dr",
			function()
				if vim.wo.diff then
					vim.cmd(":%diffput")
					vim.notify("All changes rejected", vim.log.levels.INFO)
				end
			end,
			{ desc = "Reject all diffs" },
		},
		{
			"n",
			"<leader>du",
			function()
				vim.cmd("diffupdate")
				vim.notify("Diff updated", vim.log.levels.INFO)
			end,
			{ desc = "Update diff" },
		},
	}

	-- Apply keymaps to both buffers
	for _, keymap in ipairs(diff_keymaps) do
		vim.keymap.set(
			keymap[1],
			keymap[2],
			keymap[3],
			{ buffer = original_selection_buf, noremap = true, silent = true, desc = keymap[4].desc }
		)
		vim.keymap.set(
			keymap[1],
			keymap[2],
			keymap[3],
			{ buffer = clipboard_buf, noremap = true, silent = true, desc = keymap[4].desc }
		)
	end

	-- Focus on first diff if exists
	vim.schedule(function()
		vim.cmd("normal! ]c")
	end)

	vim.notify(
		"Selection diff created! [c/]c: navigate, do/dp: single diff, <leader>da/<leader>dr: all diffs",
		vim.log.levels.INFO
	)
end

-- Setup function
function M.setup(opts)
	opts = opts or {}
	M.config = vim.tbl_deep_extend("force", M.config, opts)

	-- Set up keymaps
	local keymap_opts = { noremap = true, silent = true, desc = "AI Assistant" }

	vim.keymap.set(
		"n",
		M.config.keymaps.copy_file_with_prompt,
		M.copy_file_with_prompt,
		vim.tbl_extend("force", keymap_opts, { desc = "Copy file with prompt" })
	)

	vim.keymap.set(
		"n",
		M.config.keymaps.copy_multiple_files,
		M.copy_multiple_files,
		vim.tbl_extend("force", keymap_opts, { desc = "Copy multiple files with prompt" })
	)

	vim.keymap.set(
		"n",
		M.config.keymaps.diff_whole_file,
		M.diff_whole_file,
		vim.tbl_extend("force", keymap_opts, { desc = "Diff whole file from clipboard" })
	)

	vim.keymap.set(
		"v",
		M.config.keymaps.diff_selected_lines,
		M.diff_selected_lines,
		vim.tbl_extend("force", keymap_opts, { desc = "Diff selected lines from clipboard" })
	)

	-- Create user commands
	vim.api.nvim_create_user_command("AICopyFile", M.copy_file_with_prompt, {})
	vim.api.nvim_create_user_command("AICopyMultiple", M.copy_multiple_files, {})
	vim.api.nvim_create_user_command("AIDiffFile", M.diff_whole_file, {})
	vim.api.nvim_create_user_command("AIDiffSelection", M.diff_selected_lines, {})
end

return M
