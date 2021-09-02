local lspconfig = require 'lspconfig'

local bufdir = vim.fn.expand('%:p:h')

local sumneko_root_path = vim.fn.expand('$HOME') .. '/devel/lua-language-server'
local sumneko_binary = sumneko_root_path .. '/bin/macOS/lua-language-server'

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.sumneko_lua.setup {
    cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
    settings = {
        documentFormatting = false,
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                path = runtime_path
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' }
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true)
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = { enable = false }
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
