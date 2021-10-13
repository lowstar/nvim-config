require('rust-tools').setup({
    tools = { inlay_hints = { highlight = "InlayHint" }, hover_actions = { auto_focus = true } },
    server = {
        -- flags = { allow_incremental_sync = true, debounce_text_changes = 150 },
        on_attach = function(client, bufnr)
            require'mv.lsp'.common_on_attach(client, bufnr)
            vim.api.nvim_buf_set_keymap(bufnr, 'v', 'K', ":<C-U>RustHoverRange<cr>",
                                        { noremap = true, silent = true })
        end
        -- settings = {
        --     ["rust-analyzer"] = {
        --         assist = { importMergeBehavior = "last", importPrefix = "by_self" },
        --         cargo = { loadOutDirsFromCheck = true },
        --         procMacro = { enable = true },
        --         rustfmt = { enableRangeFormatting = true }
        --     }
        -- }
    }
})
