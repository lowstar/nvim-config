local cmp = require 'cmp'
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

cmp.setup {
    -- completion = { completeopt = 'menu,menuone,noinsert' },

    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end
    },

    mapping = {
        ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-e>'] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
        ["<C-y>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true },
        ["<C-q>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true }
    },

    formatting = {
        format = require'lspkind'.cmp_format {
            menu = { buffer = "[BUF]", nvim_lua = "[LUA]", nvim_lsp = "[LSP]", path = "[PATH]", luasnip = "[SNIP]" }
        }
    },

    sources = cmp.config.sources({
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "luasnip" },
        { name = "buffer", keyword_length = 5 }
    }),

    documentation = { border = 'rounded' },

    experimental = { ghost_text = true }
}

-- Use buffer source for `/`.
---@diagnostic disable-next-line: undefined-field
cmp.setup.cmdline('/', { completion = { autocomplete = false }, sources = cmp.config.sources({ { name = 'buffer' } }) })

-- Use cmdline & path source for ':'.
---@diagnostic disable-next-line: undefined-field
cmp.setup.cmdline(':', {
    completion = { autocomplete = false },
    sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline', keyword_length = 4 } })
})

require('nvim-autopairs').setup { fast_wrap = {} }

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

