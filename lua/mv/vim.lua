local M = {}

M.highlight_link = function (group, linkto)
    vim.cmd('highlight! link ' .. group .. ' ' .. linkto)
end

M.highlight = function (group, opts)
    local opt_str = ''
    for k, v in pairs(opts) do
        opt_str = opt_str .. string.format(' %s=%s', k, v)
    end
    vim.cmd('highlight ' .. group .. opt_str)
end

return M

