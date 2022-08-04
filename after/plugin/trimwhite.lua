local function trim_whitespace()
    local save = vim.fn.winsaveview()
    vim.cmd("keeppatterns %s/\\s\\+$//e")
    vim.fn.winrestview(save)
end

vim.api.nvim_set_keymap("n", "<leader>w", "", { noremap = true, silent = true, callback = trim_whitespace })
vim.api.nvim_create_autocmd("BufWritePre", { callback = trim_whitespace })

vim.cmd("match ExtraWhiteSpace /\\s\\+\\%#\\@<!$/")
