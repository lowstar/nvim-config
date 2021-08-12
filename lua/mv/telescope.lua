local actions = require('telescope.actions')

require('telescope').setup {
    defaults = {
        file_sorter = require('telescope.sorters').get_fzy_sorter,

        prompt_prefix = '❯ ',
        selection_caret = '❯ ',

        mappings = { i = { ["<esc>"] = actions.close } },

        layout_config = {
            horizontal = { width_padding = 0.05, height_padding = 0.1, preview_width = 0.6 },

            prompt_position = "bottom"
        }
    },

    extensions = { fzy_native = { override_generic_sorter = false, override_file_sorter = true } },

    fzf_writer = { use_highlighter = false, minimum_grep_characters = 6 }
}

require('telescope').load_extension('fzy_native')

local M = {}

function M.files_config_nvim()
    require('telescope.builtin').find_files {
        prompt_title = "~ NVIM dotfiles ~",
        shorten_path = false,
        cwd = vim.fn.stdpath('config')
    }
end

function M.find_files()
    require('telescope.builtin').find_files {
        -- path_display = { "shorten" },
        previewer = false,
        file_ignore_patterns = { "target/.*" }
    }
end

function M.find_files_with_preview()
    require('telescope.builtin').find_files {
        -- path_display = { "shorten" },
        file_ignore_patterns = { "target/.*" }
    }
end

function M.live_grep()
    require('telescope').extensions.fzf_writer.staged_grep {
        -- path_display = { "shorten" },
        previewer = false,
        fzf_separator = "|>"
    }
end

function M.lsp_implementations()
    require("telescope.builtin").lsp_implementations {
        layout_strategy = "vertical",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        ignore_filename = false
    }
end

function M.lsp_references()
    require("telescope.builtin").lsp_references {
        layout_strategy = "vertical",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        ignore_filename = false
    }
end

function M.lsp_document_diagnostics()
    require("telescope.builtin").lsp_document_diagnostics {
        layout_strategy = "vertical",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        ignore_filename = false
    }
end

function M.lsp_document_symbols()
    require("telescope.builtin").lsp_document_symbols {
        layout_strategy = "vertical",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        ignore_filename = false
    }
end

function M.lsp_workspace_symbols()
    require("telescope.builtin").lsp_workspace_symbols {
        layout_strategy = "vertical",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        ignore_filename = false
    }
end

return M

