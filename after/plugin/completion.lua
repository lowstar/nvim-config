local cmp = require 'cmp'

cmp.setup {
    -- completion = { completeopt = 'menu,menuone,noinsert' },

    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end
    },

    mapping = {
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-y>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true }
    },

    formatting = {
        format = require'lspkind'.cmp_format {
            menu = { buffer = "BUFFER", nvim_lua = "LUA", nvim_lsp = "LSP", path = "PATH", luasnip = "LUASNIP" }
            -- menu = { buffer = "[BUFFER]", nvim_lua = "[LUA]", nvim_lsp = "[LSP]", path = "[PATH]", luasnip = "[LUASNIP]" }
        }
    },

    sources = {
        { name = "nvim_lua" },
        { name = "nvim_lsp", priority = 10 },
        { name = "path" },
        { name = "buffer", priority = 2, keyword_length = 5, max_item_count = 5 },
        { name = "luasnip" }
    },

    documentation = { border = 'rounded' }

}

require('nvim-autopairs').setup()

require("nvim-autopairs.completion.cmp").setup { auto_select = false }

