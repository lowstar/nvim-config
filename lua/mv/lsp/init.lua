local lspconfig = require("lspconfig")
local lsp_status = require("lsp-status")

require("lspkind").init({ mode = "symbol_text" })

lsp_status.config({ indicator_separator = "", component_separator = " ", status_symbol = "", diagnostics = false })
lsp_status.register_progress()

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    float = { border = "rounded" },
})

vim.fn.sign_define(
    "DiagnosticSignError",
    { texthl = "DiagnosticSignError", text = "", numhl = "DiagnosticSignError" }
)
vim.fn.sign_define("DiagnosticSignWarn", { texthl = "DiagnosticSignWarn", text = "", numhl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { texthl = "DiagnosticSignInfo", text = "", numhl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { texthl = "DiagnosticSignHint", text = "", numhl = "DiagnosticSignHint" })

local function custom_attach(client, bufnr)
    require("lsp-status").on_attach(client)

    vim.api.nvim_buf_set_option(0, "omnifunc", "v:lua.vim.lsp.omnifunc")

    if client.supports_method("textDocument/formatting") then
        vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { noremap = true, silent = true, buffer = bufnr })
    end

    vim.keymap.set(
        { "i", "n", "s" },
        "<C-s>",
        vim.lsp.buf.signature_help,
        { noremap = true, silent = true, buffer = bufnr }
    )
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set("n", "<leader>1", vim.lsp.buf.code_action, { noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set("n", "d[", vim.diagnostic.goto_prev, { noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set("n", "d]", vim.diagnostic.goto_next, { noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set("n", "gr", require("mv.telescope").lsp_references, {
        noremap = true,
        silent = true,
        buffer = bufnr,
    })
    vim.keymap.set(
        "n",
        "gI",
        require("mv.telescope").lsp_implementations,
        { noremap = true, silent = true, buffer = bufnr }
    )
    vim.keymap.set("n", "<leader>lr", vim.lsp.codelens.run, { noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set(
        "n",
        "<leader>lD",
        require("mv.telescope").lsp_document_diagnostics,
        { noremap = true, silent = true, buffer = bufnr }
    )
    vim.keymap.set(
        "n",
        "<leader>ls",
        require("mv.telescope").lsp_document_symbols,
        { noremap = true, silent = true, buffer = bufnr }
    )
    vim.keymap.set(
        "n",
        "<leader>lS",
        require("mv.telescope").lsp_workspace_symbols,
        { noremap = true, silent = true, buffer = bufnr }
    )
    vim.keymap.set("n", "<leader>ld", function()
        vim.diagnostic.open_float(0, { scope = "line" })
    end, {
        noremap = true,
        silent = true,
        buffer = bufnr,
    })
    vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { noremap = true, silent = true, buffer = bufnr })

    if client.server_capabilities.codeLensProvider then
        local aug_codelens = vim.api.nvim_create_augroup("lsp_codelens", { clear = true })
        vim.api.nvim_create_autocmd(
            { "BufEnter", "CursorHold", "InsertLeave" },
            { buffer = 0, group = aug_codelens, callback = vim.lsp.codelens.refresh }
        )
    end
end

vim.lsp.set_log_level(4)

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities = vim.tbl_deep_extend("keep", updated_capabilities, lsp_status.capabilities)
updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }
updated_capabilities = require("cmp_nvim_lsp").update_capabilities(updated_capabilities)

local servers = {
    pyright = true,
    vimls = true,
    html = true,
    cssls = true,
    tsserver = {
        on_init = function(client)
            client.resolved_capabilities.document_formatting = false
            client.resolved_capabilities.document_range_formatting = false
        end,
    },

    gopls = {
        settings = {
            gopls = {
                analyses = {
                    unusedparams = true,
                    shadow = true,
                },
                hints = {
                    assignVariableTypes = true,
                    compositeLiteralFields = true,
                    constantValues = true,
                    functionTypeParameters = true,
                    parameterNames = true,
                    rangeVariableTypes = true,
                },
            },
        },
    },

    clangd = {
        cmd = {
            "clangd",
            "--enable-config",
            "--background-index",
            "--query-driver=**/arm-none-eabi*,**/*gcc*,**/*g++*",
        },
    },

    sumneko_lua = {
        settings = {
            documentFormatting = false,
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = "LuaJIT",
                    path = runtime_path,
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { "vim" },
                },
                hint = { enable = true, semicolon = "Disable", setType = true },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    -- library = vim.api.nvim_get_runtime_file("", true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = { enable = false },
            },
        },
    },
}

local setup_server = function(server, config)
    if not config then
        return
    end

    if type(config) ~= "table" then
        config = {}
    end

    config = vim.tbl_deep_extend("force", {
        on_attach = custom_attach,
        capabilities = updated_capabilities,
        flags = { debounce_text_changes = 50 },
    }, config)

    lspconfig[server].setup(config)
end

for server, config in pairs(servers) do
    setup_server(server, config)
end

local extension_path = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.7.3/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

require("rust-tools").setup({
    tools = {
        autoSetHints = false,
        inlay_hints = {
            highlight = "InlayHint",
        },
        hover_actions = { auto_focus = true },
    },
    server = {
        on_attach = function(client, bufnr)
            custom_attach(client, bufnr)
            vim.api.nvim_buf_set_keymap(bufnr, "v", "K", ":<C-U>RustHoverRange<cr>", { noremap = true, silent = true })
        end,
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = { allTargets = true },
                assist = { importGranularity = "module", importPrefix = "by_crate" },
            },
        },
        standalone = false,
    },
    dap = { adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path) },
})

local null_ls = require("null-ls")

null_ls.setup({
    on_attach = custom_attach,
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.gofmt,
    },
})

require("trouble").setup()
