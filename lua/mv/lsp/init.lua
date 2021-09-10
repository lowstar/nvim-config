vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = true,
    update_in_insert = false,
    severity_sort = true
})

vim.fn.sign_define("LspDiagnosticsSignError",
                   { texthl = "LspDiagnosticsSignError", text = "", numhl = "LspDiagnosticsSignError" })
vim.fn.sign_define("LspDiagnosticsSignWarning",
                   { texthl = "LspDiagnosticsSignWarning", text = "", numhl = "LspDiagnosticsSignWarning" })
vim.fn.sign_define("LspDiagnosticsSignInformation",
                   { texthl = "LspDiagnosticsSignInformation", text = "", numhl = "LspDiagnosticsSignInformation" })
vim.fn.sign_define("LspDiagnosticsSignHint",
                   { texthl = "LspDiagnosticsSignHint", text = "", numhl = "LspDiagnosticsSignHint" })

vim.fn.sign_define("LightBulbSign",
                   { text = "", texthl = "LspDiagnosticsSignInformation", numhl = "LspDiagnosticsSignInformation" })

local M = {}

function M.common_on_attach(client, bufnr)
    require'lsp-status'.on_attach(client)

    vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-k>', "<cmd>lua vim.lsp.buf.signature_help()<cr>",
                                { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', "<cmd>lua vim.lsp.buf.signature_help()<cr>",
                                { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', "<cmd>lua vim.lsp.buf.hover()<cr>", { noremap = true, silent = true })

    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>1', "<cmd>lua vim.lsp.buf.code_action()<cr>",
                                { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>1', ":<C-U>lua vim.lsp.buf.range_code_action()<cr>",
                                { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dp', "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
                                { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dn', "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>",
                                { noremap = true, silent = true })

    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', "<cmd>lua vim.lsp.buf.definition()<cr>",
                                { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', "<cmd>lua vim.lsp.buf.declaration()<cr>",
                                { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gT', "<cmd>lua vim.lsp.buf.type_definition()<cr>",
                                { noremap = true, silent = true })

    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', "<cmd>lua require'mv.telescope'.lsp_references()<cr>",
                                { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gI', "<cmd>lua require'mv.telescope'.lsp_implementations()<cr>",
                                { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lr', "<cmd>lua vim.lsp.codelens.run()<cr>",
                                { noremap = true, silent = true })

    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'lD', "<cmd>lua require'mv.telescope'.lsp_document_diagnostics()<cr>",
                                { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ls', "<cmd>lua require'mv.telescope'.lsp_document_symbols()<cr>",
                                { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'lS', "<cmd>lua require'mv.telescope'.lsp_workspace_symbols()<cr>",
                                { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ld',
                                "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = 'rounded' })<cr>",
                                { noremap = true, silent = true })
    vim.api
        .nvim_buf_set_keymap(bufnr, 'n', 'ln', '<cmd>lua vim.lsp.buf.rename()<cr>', { noremap = true, silent = true })

    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lf', "<cmd>lua vim.lsp.buf.formatting()<cr>",
                                    { noremap = true, silent = true })
    elseif client.resolved_capabilities.document_range_formatting then
        vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>lf', "<cmr>lua vim.lsp.buf.range_formatting()<cr>",
                                    { noremap = true, silent = true })
    end

    vim.cmd [[
        augroup lsp_codeaction_lightbulb
        au! * <buffer>
        au CursorHold,CursorHoldI <buffer> lua require'nvim-lightbulb'.update_lightbulb()
        augroup end
    ]]

    if false then
        if client.resolved_capabilities.document_highlight then
            vim.cmd [[
            augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
            ]]
        end
    end

    if client.resolved_capabilities.code_lens then
        vim.cmd [[
        augroup lsp_document_codelens
        au! * <buffer>
        autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
        augroup END
        ]]
    end
end

function M.get_lsp_client()
    local msg = ''
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
        return msg
    end

    local tbl = {}
    for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            table.insert(tbl, client.name)
        end
    end
    local res = table.concat(tbl, ",")
    return res

    -- for _, client in ipairs(clients) do
    --     local filetypes = client.config.filetypes
    --     if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then return client.name end
    -- end
    -- return msg
end

vim.lsp.set_log_level(4)

require('mv.lsp.status').setup()

return M

