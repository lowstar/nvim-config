local actions = require("telescope.actions")
local fb_actions = require('telescope').extensions.file_browser.actions

require("telescope").setup({
    defaults = {
        prompt_prefix = "❯ ",
        selection_caret = "❯ ",

        mappings = {
            i = {
                ["<esc>"] = actions.close,
                ["<C-h>"] = require("telescope").extensions.hop.hop,
                ["<C-space>"] = function(prompt_bufnr)
                    local opts = {
                        callback = actions.toggle_selection,
                        loop_callback = actions.send_selected_to_qflist,
                    }
                    require("telescope").extensions.hop._hop_loop(prompt_bufnr, opts)
                end,
            },
        },

        layout_config = {
            width = 0.95,
            height = 0.85,
            prompt_position = "top",

            horizontal = {
                -- width_padding = 0.1,
                -- height_padding = 0.1,
                preview_width = function(_, cols, _)
                    if cols > 200 then
                        return math.floor(cols * 0.4)
                    else
                        return math.floor(cols * 0.6)
                    end
                end,
            },
        },

        file_ignore_patterns = { "node_modules", "target", ".git", ".vscode" },
    },
    pickers = {
        find_files = { theme = "ivy" },
        file_browser = { theme = "ivy" },
        buffers = {
            mappings = {
                i = { ["<c-d>"] = require("telescope.actions").delete_buffer },
                n = { ["<c-d>"] = require("telescope.actions").delete_buffer },
            },
            -- theme = "ivy"
        },
        -- live_grep = { theme = "ivy" }
    },
    extensions = {
        ["ui-select"] = { require("telescope.themes").get_dropdown() },
        fzf = { fuzzy = true, override_generic_sorter = false, override_file_sorter = true, case_mode = "smart_case" },
        hop = {
            -- keys define your hop keys in order; defaults to roughly lower- and uppercased home row
            -- shown keys here are only subset of defaults!
            -- keys = { "a", "s", "d", "f", "g", "h", "j", "k", "l", ";" }, -- ... and more

            -- Highlight groups to link to signs and lines; the below configuration refers to demo
            -- sign_hl typically only defines foreground to possibly be combined with line_hl
            sign_hl = { "WarningMsg", "Title" },
            -- optional, typically a table of two highlight groups that are alternated between
            line_hl = { "CursorLine", "Normal" },
            -- options specific to `hop_loop`
            -- true temporarily disables Telescope selection highlighting
            clear_selection_hl = false,
            -- highlight hopped to entry with telescope selection highlight
            -- note: mutually exclusive with `clear_selection_hl`
            trace_entry = true,
            -- jump to entry where hoop loop was started from
            reset_selection = true,
        },
        file_browser = {
            theme = "ivy",
            mappings = {
                ["i"] = {
                    ["~"] = fb_actions.goto_home_dir
                }
            }
        },
    },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("hop")
require("telescope").load_extension("ui-select")
require("telescope").load_extension("file_browser")

local M = {}

function M.files_config_nvim()
    require("telescope.builtin").find_files({
        prompt_title = "~ NVIM dotfiles ~",
        shorten_path = false,
        cwd = vim.fn.stdpath("config"),
    })
end

function M.lsp_implementations()
    require("telescope.builtin").lsp_implementations({
        layout_strategy = "vertical",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        ignore_filename = false,
    })
end

function M.lsp_references()
    require("telescope.builtin").lsp_references({
        layout_strategy = "vertical",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        ignore_filename = false,
    })
end

function M.lsp_document_diagnostics()
    require("telescope.builtin").lsp_document_diagnostics({
        layout_strategy = "vertical",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        ignore_filename = false,
    })
end

function M.lsp_document_symbols()
    require("telescope.builtin").lsp_document_symbols({
        layout_strategy = "vertical",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        ignore_filename = false,
    })
end

function M.lsp_workspace_symbols()
    require("telescope.builtin").lsp_workspace_symbols({
        layout_strategy = "vertical",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        ignore_filename = false,
    })
end

return M
