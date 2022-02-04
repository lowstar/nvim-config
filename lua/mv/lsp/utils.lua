local M = {}

function M.lspstop()
    for _, client in ipairs(vim.lsp.buf_get_clients()) do
        client.stop()
    end
end

return M
