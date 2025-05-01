local M = { "ThePrimeagen/harpoon" }

M.branch = "harpoon2"
M.dependencies = { "nvim-lua/plenary.nvim" }
M.config = function()
	local harpoon = require("harpoon")
	harpoon:setup()

	Nmap("<leader>a", function() harpoon:list():add() end)
	Nmap("<leader>A", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

	Nmap("<M-1>", function() harpoon:list():select(1) end)
	Nmap("<M-2>", function() harpoon:list():select(2) end)
	Nmap("<M-3>", function() harpoon:list():select(3) end)
	Nmap("<M-4>", function() harpoon:list():select(4) end)
end

return M
