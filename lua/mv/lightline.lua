vim.api.nvim_exec([[
function! Lightline_LspClient()
    let lspclient = luaeval("require'mv.lsp'.get_lsp_client()")
    if strlen(lspclient) > 0
        return ' ' .. lspclient
    endif
    return  ''
endfunction
]], false)

vim.api.nvim_exec([[
function! Lightline_Filetype()
  return strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft'
endfunction
]], false)

vim.api.nvim_exec([[
function! Lightline_Fileformat()
  return &fileformat . ' ' . WebDevIconsGetFileFormatSymbol()
endfunction
]], false)

vim.g.lightline = {
    colorscheme = 'Tomorrow_Night_Eighties',
        active = {
            left = { {'mode', 'paste'}, {'readonly', 'filename', 'modified' }},
            right = { {'lineinfo'}, {'percent'}, {'lspclient', 'fileformat', 'fileencoding', 'filetype' }}
        },
    component_function = {
        lspclient = 'Lightline_LspClient',
        filetype = 'Lightline_Filetype',
        fileformat = 'Lightline_Fileformat'
    }
}
