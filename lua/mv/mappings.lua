vim.keymap.set("i", "<C-j>", "<Esc>", { noremap = true })
vim.keymap.set("v", "<C-j>", "<Esc>", { noremap = true })

-- Move visual block up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true })

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

vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })

vim.keymap.set("", "<leader>z", ":noh<cr>:call clearmatches()<cr>", { noremap = true, silent = true })

-- Select the contents of current line, excluding indentation
vim.keymap.set("n", "vv", "^vg_", { noremap = true })

-- Emacs bindings in command line mode
vim.keymap.set("c", "<c-a>", "<home>", { noremap = true })
vim.keymap.set("c", "<c-e>", "<end>", { noremap = true })

-- Buffers
vim.keymap.set("n", "<leader>.", ":bn<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>,", ":bp<cr>", { noremap = true, silent = true })

-- Ex
vim.keymap.set("n", "<leader>pv", ":Ex<cr>")

-- Telescope
vim.keymap.set("n", "<leader>O", function()
    return require("telescope.builtin").find_files({ hidden = true })
end)

vim.keymap.set("n", "<leader>b", require("telescope.builtin").buffers)
vim.keymap.set("n", "<leader>g", require("telescope.builtin").live_grep)
vim.keymap.set("n", "<leader>G", require("telescope.builtin").git_files)
vim.keymap.set("n", "<leader>v", require("mv.telescope").files_config_nvim)
vim.keymap.set("n", "<leader>f", require("telescope").extensions.file_browser.file_browser)

-- Hop
vim.keymap.set("n", "<leader>j", require("hop").hint_words, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>m", require("hop").hint_lines, { noremap = true, silent = true })

-- Trouble
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { noremap = true })

-- Harpoon
vim.keymap.set("n", "<leader>a", require("harpoon.mark").add_file)
vim.keymap.set("n", "<leader>e", require("harpoon.ui").toggle_quick_menu)
vim.keymap.set("n", "<leader>1", function()
    require("harpoon.ui").nav_file(1)
end)
vim.keymap.set("n", "<leader>2", function()
    require("harpoon.ui").nav_file(2)
end)
vim.keymap.set("n", "<leader>3", function()
    require("harpoon.ui").nav_file(3)
end)
vim.keymap.set("n", "<leader>4", function()
    require("harpoon.ui").nav_file(4)
end)
