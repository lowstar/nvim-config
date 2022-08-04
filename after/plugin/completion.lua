local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

---@diagnostic disable-next-line: redundant-parameter
cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },

    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = cmp.config.disable,
        ["<S-Tab>"] = cmp.config.disable,
    }),

    sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,

            -- copied from cmp-under, but I don't think I need the plugin for this.
            -- I might add some more of my own.
            function(entry1, entry2)
                local _, entry1_under = entry1.completion_item.label:find("^_+")
                local _, entry2_under = entry2.completion_item.label:find("^_+")
                entry1_under = entry1_under or 0
                entry2_under = entry2_under or 0
                if entry1_under > entry2_under then
                    return false
                elseif entry1_under < entry2_under then
                    return true
                end
            end,

            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },

    -- view = { entries = "native" },
    formatting = {
        format = require("lspkind").cmp_format({
            mode = "symbol_text",
            menu = {
                buffer = "[BUF]",
                nvim_lua = "[NVIM]",
                nvim_lsp = "[LSP]",
                path = "[PATH]",
                luasnip = "[SNIP]",
                orgmode = "[ORG]",
            },
        }),
    },

    sources = cmp.config.sources({
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "luasnip" },
        { name = "orgmode" },
    }, {
        { name = "buffer" },
    }),

    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },

    -- experimental = { ghost_text = false, native_menu = false },
})

require("nvim-autopairs").setup({ fast_wrap = {} })

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
