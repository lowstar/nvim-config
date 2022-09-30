vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        if vim.g.colors_name:find("^base16") ~= nil then
            vim.api.nvim_set_hl(0, "FloatBorder", { link = "NormalFloat" })
            vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { link = "Comment" })
            vim.api.nvim_set_hl(0, "LspDiagnosticsDefaultError", { link = "DiagnosticError" })
            vim.api.nvim_set_hl(0, "LspDiagnosticsDefaultWarning", { link = "DiagnosticWarn" })
            vim.api.nvim_set_hl(0, "LspDiagnosticsDefaultInformation", { link = "DiagnosticInfo" })
            vim.api.nvim_set_hl(0, "LspDiagnosticsDefaultHint", { link = "DiagnosticHint" })
            vim.api.nvim_set_hl(0, "LspDiagnosticsSignError", { link = "LspDiagnosticsDefaultError" })
            vim.api.nvim_set_hl(0, "LspDiagnosticsSignWarning", { link = "LspDiagnosticsDefaultWarning" })
            vim.api.nvim_set_hl(0, "LspDiagnosticsSignInformation", { link = "LspDiagnosticsDefaultInformation" })
            vim.api.nvim_set_hl(0, "LspDiagnosticsSignHint", { link = "LspDiagnosticsDefaultHint" })
            vim.api.nvim_set_hl(0, "NotifyERRORBorder", { link = "DiagnosticError" })
            vim.api.nvim_set_hl(0, "NotifyERRORIcon", { link = "NotifyERRORBorder" })
            vim.api.nvim_set_hl(0, "NotifyERRORTitle", { link = "NotifyERRORBorder" })
            vim.api.nvim_set_hl(0, "NotifyWARNBorder", { link = "DiagnosticWarn" })
            vim.api.nvim_set_hl(0, "NotifyWARNIcon", { link = "NotifyWARNBorder" })
            vim.api.nvim_set_hl(0, "NotifyWARNTitle", { link = "NotifyWARNBorder" })
            vim.api.nvim_set_hl(0, "NotifyINFOBorder", { link = "DiagnosticInfo" })
            vim.api.nvim_set_hl(0, "NotifyINFOIcon", { link = "NotifyINFOBorder" })
            vim.api.nvim_set_hl(0, "NotifyINFOTitle", { link = "NotifyINFOBorder" })
            vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { link = "DiagnosticHint" })
            vim.api.nvim_set_hl(0, "NotifyDEBUGIcon", { link = "NotifyDEBUGBorder" })
            vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", { link = "NotifyDEBUGBorder" })
            vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { link = "DiagnosticHint" })
            vim.api.nvim_set_hl(0, "NotifyTRACEIcon", { link = "NotifyTRACEBorder" })
            vim.api.nvim_set_hl(0, "NotifyTRACETitle", { link = "NotifyTRACEBorder" })
            vim.api.nvim_set_hl(0, "TSNodeKey", { link = "HopNextKey" })
            vim.api.nvim_set_hl(0, "TSNodeUnmatched", { link = "HopUnmatched" })
            vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "CmpItemAbbrMatch" })

            local W = require("mv.utils").W

            vim.api.nvim_set_hl(
                0,
                "LspInlayHint",
                { fg = W(vim.g.base16_gui04), bg = W(vim.g.base16_gui01), italic = true }
            )

            vim.api.nvim_set_hl(0, "ExtraWhiteSpace", { fg = W(vim.g.base16_gui08), bg = W(vim.g.base16_gui08) })
            vim.api.nvim_set_hl(0, "Whitespace", { fg = W(vim.g.base16_gui02), italic = true })
            vim.api.nvim_set_hl(0, "NonText", { fg = W(vim.g.base16_gui02), italic = true })
            vim.api.nvim_set_hl(0, "HopNextKey", { fg = W(vim.g.base16_gui0C) })
            vim.api.nvim_set_hl(0, "HopNextKey1", { fg = W(vim.g.base16_gui0C) })
            vim.api.nvim_set_hl(0, "HopNextKey2", { fg = W(vim.g.base16_gui0D) })
            vim.api.nvim_set_hl(0, "HopUnmatched", { fg = W(vim.g.base16_gui03) })
            vim.api.nvim_set_hl(0, "Comment", { fg = W(vim.g.base16_gui03), italic = true })

            vim.api.nvim_set_hl(0, "DiagnosticError", { fg = W(vim.g.base16_gui08) })
            vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = W(vim.g.base16_gui09) })
            vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = W(vim.g.base16_gui0A) })
            vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = W(vim.g.base16_gui0C) })
            vim.api.nvim_set_hl(0, "DiagnosticunderlineError", { fg = W(vim.g.base16_gui08), underline = true })
            vim.api.nvim_set_hl(0, "DiagnosticunderlineWarn", { fg = W(vim.g.base16_gui09), underline = true })
            vim.api.nvim_set_hl(0, "DiagnosticunderlineInfo", { fg = W(vim.g.base16_gui0A), underline = true })
            vim.api.nvim_set_hl(0, "DiagnosticunderlineHint", { fg = W(vim.g.base16_gui0C), underline = true })

            vim.api.nvim_set_hl(0, "LspReferenceRead", { fg = W(vim.g.base16_gui01), bg = W(vim.g.base16_gui09) })
            vim.api.nvim_set_hl(0, "LspReferenceText", { fg = W(vim.g.base16_gui04), bg = W(vim.g.base16_gui02) })
            vim.api.nvim_set_hl(0, "LspReferenceWrite", { fg = W(vim.g.base16_gui01), bg = W(vim.g.base16_gui08) })

            vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = W(vim.g.base16_gui0D) })
            vim.api.nvim_set_hl(0, "CmpItemKind", { fg = W(vim.g.base16_gui0E) })
            vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = W(vim.g.base16_gui03) })
            vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = W(vim.g.base16_gui03), strikethrough = true })
        end

        require("nvim-web-devicons").setup({ default = true })
    end,
})

vim.g.catppuccin_flavour = "macchiato"
local colors = require("catppuccin.palettes").get_palette()
require("catppuccin").setup({
    integrations = {
        lsp_trouble = true,
        treesitter_context = true,
    },
    custom_highlights = {
        LspInlayHint = { fg = colors.subtext0, bg = colors.surface0, style = { "italic" } },
        ExtraWhiteSpace = { fg = colors.red, bg = colors.red },
        NonText = { fg = colors.surface1 },
        Whitespace = { fg = colors.surface1 },
        Comment = { fg = colors.overlay1 },
    },
})

vim.o.background = "dark"
vim.cmd("colorscheme catppuccin")
