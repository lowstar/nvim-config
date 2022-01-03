setl expandtab
setl tabstop=4
setl shiftwidth=4
setl softtabstop=4

" augroup lua.PreWrite
" au! *  <buffer>
" au BufWritePre <buffer> silent! :lua vim.lsp.buf.formatting_sync(nil, 250)
" augroup END

