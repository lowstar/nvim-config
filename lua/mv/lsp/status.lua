local lsp_status = require "lsp-status"

local M = {}

M.setup = function()
    lsp_status.config { indicator_separator = '', component_separator = ' ', status_symbol = '', diagnostics = false }

    lsp_status.register_progress()
end

return M
