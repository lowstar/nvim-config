setl expandtab
setl tabstop=2
setl shiftwidth=2
setl softtabstop=2

augroup js.PreWrite
au! *  <buffer>
au BufWritePre <buffer> silent! :lua vim.lsp.buf.format()
augroup END

