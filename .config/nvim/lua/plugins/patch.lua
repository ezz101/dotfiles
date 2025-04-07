AssistantContext = AssistantContext or {}

local function read_file(filepath)
	local f = io.open(filepath, "r")
	if not f then
		return nil
	end
	local content = f:read("*a")
	f:close()
	return content
end

local function get_selection_or_full_content()
	local mode = vim.fn.mode()
	if mode == "v" or mode == "V" or mode == "" then
		local start_pos = vim.fn.getpos("'<")
		local end_pos = vim.fn.getpos("'>")
		local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)
		return table.concat(lines, "\n")
	else
		return table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
	end
end

function LoadAssistantClipboard()
	vim.ui.input({ prompt = "Enter your message: " }, function(prompt)
		local lines = {}
		table.insert(
			lines,
			"I want a help in this programming task. I will give you project context if needed and the mean file at the end and you should rewrite it with the requested edits."
		)
		for _, file in ipairs(AssistantContext) do
			local content = read_file(file)
			if content then
				table.insert(lines, "# " .. file)
				table.insert(lines, content)
			end
		end

		table.insert(lines, "\nThe mean file (currently editing file):\n")

		local current_file = vim.fn.expand("%:p")
		local current_content = get_selection_or_full_content()
		if current_file and #current_content > 0 then
			table.insert(lines, "# " .. current_file)
			table.insert(lines, current_content)
		end

		table.insert(lines, "\nWhat I want:")
		table.insert(lines, prompt)
		local clipboard_content = table.concat(lines, "\n\n")
		vim.fn.setreg("+", clipboard_content)
		print("Context copied to clipboard")
		vim.fn.system("xdotool keydown Super_L key a keyup Super_L keydown Ctrl key v keyup Ctrl key Return")
	end)
end

function PatchClipboard()
	local clipboard_content = vim.fn.system("xclip -selection clipboard -o"):gsub("\r\n", "\n"):gsub("\r", "\n") -- Normalize newlines to Unix style
	local file = "/tmp/diff-clipboard"
	local f = io.open(file, "w")
	if f then
		f:write(clipboard_content)
		f:close()
	else
		print("Error: Could not write to " .. file)
		return
	end

	local filetype = vim.bo.filetype
	vim.cmd("vert diffsplit " .. file)
	vim.cmd("set filetype=" .. filetype)
end

local finders = require("telescope.finders")
local telescope_builtin = require("telescope.builtin")
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")

function AddAssistantContext()
	telescope_builtin.find_files({
		prompt_title = "Select Context Files",
		attach_mappings = function(prompt_bufnr, map)
			local function add_selected_files()
				local picker = action_state.get_current_picker(prompt_bufnr)
				local selected_entries = picker:get_multi_selection()

				for _, entry in ipairs(selected_entries) do
					local filepath = entry[1]
					if not vim.tbl_contains(AssistantContext, filepath) then
						table.insert(AssistantContext, filepath)
						print("Added:", filepath)
					end
				end
				actions.close(prompt_bufnr)
			end

			-- Add selected files with <CR>
			map("i", "<CR>", add_selected_files)
			map("n", "<CR>", add_selected_files)
			return true
		end,
	})
end

function DeleteAssistantContext()
	telescope_builtin.find_files({
		prompt_title = "Select Context Files to Remove",
		finder = finders.new_table({
			results = AssistantContext,
		}),
		attach_mappings = function(prompt_bufnr, map)
			local function remove_selected_files()
				local picker = action_state.get_current_picker(prompt_bufnr)
				local selected_entries = picker:get_multi_selection()

				for _, entry in ipairs(selected_entries) do
					local filepath = entry[1]
					for i, file in ipairs(AssistantContext) do
						if file == filepath then
							table.remove(AssistantContext, i)
							print("Removed:", filepath)
							break
						end
					end
				end
				actions.close(prompt_bufnr)
			end
			map("i", "<CR>", remove_selected_files)
			map("n", "<CR>", remove_selected_files)

			return true
		end,
	})
end

return {}
