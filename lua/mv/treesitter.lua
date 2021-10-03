require'nvim-treesitter.configs'.setup {
    ensure_installed = 'maintained',
    highlight = {
        enable = true -- false will disable the whole extension
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<M-w>",
            node_incremental = "<M-w>",
            scope_incremental = "<M-e>",
            node_decremental = "<M-C-w>"
            -- init_selection = "gnn",
            -- node_incremental = "grn",
            -- scope_incremental = "grc",
            -- node_decremental = "grm",
        }
    },
    indent = { enable = true },
    context_commentstring = { enable = true },
    autotag = { enable = true },
    rainbow = { enable = true },
    playground = {
        enable = true,
        disable = {},
        updatetime = 25 -- Debounced time for highlighting nodes in the playground from source code
    },
    refactor = {
        highlight_definitions = { enable = true },
        -- smart_rename = {
        --     enable = true,
        --     keymaps = {
        --         smart_rename = "grr",
        --     },
        -- },
        navigation = {
            enable = true,
            keymaps = {
                goto_definition = "gnd",
                list_definitions = "gnD",
                list_definitions_toc = "gO",
                goto_next_usage = "<a-*>",
                goto_previous_usage = "<a-#>"
            }
        }
    }
}

