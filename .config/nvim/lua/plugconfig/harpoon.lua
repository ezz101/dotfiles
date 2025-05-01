
local harpoon_select = function(i)
	return function()
		require("harpoon"):list():select(i)
	end
end

local harpoon_list = function()
	require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
end

local harpoon_add = function()
	require("harpoon"):list():add()
end

local harpoon_prev = function()
	require("harpoon"):list():prev()
end

local harpoon_next = function()
	require("harpoon"):list():next()
end


local M = { "ThePrimeagen/hrpoon" }

M.branch = "harpoon2",
M.dependencies = "nvim-lua/plenary.nvim"

M.config = function()
		nmap("<leader>a", harpoon_add)
		nmap("<leader>A", harpoon_list)
		nmap("<leader>1", harpoon_select(1))
		nmap("<leader>2", harpoon_select(2))
		nmap("<leader>3", harpoon_select(3))
		nmap("<leader>4", harpoon_select(4))
		nmap("<C-S-P>", harpoon_prev)
		nmap("<C-S-N>", harpoon_next)
end

return M
