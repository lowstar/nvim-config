local highlight = require('mv.vim').highlight
local highlight_link = require('mv.vim').highlight_link

function _G.tweak_colors()
    highlight_link('FloatBorder', 'NormalFloat')
    highlight_link('ExtraWhiteSpace', 'ErrorMsg')

    if vim.g.colors_name:find("^base16") ~= nil then
        highlight('NonText', { guifg = '#' .. vim.g.base16_gui02, ctermfg = vim.g.base16_cterm03 })
        highlight("LspDiagnosticsDefaultError",
                  { guifg = '#' .. vim.g.base16_gui08, ctermfg = vim.g.base16_cterm03 })
        highlight("LspDiagnosticsDefaultWarning",
                  { guifg = '#' .. vim.g.base16_gui09, ctermfg = vim.g.base16_cterm05 })
        highlight("LspReferenceRead",
                  { guibg = '#' .. vim.g.base16_gui01, ctermbg = vim.g.base16_cterm02 })
        highlight("LspReferenceText",
                  { guibg = '#' .. vim.g.base16_gui01, ctermbg = vim.g.base16_cterm02 })
        highlight("LspReferenceWrite",
                  { guibg = '#' .. vim.g.base16_gui01, ctermbg = vim.g.base16_cterm02 })
        highlight("LspDiagnosticsUnderlineError", {
            guifg = '#' .. vim.g.base16_gui08,
            ctermfg = vim.g.base16_cterm03,
            cterm = "undercurl",
            gui = "undercurl"
        })
        highlight("LspDiagnosticsUnderlineWarning", {
            guifg = '#' .. vim.g.base16_gui09,
            ctermfg = vim.g.base16_cterm05,
            cterm = "undercurl",
            gui = "undercurl"
        })
        highlight("HopNextKey", { guifg = '#' .. vim.g.base16_gui0C })
        highlight("HopNextKey1", { guifg = '#' .. vim.g.base16_gui0C })
        highlight("HopNextKey2", { guifg = '#' .. vim.g.base16_gui0D })
        highlight("HopUnmatched", { guifg = '#' .. vim.g.base16_gui02 })
        highlight("InlayHint", { guifg = '#' .. vim.g.base16_gui0C, gui = "italic" })
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

