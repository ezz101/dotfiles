local M = {}

local dap = { "mfussenegger/nvim-dap" }
table.insert(M, dap)

local dapui = {"rcarriga/nvim-dap-ui"}
dapui.dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"}
table.insert(M, dapui)

return M
