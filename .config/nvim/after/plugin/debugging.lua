require("mason-nvim-dap").setup({
	ensure_installed = { "python", "codelld" }
})

require("dap-python").setup("uv")
require("ctest-telescope").setup({
	dap_config = {
		type = "codelldb"
	}
})


local ks = vim.keymap.set

ks("n", "<leader>dh", ":lua require'dap'.toggle_breakpoint()", { desc = "Dap: Toggle breakpoint" })
ks("n", "<leader>dd", function()
	local dap = require("dap")
	if dap.session() == nil and (vim.bo.filetype == "cpp" or vim.bo.filetype == "c") then
		require("ctest-telescope").pick_test_and_debug()
	elseif dap.session() == nil and vim.bo.filetype == "rust" then
		require("ctest-telescope").pick_test_and_debug()
	else
		dap.continue()
	end
end, { desc = "Dap: Launch/Resume debugging session" })
ks("n", "<leader>dh", ":lua require'dap'.step_into()", { desc = "Dap: Step into call" })
ks("n", "<leader>dh", ":lua require'dap'.step_over()", { desc = "Dap: Step over call" })

ks("n", "<leader>dn", ":lua require('dap-python').test_method()<CR>")
ks("n", "<leader>df", ":lua require('dap-python').test_class()<CR>")
ks("v", "<leader>ds", "<ESC>:lua require('dap-python').debug_selection()<CR>")
