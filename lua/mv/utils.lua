local M = {}

--- Prepend # to the given string if necessary
function M.W(s)
    if s:find("#", 1, true) == 1 then
        return s
    end

    return "#" .. s
end

return M
