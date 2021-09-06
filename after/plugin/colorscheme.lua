function _G.tweak_colors()
    vim.cmd('highlight! link FloatBorder NormalFloat')
    vim.cmd('highlight! link ExtraWhiteSpace ErrorMsg')

    if vim.g.colors_name:find("^base16") ~= nil then
        vim.fn.Base16hi('NonText', vim.g.base16_gui02, '', vim.g.base16_cterm03, '', '', '')
        vim.fn.Base16hi('InlayHint', vim.g.base16_gui0C, '', '', '', '', '')
        vim.fn.Base16hi('HopNextKey', vim.g.base16_gui0C, '', '', '', '', '')
        vim.fn.Base16hi('HopNextKey1', vim.g.base16_gui0C, '', '', '', '', '')
        vim.fn.Base16hi('HopNextKey2', vim.g.base16_gui0D, '', '', '', '', '')
        vim.fn.Base16hi('HopUnmatched', vim.g.base16_gui02, '', '', '', '', '')
        vim.fn.Base16hi('InlayHint', vim.g.base16_gui0C, '', '', '', 'italic', '')
        vim.fn.Base16hi("LspDiagnosticsDefaultError", vim.g.base16_gui08, '', '', '', '', '')
        vim.fn.Base16hi("LspDiagnosticsDefaultWarning", vim.g.base16_gui09, '', '', '', '', '')
        vim.fn.Base16hi("LspReferenceRead", vim.g.base16_gui01, '', '', '', '', '')
        vim.fn.Base16hi("LspReferenceText", vim.g.base16_gui01, '', '', '', '', '')
        vim.fn.Base16hi("LspReferenceWrite", vim.g.base16_gui01, '', '', '', '', '')
        vim.fn.Base16hi("LspDiagnosticsUnderlineError", vim.g.base16_gui08, '', '', '', '',
                        'undercurl')
        vim.fn.Base16hi("LspDiagnosticsUnderlineWarning", vim.g.base16_gui09, '', '', '', "",
                        'undercurl')
    end

    require'nvim-web-devicons'.setup { default = true }
end

vim.api.nvim_exec([[
augroup colorscheme
au!
au ColorScheme * call v:lua.tweak_colors()
augroup END
]], false)

vim.o.background = 'dark'

vim.cmd('colorscheme base16-tomorrow-night-eighties')

vim.o.guicursor = 'n-v-c-sm:block-blinkwait175-blinkoff150-blinkon175,' ..
                      'i-ci-ve:ver25-blinkwait175-blinkoff150-blinkon175,' ..
                      'r-cr-o:hor20-blinkwait175-blinkoff150-blinkon175'

