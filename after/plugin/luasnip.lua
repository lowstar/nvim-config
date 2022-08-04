local luasnip = require("luasnip")

luasnip.config.set_config({ history = true, updateevents = "TextChanged,TextChangedI" })
require("luasnip.loaders.from_vscode").load({
    paths = { "~/.local/share/nvim/site/pack/packer/start/friendly-snippets" },
})

vim.keymap.set({ "i", "s" }, "<C-k>", function()
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-j>", function()
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-l>", function()
    if luasnip.choice_active() then
        luasnip.change_choice(1)
    end
end, { silent = true })

-- vim.cmd [[
--   imap <silent><expr> <c-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-k>'
--   inoremap <silent> <c-j> <cmd>lua require('luasnip').jump(-1)<CR>
--   imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
--   snoremap <silent> <c-k> <cmd>lua require('luasnip').jump(1)<CR>
--   snoremap <silent> <c-j> <cmd>lua require('luasnip').jump(-1)<CR>
-- ]]
