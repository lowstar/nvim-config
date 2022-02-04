vim.api.nvim_exec([[
augroup terminal
au!
au TermOpen * setlocal nonumber norelativenumber
au TermOpen * startinsert
augroup END
]], false)

