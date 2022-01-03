
" augroup lua.PreWrite
" au! *  <buffer>
" au BufWritePre <buffer> silent! :lua vim.lsp.buf.formatting_sync(nil, 250)
" augroup END

