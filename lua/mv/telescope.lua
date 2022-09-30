local actions = require("telescope.actions")

require("telescope").setup({
    defaults = {
        prompt_prefix = "❯ ",
        selection_caret = "❯ ",

        mappings = {
            n = {
                ["<c-c>"] = actions.close,
            },
            i = {},
        },

        layout_config = {
            width = 0.95,
            height = 0.85,
            prompt_position = "top",

            horizontal = {
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
        },
    },
    extensions = {
        ["ui-select"] = { require("telescope.themes").get_dropdown() },
        fzf = { fuzzy = true, override_generic_sorter = false, override_file_sorter = true, case_mode = "smart_case" },
        file_browser = {
            theme = "ivy",
            mappings = {
                ["i"] = {},
            },
        },
    },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("ui-select")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("notify")

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
