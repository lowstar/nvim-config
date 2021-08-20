local lspconfig = require 'lspconfig'

local bufdir = vim.fn.expand('%:p:h')

local sumneko_root_path = vim.fn.expand('$HOME') .. '/devel/lua-language-server'
local sumneko_binary = sumneko_root_path .. '/bin/macOS/lua-language-server'

lspconfig.sumneko_lua.setup {
    cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
    settings = {
        documentFormatting = false,
        Lua = {
            runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
            diagnostics = { globals = { 'vim' } },
            workspace = {
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
                }
            }
        }
    },
    on_attach = require'mv.lsp'.common_on_attach
}

lspconfig.pyright.setup { on_attach = require'mv.lsp'.common_on_attach }

lspconfig.vimls.setup { on_attach = require'mv.lsp'.common_on_attach }

lspconfig.tsserver.setup {
    on_init = function(client)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
    end,
    on_attach = require'mv.lsp'.common_on_attach
}

lspconfig.clangd.setup {
    cmd = { "clangd", "--background-index", "--query-driver=**/arm-none-eabi*" },
    root_dir = lspconfig.util.root_pattern("compile_commands.json") or bufdir,
    on_attach = require'mv.lsp'.common_on_attach
}

if vim.fn.hostname() == "prime" then
    for _, server in ipairs({ "html", "cssls" }) do
        -- Enable (broadcasting) snippet capability for completion
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        require'lspconfig'[server].setup {
            capabilities = capabilities,
            on_attach = require'mv.lsp'.common_on_attach
        }
    end

    require'lspconfig'.jsonls.setup {
        commands = {
            Format = {
                function()
                    vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
                end
            }
        },
        on_attach = require'mv.lsp'.common_on_attach
    }
end
