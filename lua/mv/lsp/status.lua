local lsp_status = require "lsp-status"

local M = {}

M.setup = function()
    lsp_status.config {
        indicator_separator = '',
        component_separator = ' ',
        status_symbol = ''
        -- select_symbol = status.select_symbol,
    }

    lsp_status.register_progress()
end

return M
