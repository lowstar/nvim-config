local saga = require 'lspsaga'

saga.init_lsp_saga({
    use_saga_diagnostic_sign = false,
    code_action_prompt = {
        enable = false
    }
})

-- vim.api.nvim_set_keymap('n', '<leader>ca', "<cmd>:Lspsaga code_action<cr>", { noremap = true, silent = true });
-- vim.api.nvim_set_keymap('v', '<leader>ca', "<cmd>:<C-U>Lspsaga range_code_action<cr>", { noremap = true, silent = true });
-- vim.api.nvim_set_keymap('n', '<leader>cd', "<cmd>:Lspsaga show_line_diagnostics<cr>", { noremap = true, silent = true });
-- vim.api.nvim_set_keymap('n', '<leader>cc', "<cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<cr>", { noremap = true, silent = true });
