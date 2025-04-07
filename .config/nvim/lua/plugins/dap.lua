local adapters = {
	"codelldb",
	"python",
}

local setup_python = function(dap)
	local get_python_env_path = function()
		local cwd = vim.fn.getcwd()
		if vim.fn.executable(cwd .. "/venv/bin/python3") == 1 then
			return cwd .. "/venv/bin/python3"
		elseif vim.fn.executable(cwd .. "/.venv/bin/python3") == 1 then
			return cwd .. "/.venv/bin/python3"
		else
			return "/usr/bin/python3"
		end
	end

	dap.adapters.python = function(cb, config)
		if config.request == "attach" then
			local port = (config.connect or config).port
			local host = (config.connect or config).host or "127.0.0.1"
			cb({
				type = "server",
				port = assert(port, "`connect.port` is required for a python `attach` configuration"),
				host = host,
				options = {
					source_filetype = "python",
				},
			})
		else
			cb({
				type = "executable",
				command = get_python_env_path(),
				args = { "-m", "debugpy.adapter" },
				options = {
					source_filetype = "python",
				},
			})
		end
	end
	dap.configurations.python = {
		{
			type = "python",
			request = "launch",
			name = "Launch file",

			program = "${file}",
			pythonPath = get_python_env_path,
		},
	}
end

local setup_codelldb = function(dap) end

return {
	"rcarriga/nvim-dap-ui",
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		setup_python(dap)
		setup_codelldb(dap)
		dap.listeners.before.attach.dapui_config = dapui.open
		dap.listeners.before.launch.dapui_config = dapui.open
		dap.listeners.before.event_terminated.dapui_config = dapui.close
		dap.listeners.before.event_exited.dapui_config = dapui.close
	end,
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "mfussenegger/nvim-dap" },
		{ "nvim-neotest/nvim-nio" },
		{ "jay-babu/mason-nvim-dap.nvim", opts = { ensure_installed = adapters } },
	},
}
