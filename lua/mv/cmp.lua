local cmp = require 'cmp'

cmp.setup {
    completion = { completeopt = 'menu,menuone,noinsert' },
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end
    },
    mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.close(),
        ["<c-y>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true },
        ["<C-Space>"] = cmp.mapping.complete()
    },
    formatting = {
        format = function(entry, vim_item)
            -- fancy icons and a name of kind
            vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " ..
                                vim_item.kind

            -- set a name for each source
            vim_item.menu = ({
                buffer = "[buffer]",
                nvim_lua = "[lua]",
                nvim_lsp = "[LSP]",
                path = "[path]",
                luasnip = "[luasnip]"
            })[entry.source.name]
            return vim_item
        end
    },
    sources = {
        { name = 'buffer' },
        { name = 'path' },
        { name = 'nvim_lua' },
        { name = 'nvim_lsp' },
        { name = 'luasnip' }
    }
}

