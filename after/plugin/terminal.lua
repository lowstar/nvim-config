vim.api.nvim_exec([[
augroup terminal
au!
au TermOpen * setlocal nonumber norelativenumber
augroup END
]], false)

