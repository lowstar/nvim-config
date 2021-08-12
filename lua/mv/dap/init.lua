vim.api.nvim_set_keymap('n', '<leader>db',
    "<cmd>lua require('dap').toggle_breakpoint()<cr>",
    { noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<leader>dc',
    "<cmd>lua require('dap').continue()<cr>",
    { noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<leader>dx',
    "<cmd>lua require('dap').stop()<cr>",
    { noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<leader>ds',
    "<cmd>lua require('dap').step_over()<cr>",
    { noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<leader>di',
    "<cmd>lua require('dap').step_over()<cr>",
    { noremap = true, silent = true})
