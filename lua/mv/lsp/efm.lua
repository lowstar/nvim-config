local lspconfig = require('lspconfig')

local clangFormat = { formatCommand = "clang-format", formatStdin = true }

local luaFormat = { formatCommand = "lua-format -i", formatStdin = true }

local prettier_global = { formatCommand = "prettier --stdin-filepath ${INPUT}", formatStdin = true }

require'lspconfig'.efm.setup {
    init_options = { documentFormatting = true, codeAction = false },
    root_dir = function(fname)
        local bufdir = vim.fn.expand('%:p:h')
        return lspconfig.util.root_pattern(".prettier*")(fname) or
                   lspconfig.util.root_pattern(".clang-format")(fname) or
                   lspconfig.util.root_pattern(".rustfmt.toml")(fname) or
                   lspconfig.util.root_pattern(".git/")(fname) or bufdir
    end,

    filetypes = { "lua", "javascript", "javascriptreact", "c", "cpp" },
    settings = {
        rootMarkers = { ".git/" },
        languages = {
            lua = { luaFormat },
            javascript = { prettier_global },
            javascriptreact = { prettier_global },
            c = { clangFormat },
            cpp = { clangFormat }
        }
    },
    on_attach = require'mv.lsp'.common_on_attach
}
