local tools = {
    inlay_hints = {
        highlight = "InlayHint"
    },
    hover_actions = {
        auto_focus = true
    }
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require('rust-tools').setup({
    tools = tools,
    server = {
        on_attach = function(client, bufnr)
            require'mv.lsp'.common_on_attach(client, bufnr)
            vim.api.nvim_buf_set_keymap(bufnr, 'v', 'K', ":<C-U>RustHoverRange<cr>",
                                        { noremap = true, silent = true })
        end,
        capabilities = capabilities,
        settings = {
            ["rust-analyzer"] = {
                assist = {
                    importMergeBehavior = "last",
                    importPrefix = "by_self",
                },
                lens = {
                    enable = true,
                    methodReferences = true,
                    references = true
                },
                cargo = {
                    loadOutDirsFromCheck = true
                },
                procMacro = {
                    enable = true
                }
            }
        },
    }
})
