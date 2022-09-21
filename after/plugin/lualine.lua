local lsp_status = require("lsp-status")

local function lualine_theme()
    if vim.g.colors_name == "tokyonight" then
        return "tokyonight"
    elseif vim.g.colors_name == "catppuccin" then
        return "catppuccin"
    else
        local W = require("mv.utils").W
        return {
            inactive = {
                a = { fg = W(vim.g.base16_gui02), bg = W(vim.g.base16_gui03), gui = "bold" },
                z = { fg = W(vim.g.base16_gui02), bg = W(vim.g.base16_gui03), gui = "bold" },
            },
            normal = {
                a = { fg = W(vim.g.base16_gui00), bg = W(vim.g.base16_gui0D), gui = "bold" },
                b = { fg = W(vim.g.base16_gui04), bg = W(vim.g.base16_gui02) },
                c = { fg = W(vim.g.base16_gui03), bg = W(vim.g.base16_gui01) },
                x = { fg = W(vim.g.base16_gui04), bg = W(vim.g.base16_gui02) },
                y = { fg = W(vim.g.base16_gui02), bg = W(vim.g.base16_gui03), gui = "bold" },
                z = { fg = W(vim.g.base16_gui00), bg = W(vim.g.base16_gui0D), gui = "bold" },
            },
            visual = {
                a = { fg = W(vim.g.base16_gui02), bg = W(vim.g.base16_gui0E), gui = "bold" },
                z = { fg = W(vim.g.base16_gui02), bg = W(vim.g.base16_gui0E), gui = "bold" },
            },
            replace = {
                a = { fg = W(vim.g.base16_gui02), bg = W(vim.g.base16_gui09), gui = "bold" },
                z = { fg = W(vim.g.base16_gui02), bg = W(vim.g.base16_gui09), gui = "bold" },
            },
            insert = {
                a = { fg = W(vim.g.base16_gui02), bg = W(vim.g.base16_gui0B), gui = "bold" },
                z = { fg = W(vim.g.base16_gui02), bg = W(vim.g.base16_gui0B), gui = "bold" },
            },
            command = {
                a = { fg = W(vim.g.base16_gui02), bg = W(vim.g.base16_gui08), gui = "bold" },
                z = { fg = W(vim.g.base16_gui02), bg = W(vim.g.base16_gui08), gui = "bold" },
            },
        }
    end
end

local function get_lsp_clients()
    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
    local clients = vim.lsp.buf_get_clients()
    if vim.tbl_count(clients) == 0 then
        return ""
    end

    local tbl = {}
    for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            table.insert(tbl, client.name)
        end
    end
    local res = "[" .. table.concat(tbl, ",") .. "]"
    return res
end

local function my_lsp_status()
    if vim.tbl_count(vim.lsp.buf_get_clients()) == 0 then
        return ""
    end

    local content = lsp_status.status():match("^%s*(.-)%s*$")
    if #content == 0 then
        return get_lsp_clients()
    end
    return content
end

local sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { { "filename", path = 1 } },
    lualine_x = {
        my_lsp_status,
        "encoding",
        { "fileformat", symbols = { unix = "unix", dos = "dos", mac = "mac" } },
        "filetype",
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
}

require("lualine").setup({
    options = {
        theme = lualine_theme(),
        section_separators = { "", "" },
        component_separators = { "|", "|" },
        globalstatus = true,
    },
    sections = sections,
    extensions = { "fugitive", "quickfix" },
})
