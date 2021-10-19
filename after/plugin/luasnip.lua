local luasnip = require("luasnip")

luasnip.config.set_config { history = true, updateevents = "TextChanged,TextChangedI" }
require("luasnip.loaders.from_vscode").load(
    { paths = { "~/.local/share/nvim/site/pack/packer/start/friendly-snippets" } })

vim.cmd [[
  imap <silent><expr> <c-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-k>'
  inoremap <silent> <c-j> <cmd>lua require('luasnip').jump(-1)<CR>
  imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
  snoremap <silent> <c-k> <cmd>lua require('luasnip').jump(1)<CR>
  snoremap <silent> <c-j> <cmd>lua require('luasnip').jump(-1)<CR>
]]

--[[
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node

luasnip.snippets = { rust = { s("blah", { t("struct "), i(1), t({ " {", "\t" }), i(0), t({ "", "}", "" }) }) } }
--]]
