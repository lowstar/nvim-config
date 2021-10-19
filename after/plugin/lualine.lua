local my_lualine = {
    inactive = {
        a = { fg = '#' .. vim.g.base16_gui02, bg = '#' .. vim.g.base16_gui03, gui = 'bold' },
        z = { fg = '#' .. vim.g.base16_gui02, bg = '#' .. vim.g.base16_gui03, gui = 'bold' }
    },
    normal = {
        a = { fg = '#' .. vim.g.base16_gui02, bg = '#' .. vim.g.base16_gui0D, gui = 'bold' },
        b = { fg = '#' .. vim.g.base16_gui04, bg = '#' .. vim.g.base16_gui02 },
        c = { fg = '#' .. vim.g.base16_gui03, bg = '#' .. vim.g.base16_gui01 },
        x = { fg = '#' .. vim.g.base16_gui04, bg = '#' .. vim.g.base16_gui02 },
        y = { fg = '#' .. vim.g.base16_gui02, bg = '#' .. vim.g.base16_gui03, gui = 'bold' },
        z = { fg = '#' .. vim.g.base16_gui02, bg = '#' .. vim.g.base16_gui0D, gui = 'bold' }
    },
    visual = {
        a = { fg = '#' .. vim.g.base16_gui02, bg = '#' .. vim.g.base16_gui0E, gui = 'bold' },
        z = { fg = '#' .. vim.g.base16_gui02, bg = '#' .. vim.g.base16_gui0E, gui = 'bold' }
    },
    replace = {
        a = { fg = '#' .. vim.g.base16_gui02, bg = '#' .. vim.g.base16_gui09, gui = 'bold' },
        z = { fg = '#' .. vim.g.base16_gui02, bg = '#' .. vim.g.base16_gui09, gui = 'bold' }
    },
    insert = {
        a = { fg = '#' .. vim.g.base16_gui02, bg = '#' .. vim.g.base16_gui0B, gui = 'bold' },
        z = { fg = '#' .. vim.g.base16_gui02, bg = '#' .. vim.g.base16_gui0B, gui = 'bold' }
    },
    command = {
        a = { fg = '#' .. vim.g.base16_gui02, bg = '#' .. vim.g.base16_gui08, gui = 'bold' },
        z = { fg = '#' .. vim.g.base16_gui02, bg = '#' .. vim.g.base16_gui08, gui = 'bold' }
    }
}

local my_fileformat = function()
    return vim.bo.fileformat
end

local function get_lsp_clients()
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
end

local function my_lsp_status()
    if #vim.lsp.buf_get_clients() > 0 then
        local content = require'lsp-status'.status():match("^%s*(.-)%s*$")
        if #content == 0 then
            return get_lsp_clients()
        end
        return content
    end
    return ''
end

require'lualine'.setup({
    options = { theme = my_lualine, section_separators = { '', '' }, component_separators = { '|', '|' } },
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

