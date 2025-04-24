local M = {}

-- local function find_entry_point()
-- 	local paths = { "./main.py", "../main.py", "../../main.py", "../../../main.py" }
-- 	for _, path in ipairs(paths) do
-- 		if vim.fn.filereadable(path) == 1 then
-- 			return path
-- 		end
-- 	end
-- 	return vim.fn.expand("%") -- Fallback to the current file
-- end
-- 
-- function RunPythonFile()
-- 	local file = find_entry_point()
-- 	vim.cmd("silent !tmux split-window -v 'python3 " .. file .. "; echo Press enter to close...; read'")
-- end
-- 
-- 
-- local get_python_env_path = function()
-- 	local cwd = vim.fn.getcwd()
-- 	if vim.fn.executable(cwd .. "/.venv/bin/python3") == 1 then
-- 		return cwd .. "/.venv/bin/python3"
-- 	else
-- 		return "/usr/bin/python3"
-- 	end
-- end
-- 
-- require("dap").adapters.python = function(cb, config)
-- 	if config.request == "attach" then
-- 		local port = (config.connect or config).port
-- 		local host = (config.connect or config).host or "127.0.0.1"
-- 		cb({
-- 			type = "server",
-- 			port = assert(port, "`connect.port` is required for a python `attach` configuration"),
-- 			host = host,
-- 			options = {
-- 				source_filetype = "python",
-- 			},
-- 		})
-- 	else
-- 		cb({
-- 			type = "executable",
-- 			command = get_python_env_path(),
-- 			args = { "-m", "debugpy.adapter" },
-- 			options = {
-- 				source_filetype = "python",
-- 			},
-- 		})
-- 	end
-- end
-- require("dap").configurations.python = {
-- 	{
-- 		type = "python",
-- 		request = "launch",
-- 		name = "Launch file",
-- 		program = "${file}",
-- 		pythonPath = get_python_env_path,
-- 	},
-- }
-- 	require("dap-python").setup("uv")

M.config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		dap.listeners.before.attach.dapui_config = dapui.open
		dap.listeners.before.launch.dapui_config = dapui.open
		dap.listeners.before.event_terminated.dapui_config = dapui.close
		dap.listeners.before.event_exited.dapui_config = dapui.close

		nmap("<leader>ds", require("dap").continue, "Start/Continue debugging")
		nmap("<leader>dl", require("dap").run_last, "Run last debug session")
		nmap("<leader>dv", require("dap").step_over, "Step over")
		nmap("<leader>di", require("dap").step_into, "Step into")
		nmap("<leader>do", require("dap").step_out, "Step out")
		nmap("<leader>db", require("dap").toggle_breakpoint, "Toggle breakpoint")
		nmap("<leader>dc", require("dap").clear_breakpoints, "Clear breakpoints")
		nmap("<leader>dr", require("dap").repl.open, "Open DAP REPL")
end

M.mason_opts = {
	ensure_installed = {
		"codelldb",
		"python",
	},
}

return M
