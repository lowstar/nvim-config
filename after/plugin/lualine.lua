local colors = {
    base3 = '#cccccc',
    base23 = '#bbbbbb',
    base2 = '#aaaaaa',
    base1 = '#999999',
    base0 = '#777777',
    base00 = '#666666',
    base01 = '#555555',
    base02 = '#444444',
    base023 = '#333333',
    base03 = '#2d2d2d',
    red = '#f2777a',
    orange = '#f99157',
    yellow = '#ffcc66',
    green = '#99cc99',
    cyan = '#009999',
    blue = '#99cccc',
    magenta = '#cc99cc'

}

local tomorrow_night = {
    inactive = {
        a = { fg = colors.base3, bg = colors.base01, gui = 'bold' },
        z = { fg = colors.base02, bg = colors.base1, gui = 'bold' }
    },
    normal = {
        a = { fg = colors.base023, bg = colors.blue, gui = 'bold' },
        b = { fg = colors.base3, bg = colors.base01 },
        c = { fg = colors.base1, bg = colors.base02 },
        x = { fg = colors.base2, bg = colors.base01 },
        y = { fg = colors.base02, bg = colors.base1, gui = 'bold' },
        z = { fg = colors.base023, bg = colors.blue, gui = 'bold' }
    },
    visual = {
        a = { fg = colors.base023, bg = colors.magenta, gui = 'bold' },
        z = { fg = colors.base023, bg = colors.magenta, gui = 'bold' }
    },
    replace = {
        a = { fg = colors.base023, bg = colors.orange, gui = 'bold' },
        z = { fg = colors.base023, bg = colors.orange, gui = 'bold' }
    },
    insert = {
        a = { fg = colors.base023, bg = colors.green, gui = 'bold' },
        z = { fg = colors.base023, bg = colors.green, gui = 'bold' }
    },
    command = {
        a = { fg = colors.base023, bg = colors.red, gui = 'bold' },
        z = { fg = colors.base023, bg = colors.red, gui = 'bold' }
    }
}

local my_fileformat = function()
    return vim.bo.fileformat
end

local messages = require('lsp-status/messaging').messages

local my_lsp_status = function()
    local spinner_frames = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' }
    local buf_messages = messages()
    local msgs = {}

    for _, msg in ipairs(buf_messages) do
        local name = msg.name
        local client_name = '[' .. name .. ']'
        local contents
        if msg.progress then
            contents = msg.title
            if msg.message then
                contents = contents .. ' ' .. msg.message
            end

            -- this percentage format string escapes a percent sign once to show a percentage and one more
            -- time to prevent errors in vim statusline's because of it's treatment of % chars
            if msg.percentage then
                contents = contents .. string.format(" (%.0f%%%%)", msg.percentage)
            end

            if msg.spinner then
                contents = spinner_frames[(msg.spinner % #spinner_frames) + 1] .. ' ' .. contents
            end
        elseif msg.status then
            contents = msg.content
            if msg.uri then
                local filename = vim.uri_to_fname(msg.uri)
                filename = vim.fn.fnamemodify(filename, ':~:.')
                local space = math.min(60, math.floor(0.6 * vim.fn.winwidth(0)))
                if #filename > space then
                    filename = vim.fn.pathshorten(filename)
                end

                contents = '(' .. filename .. ') ' .. contents
            end
        else
            contents = msg.content
        end
        table.insert(msgs, client_name .. ' ' .. contents)
    end

    if #msgs > 0 then
        return table.concat(msgs, '')
    else
        return require'mv.lsp'.get_lsp_client()
    end
end

require'lualine'.setup({
    -- options = { theme = tomorrow_night, section_separators = { '', '' }, component_separators = { '|', '|' } },
    options = {
        theme = (vim.env.ITERM_PROFILE == 'light' and 'tomorrow' or tomorrow_night),
        section_separators = { '', '' },
        component_separators = { '|', '|' }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', { 'diagnostics', sources = { 'nvim_lsp' } } },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { my_lsp_status, my_fileformat, 'encoding', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', { 'diagnostics', sources = { 'nvim_lsp' } } },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { my_lsp_status, my_fileformat, 'encoding', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    extensions = { 'fugitive' }
})

