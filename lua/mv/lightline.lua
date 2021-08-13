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

vim.api.nvim_exec([[
function! Lightline_GitBranch()
    let branchname = FugitiveHead()
    if strlen(branchname) > 0
        return ' ' .. branchname
    endif
    return ''
endfunction
]], false)

vim.api.nvim_exec([[
function! Lightline_Filename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction
]], false)

vim.g.lightline = {
    colorscheme = 'Tomorrow_Night_Eighties',
    active = {
        left = { { 'mode', 'paste' }, { 'readonly', 'filename' }, { 'gitbranch' } },
        right = {
            { 'lineinfo' },
            { 'percent' },
            { 'lspclient', 'fileformat', 'fileencoding', 'filetype' }
        }
    },
    component_function = {
        filename = 'Lightline_Filename',
        lspclient = 'Lightline_LspClient',
        filetype = 'Lightline_Filetype',
        fileformat = 'Lightline_Fileformat',
        gitbranch = 'Lightline_GitBranch'
    }
}
