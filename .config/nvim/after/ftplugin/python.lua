vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true
vim.opt_local.autoindent = true

local function find_entry_point()
	local paths = { "./main.py", "../main.py", "../../main.py", "../../../main.py" }
	for _, path in ipairs(paths) do
		if vim.fn.filereadable(path) == 1 then
			return path
		end
	end
	return vim.fn.expand("%") -- Fallback to the current file
end

function RunPythonFile()
	local file = find_entry_point()
	vim.cmd("silent !tmux split-window -v 'python3 " .. file .. "; echo Press enter to close...; read'")
end

-- function RunIPython()
-- 	vim.cmd("silent !tmux split-window -v -d 'python'")
--
-- 	-- Short delay to ensure the Python shell starts
-- 	vim.cmd("sleep 300m")
--
-- 	-- Yank the selected text into register 'a'
-- 	vim.cmd('normal! gv"ay')
--
-- 	-- Retrieve the yanked text
-- 	local selected_text = vim.fn.getreg("a")
--
-- 	-- Split text into lines and send them one by one
-- 	for line in selected_text:gmatch("[^\r\n]+") do
-- 		vim.cmd("silent !tmux send-keys -t {last} '" .. line .. "' C-m")
-- 	end
-- end
-- vim.api.nvim_buf_set_keymap(0, "x", "<leader>r", "<cmd>lua RunIPython()<CR>", { noremap = true, silent = true })

vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<leader>r",
	"<cmd>w<cr><cmd>lua RunPythonFile()<CR>",
	{ noremap = true, silent = true }
)
