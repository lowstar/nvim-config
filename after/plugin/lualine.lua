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

local function my_lsp_status()
    if #vim.lsp.buf_get_clients() > 0 then
        local content = require'lsp-status'.status():match("^%s*(.-)%s*$")
        if #content == 0 then
            return require'mv.lsp'.get_lsp_client()
        end
        return content
    end
    return ''
end

require'lualine'.setup({
    options = {
        theme = my_lualine,
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

