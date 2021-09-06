function _G.trim_whitespace()
    local save = vim.fn.winsaveview()
    vim.cmd('keeppatterns %s/\\s\\+$//e')
    vim.fn.winrestview(save)
end

vim.api.nvim_exec([[
augroup trim_whitespace
  au!
  au BufWritePre * lua _G.trim_whitespace()
augroup END
]], false)

vim.api.nvim_set_keymap('n', '<leader>w', "<cmd>lua _G.trim_whitespace()<cr>",
                        { noremap = true, silent = true })

vim.cmd('match ExtraWhiteSpace /\\s\\+\\%#\\@<!$/')

