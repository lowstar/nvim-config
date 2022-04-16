vim.keymap.set("i", "<C-j>", "<Esc>", { noremap = true })
vim.keymap.set("v", "<C-j>", "<Esc>", { noremap = true })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- Better indenting
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })

-- Keep search matches in the center of the window
vim.keymap.set("n", "n", "nzzzv", { noremap = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true })
vim.keymap.set("n", "*", "*zzzv", { noremap = true })

vim.keymap.set("", "<leader>z", ":noh<cr>:call clearmatches()<cr>", { noremap = true, silent = true })

-- Select the contents of current line, excluding indentation
vim.keymap.set("n", "vv", "^vg_", { noremap = true })

-- Emacs bindings in command line mode
vim.keymap.set("c", "<c-a>", "<home>", { noremap = true })
vim.keymap.set("c", "<c-e>", "<end>", { noremap = true })

-- Buffers
vim.keymap.set("n", "<leader>.", ":bn<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>,", ":bp<cr>", { noremap = true, silent = true })

-- Telescope
vim.keymap.set("n", "<leader>o", function()
    return require("telescope.builtin").find_files({ hidden = true })
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>b", function()
    return require("telescope.builtin").buffers()
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>g", function()
    return require("telescope.builtin").live_grep()
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>v", function()
    return require("mv.telescope").files_config_nvim()
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>f", function()
    return require 'telescope'.extensions.file_browser.file_browser()
end, { noremap = true, silent = true })

-- Hop
vim.keymap.set("n", "<leader>j", function()
    return require("hop").hint_words()
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>m", function()
    return require("hop").hint_lines()
end, { noremap = true, silent = true })

-- Trouble
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { noremap = true })

-- nvim-tree
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>n", "<cmd>NvimTreeFindFile<cr>", { noremap = true, silent = true })
