local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

--[[ local luasnip = require("luasnip")
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end ]]

cmp.setup({
    -- completion = { completeopt = 'menu,menuone,noinsert' },

    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },

    mapping = {
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
        ["<C-y>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
        ["<C-q>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),

        --[[ ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),

        ['<CR>'] = cmp.mapping.confirm({ select = true }) ]]
    },

    formatting = {
        format = require("lspkind").cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            menu = { buffer = "[BUF]", nvim_lua = "[LUA]", nvim_lsp = "[LSP]", path = "[PATH]", luasnip = "[SNIP]" },
        }),
    },

    sources = cmp.config.sources({
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "luasnip" },
        { name = "buffer" },
    }),

    documentation = { border = "rounded" },

    experimental = { ghost_text = true },
})

-- Use buffer source for `/`.
---@diagnostic disable-next-line: undefined-field
-- cmp.setup.cmdline('/', { completion = { autocomplete = false }, sources = cmp.config.sources({ { name = 'buffer' } }) })

-- Use cmdline & path source for ':'.
---@diagnostic disable-next-line: undefined-field
--[[ cmp.setup.cmdline(':', {
    sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline', keyword_length = 4 } })
}) ]]

require("nvim-autopairs").setup({ fast_wrap = {} })

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
