local lspconfig = require("lspconfig")

require("lspkind").init({ mode = "symol_text" })
require("mv.lsp.status").setup()

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
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
vim.fn.sign_define("LightBulbSign", { text = "", texthl = "DiagnosticSignInfo", numhl = "DiagnosticSignInfo" })

local function custom_attach(client, bufnr)
    require("lsp-status").on_attach(client)

    vim.api.nvim_buf_set_option(0, "omnifunc", "v:lua.vim.lsp.omnifunc")

    vim.api.nvim_buf_set_keymap(
        bufnr,
        "i",
        "<C-s>",
        "<C-o><cmd>lua vim.lsp.buf.signature_help()<cr>",
        { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "<C-s>",
        "<cmd>lua vim.lsp.buf.signature_help()<cr>",
        { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "s",
        "<C-s>",
        "<cmd>lua vim.lsp.buf.signature_help()<cr>",
        { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { noremap = true, silent = true })

    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "<leader>1",
        "<cmd>lua vim.lsp.buf.code_action()<cr>",
        { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "v",
        "<leader>1",
        ":<C-U>lua vim.lsp.buf.range_code_action()<cr>",
        { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "d[",
        "<cmd>lua vim.diagnostic.goto_prev()<cr>",
        { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "d]",
        "<cmd>lua vim.diagnostic.goto_next()<cr>",
        { noremap = true, silent = true }
    )

    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "gd",
        "<cmd>lua vim.lsp.buf.definition()<cr>",
        { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "gD",
        "<cmd>lua vim.lsp.buf.declaration()<cr>",
        { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "gT",
        "<cmd>lua vim.lsp.buf.type_definition()<cr>",
        { noremap = true, silent = true }
    )

    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "gr",
        "<cmd>lua require'mv.telescope'.lsp_references()<cr>",
        { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "gI",
        "<cmd>lua require'mv.telescope'.lsp_implementations()<cr>",
        { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "<leader>lr",
        "<cmd>lua vim.lsp.codelens.run()<cr>",
        { noremap = true, silent = true }
    )

    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "<leader>lD",
        "<cmd>lua require'mv.telescope'.lsp_document_diagnostics()<cr>",
        { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "<leader>ls",
        "<cmd>lua require'mv.telescope'.lsp_document_symbols()<cr>",
        { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "<leader>lS",
        "<cmd>lua require'mv.telescope'.lsp_workspace_symbols()<cr>",
        { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "<leader>ld",
        "<cmd>lua vim.diagnostic.open_float(0, { scope = 'line' })<cr>",
        { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "<leader>ln",
        "<cmd>lua vim.lsp.buf.rename()<cr>",
        { noremap = true, silent = true }
    )

    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_buf_set_keymap(
            bufnr,
            "n",
            "<leader>lf",
            "<cmd>lua vim.lsp.buf.formatting()<cr>",
            { noremap = true, silent = true }
        )
    end

    if client.resolved_capabilities.document_range_formatting then
        vim.api.nvim_buf_set_keymap(
            bufnr,
            "v",
            "<leader>lf",
            ":<C-u>lua vim.lsp.buf.range_formatting()<cr>",
            { noremap = true, silent = true }
        )
    end

    vim.cmd([[
        augroup lsp_codeaction_lightbulb
        au! * <buffer>
        au CursorHold,CursorHoldI <buffer> lua require'nvim-lightbulb'.update_lightbulb()
        augroup end
    ]])

    if false and client.resolved_capabilities.document_highlight then
        vim.cmd([[
            augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
            ]])
    end

    if client.resolved_capabilities.code_lens then
        vim.cmd([[
        augroup lsp_document_codelens
        au! * <buffer>
        autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
        augroup END
        ]])
    end
end

vim.lsp.set_log_level(4)

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities = vim.tbl_deep_extend("keep", updated_capabilities, require("lsp-status").capabilities)
updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }
updated_capabilities = require("cmp_nvim_lsp").update_capabilities(updated_capabilities)

local servers = {
    pyright = true,
    vimls = true,
    html = true,
    cssls = true,
    eslint = true,

    jsonls = {
        commands = {
            Format = {
                function()
                    vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
                end,
            },
        },
    },

    tsserver = {
        on_init = function(client)
            client.resolved_capabilities.document_formatting = false
            client.resolved_capabilities.document_range_formatting = false
        end,
    },

    clangd = {
        cmd = { "clangd", "--background-index", "--query-driver=**/arm-none-eabi*,**/gcc*,**/g++*" },
    },

    sumneko_lua = {
        -- cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
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
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
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

local extension_path = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.6.8/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

require("rust-tools").setup({
    tools = { inlay_hints = { highlight = "InlayHint" }, hover_actions = { auto_focus = true } },
    server = {
        -- flags = { allow_incremental_sync = true, debounce_text_changes = 150 },
        -- capabilities = updated_capabilities,
        on_attach = function(client, bufnr)
            custom_attach(client, bufnr)
            vim.api.nvim_buf_set_keymap(bufnr, "v", "K", ":<C-U>RustHoverRange<cr>", { noremap = true, silent = true })
        end,
        -- settings = {
        --     ["rust-analyzer"] = {
        --         assist = { importMergeBehavior = "last", importPrefix = "by_self" },
        --         cargo = { loadOutDirsFromCheck = true },
        --         procMacro = { enable = true },
        --         rustfmt = { enableRangeFormatting = true }
        --     }
        -- }
    },
    dap = { adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path) },
})

local null_ls = require("null-ls")

null_ls.setup({
    on_attach = function(client, bufnr)
        -- We do only formatting via null-ls for now
        if client.resolved_capabilities.document_formatting then
            vim.api.nvim_buf_set_keymap(
                bufnr,
                "n",
                "<leader>lf",
                "<cmd>lua vim.lsp.buf.formatting()<cr>",
                { noremap = true, silent = true }
            )
        end

        if client.resolved_capabilities.document_range_formatting then
            vim.api.nvim_buf_set_keymap(
                bufnr,
                "v",
                "<leader>lf",
                ":<C-u>lua vim.lsp.buf.range_formatting()<cr>",
                { noremap = true, silent = true }
            )
        end
    end,

    -- on_attach = custom_attach,
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.black,
    },
})

require("trouble").setup()
