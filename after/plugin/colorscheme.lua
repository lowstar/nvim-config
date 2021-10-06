function _G.tweak_colors()
    vim.cmd('highlight! link FloatBorder NormalFloat')
    vim.cmd('highlight! link ExtraWhiteSpace ErrorMsg')

    if vim.g.colors_name:find("^base16") ~= nil then
        vim.fn.Base16hi('NonText', vim.g.base16_gui02, '', vim.g.base16_cterm03, '', '', '')
        vim.fn.Base16hi('StartifyPath', vim.g.base16_gui04, '', '', '', '', '')
        vim.fn.Base16hi('HopNextKey', vim.g.base16_gui0C, '', '', '', '', '')
        vim.fn.Base16hi('HopNextKey1', vim.g.base16_gui0C, '', '', '', '', '')
        vim.fn.Base16hi('HopNextKey2', vim.g.base16_gui0D, '', '', '', '', '')
        vim.fn.Base16hi('HopUnmatched', vim.g.base16_gui02, '', '', '', '', '')
        vim.fn.Base16hi('Comment', vim.g.base16_gui03, '', vim.g.base16_cterm08, '', 'italic', 'italic')
        vim.fn.Base16hi('InlayHint', vim.g.base16_gui03, '', '', '', 'italic', 'italic')

        vim.fn.Base16hi("DiagnosticError", vim.g.base16_gui08, '', '', '', '', '')
        vim.fn.Base16hi("DiagnosticWarn", vim.g.base16_gui09, '', '', '', '', '')
        vim.fn.Base16hi("DiagnosticInfo", vim.g.base16_gui0A, '', '', '', '', '')
        vim.fn.Base16hi("DiagnosticHint", vim.g.base16_gui0C, '', '', '', '', '')
        vim.fn.Base16hi("DiagnosticUnderlineError", vim.g.base16_gui08, '', '', '', 'underline', 'underline')
        vim.fn.Base16hi("DiagnosticUnderlineWarn", vim.g.base16_gui09, '', '', '', 'underline', 'underline')
        vim.fn.Base16hi("DiagnosticUnderlineInfo", vim.g.base16_gui0A, '', '', '', 'underline', 'underline')
        vim.fn.Base16hi("DiagnosticUnderlineHint", vim.g.base16_gui0C, '', '', '', 'underline', 'underline')

        vim.fn.Base16hi("LspReferenceRead", vim.g.base16_gui01, '', '', '', '', '')
        vim.fn.Base16hi("LspReferenceText", vim.g.base16_gui01, '', '', '', '', '')
        vim.fn.Base16hi("LspReferenceWrite", vim.g.base16_gui01, '', '', '', '', '')
    end

    require'nvim-web-devicons'.setup {
        default = true
    }
end

vim.api.nvim_exec([[
augroup colorscheme
au!
au ColorScheme * call v:lua.tweak_colors()
augroup END
]], false)

vim.o.background = 'dark'
vim.cmd('colorscheme base16-tomorrow-night')

vim.o.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20'

-- vim.o.guicursor = 'n-v-c-sm:block-blinkwait175-blinkoff150-blinkon175,' ..
--                       'i-ci-ve:ver25-blinkwait175-blinkoff150-blinkon175,' ..
--                       'r-cr-o:hor20-blinkwait175-blinkoff150-blinkon175'
