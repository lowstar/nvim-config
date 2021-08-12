vim.api.nvim_exec([[
augroup trailing
  au!
  au BufWritePre * lua require'mv.trimwhite'.trim()
augroup END
]], false)

vim.api.nvim_set_keymap('n', '<leader>w', "<cmd>lua require'mv.trimwhite'.trim()<CR>",
    { noremap = true, silent = true })

vim.cmd('match ExtraWhiteSpace /\\s\\+\\%#\\@<!$/')

local M = {}

function M.trim()
    local save = vim.fn.winsaveview()
    vim.cmd('keeppatterns %s/\\s\\+$//e')
    vim.fn.winrestview(save)
end

return M

