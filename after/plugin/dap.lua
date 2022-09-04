local status_ok, dap = pcall(require, "dap")
if not status_ok then
    return
end

local dapui = require("dapui")

vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>dc", dap.continue, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>dx", dap.stop, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ds", dap.step_over, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>di", dap.step_over, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>dd", dapui.toggle, { noremap = true, silent = true })


dap.adapters.lldb = {
    type = "executable",
    command = "/usr/local/opt/llvm/bin/lldb-vscode", -- adjust as needed
    name = "rt_lldb",
}

dap.configurations.cpp = {
    {
        name = "Launch",
        type = "rt_lldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},

        -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
        --
        --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
        --
        -- Otherwise you might get the following error:
        --
        --    Error on launch: Failed to attach to the target process
        --
        -- But you should be aware of the implications:
        -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
        runInTerminal = false,
    },
}

-- If you want to use this for rust and c, add something like this:

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

require("dap-go").setup()
dapui.setup()
