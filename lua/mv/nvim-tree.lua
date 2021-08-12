vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_follow = 0
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_add_trailing = 1

vim.api.nvim_set_keymap('n', '<f2>', '<cmd>NvimTreeToggle<cr>', { noremap = true, silent = true });
-- vim.api.nvim_set_keymap('n', '<C-n>', '<cmd>NvimTreeToggle<cr>', { noremap = true, silent = true });
vim.api.nvim_set_keymap('n', '<leader>n', '<cmd>NvimTreeFindFile<cr>', { noremap = true, silent = true });

