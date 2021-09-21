local check_back_space = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col == 0 or vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') ~= nil
end

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local cmp = require 'cmp'
local luasnip = require("luasnip")

cmp.setup {
    completion = { completeopt = 'menu,menuone,noinsert' },

    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end
    },

    mapping = {
        ["<CR>"] = cmp.mapping.confirm(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if vim.fn.pumvisible() == 1 then
                vim.api.nvim_feedkeys(t("<C-n>"), "n", true)
            elseif luasnip.expand_or_jumpable() then
                vim.api.nvim_feedkeys(t("<Plug>luasnip-expand-or-jump"), "", true)
            elseif check_back_space() then
                vim.api.nvim_feedkeys(t("<Tab>"), "n", true)
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if vim.fn.pumvisible() == 1 then
                vim.api.nvim_feedkeys(t("<C-p>"), "n", true)
            elseif luasnip.jumpable(-1) then
                vim.api.nvim_feedkeys(t("<Plug>luasnip-jump-prev"), "", true)
            else
                fallback()
            end
        end, { "i", "s" })
    },

    formatting = {
        format = function(entry, vim_item)
            -- fancy icons and a name of kind
            vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind

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
        { name = 'nvim_lua' },
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'luasnip' }
    },

    documentation = { border = 'rounded' },

    experimental = { ghost_text = false }

}

require('nvim-autopairs').setup()

require("nvim-autopairs.completion.cmp").setup()
