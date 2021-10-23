local map = vim.api.nvim_set_keymap

map('i', '<C-j>', '<Esc>', { noremap = true })
map('v', '<C-j>', '<Esc>', { noremap = true })

-- Better indenting
map('v', '<', '<gv', { noremap = true, silent = true })
map('v', '>', '>gv', { noremap = true, silent = true })

-- Keep search matches in the center of the window
map('n', 'n', 'nzzzv', { noremap = true })
map('n', 'N', 'Nzzzv', { noremap = true })
map('n', '*', '*zzzv', { noremap = true })

map('', '<leader>z', ':noh<cr>:call clearmatches()<cr>', { noremap = true, silent = true })

-- Select the contents of current line, excluding indentation
map('n', 'vv', '^vg_', { noremap = true })

-- Emacs bindings in command line mode
map('c', '<c-a>', '<home>', { noremap = true })
map('c', '<c-e>', '<end>', { noremap = true })

-- Buffers
map('n', '<leader>.', ':bn<cr>', { noremap = true, silent = true })
map('n', '<leader>,', ':bp<cr>', { noremap = true, silent = true })

map('n', '<leader>ev', ':ed $MYVIMRC<cr>', { noremap = true, silent = true })
map('n', '<leader>sv', ':luafile $MYVIMRC<cr>', { noremap = true, silent = true })

-- Telescope
map('n', '<leader>o', "<cmd>lua require('telescope.builtin').find_files({ hidden = true })<cr>",
    { noremap = true, silent = true })

map('n', '<leader>b', "<cmd>lua require('telescope.builtin').buffers()<cr>", { noremap = true, silent = true })

map('n', '<leader>g', "<cmd>lua require('telescope.builtin').live_grep()<cr>", { noremap = true, silent = true })

map('n', '<leader>v', "<cmd>lua require('mv.telescope').files_config_nvim()<cr>", { noremap = true, silent = true })

map('n', '<leader>f', "<cmd>lua require('telescope.builtin').file_browser()<cr>", { noremap = true, silent = true })

-- Hop
map('n', '<leader>j', "<cmd>lua require'hop'.hint_words()<cr>", { noremap = true, silent = true })
map('n', '<leader>J', "<cmd>lua require'hop'.hint_char1()<cr>", { noremap = true, silent = true })
map('v', '<leader>j', "<cmd>lua require'hop'.hint_words()<cr>", { noremap = true, silent = true })
map('v', '<leader>J', "<cmd>lua require'hop'.hint_char1()<cr>", { noremap = true, silent = true })

-- Trouble
map('n', '<leader>xx', "<cmd>TroubleToggle<cr>", { noremap = true })

-- nvim-tree
map('n', '<A-n>', "<cmd>NvimTreeToggle<cr>", { noremap = true, silent = true })
map('n', '<leader>n', "<cmd>NvimTreeFindFile<cr>", { noremap = true, silent = true })
