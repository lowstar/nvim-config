local lspconfig = require 'lspconfig'
local nvim_status = require 'lsp-status'

local bufdir = vim.fn.expand('%:p:h')

local sumneko_root_path = vim.fn.expand('$HOME') .. '/devel/lua-language-server'
local sumneko_binary = sumneko_root_path .. '/bin/macOS/lua-language-server'

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local luaFormat = { formatCommand = "lua-format -i", formatStdin = true }
local prettier_global = { formatCommand = "prettier --stdin-filepath ${INPUT}", formatStdin = true }

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities = vim.tbl_deep_extend("keep", updated_capabilities, nvim_status.capabilities)
updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }
updated_capabilities = require("cmp_nvim_lsp").update_capabilities(updated_capabilities)

local servers = {
    pyright = true,
    vimls = true,
    html = true,
    cssls = true,

    jsonls = {
        commands = {
            Format = {
                function()
                    vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
                end
            }
        }
    },

    tsserver = {
        on_init = function(client)
            print("tsserver oninit")
            client.resolved_capabilities.document_formatting = false
            client.resolved_capabilities.document_range_formatting = false
        end
    },

    clangd = {
        cmd = { "clangd", "--background-index", "--query-driver=**/arm-none-eabi*" },
        root_dir = lspconfig.util.root_pattern("compile_commands.json") or bufdir
    },

    sumneko_lua = {
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
        }
    },

    efm = {
        init_options = { documentFormatting = true, codeAction = false },
        root_dir = function(fname)
            local bufdir = vim.fn.expand('%:p:h')
            return lspconfig.util.root_pattern(".prettier*")(fname) or
                       lspconfig.util.root_pattern(".clang-format")(fname) or
                       lspconfig.util.root_pattern(".rustfmt.toml")(fname) or
                       lspconfig.util.root_pattern(".git/")(fname) or bufdir
        end,

        filetypes = { "lua", "javascript", "javascriptreact" },
        settings = {
            rootMarkers = { ".git/" },
            languages = {
                lua = { luaFormat },
                javascript = { prettier_global },
                javascriptreact = { prettier_global }
            }
        }
    }
}

local setup_server = function(server, config)
    if not config then
        return
    end

    if type(config) ~= "table" then
        config = {}
    end

    config = vim.tbl_deep_extend("force", {
        on_attach = require'mv.lsp'.common_on_attach,
        capabilities = updated_capabilities,
        flags = { debounce_text_changes = 50 }
    }, config)

    lspconfig[server].setup(config)
end

for server, config in pairs(servers) do
    setup_server(server, config)
end

