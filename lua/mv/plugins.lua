local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.cmd("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    vim.cmd("packadd packer.nvim")
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

require("packer").init({
    display = {
        open_fn = "new [packer]",
    },
})

return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    use("base16-project/base16-vim")
    use("folke/tokyonight.nvim")
    use({ "catppuccin/nvim", as = "catppuccin" })

    use("ryanoasis/vim-devicons")
    use("kyazdani42/nvim-web-devicons")

    use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })

    use("nvim-lua/popup.nvim")
    use("nvim-lua/plenary.nvim")
    use("nvim-telescope/telescope.nvim")

    use({
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    })

    use("nvim-telescope/telescope-symbols.nvim")
    use("nvim-telescope/telescope-hop.nvim")
    use("nvim-telescope/telescope-ui-select.nvim")
    use("nvim-telescope/telescope-file-browser.nvim")

    use("neovim/nvim-lspconfig")
    use("onsails/lspkind-nvim")
    use("nvim-lua/lsp_extensions.nvim")
    use("nvim-lua/lsp-status.nvim")

    use("jose-elias-alvarez/null-ls.nvim")

    use("nvim-treesitter/nvim-treesitter")
    use("nvim-treesitter/nvim-treesitter-context")
    use("nvim-treesitter/nvim-treesitter-refactor")
    use("nvim-treesitter/nvim-treesitter-textobjects")
    use("nvim-treesitter/playground")
    use("p00f/nvim-ts-rainbow")
    use("JoosepAlviste/nvim-ts-context-commentstring")
    use("windwp/nvim-ts-autotag")

    use({
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
    })

    use({ "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons" })

    use("tpope/vim-fugitive")
    use("machakann/vim-sandwich")
    use("windwp/nvim-autopairs")
    use("tommcdo/vim-exchange")

    use("numToStr/Comment.nvim")

    use("lewis6991/gitsigns.nvim")

    -- use("mfussenegger/nvim-dap")
    -- use("rcarriga/nvim-dap-ui")
    -- use("leoluz/nvim-dap-go")

    use("simrat39/rust-tools.nvim")
    use("rust-lang/rust.vim")

    use({
        "phaazon/hop.nvim",
        config = function()
            require("hop").setup()
        end,
    })

    use({
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({ "css", "javascript", html = { mode = "foreground" } })
        end,
    })

    use({ "dstein64/vim-startuptime", cmd = "StartupTime" })

    use("rcarriga/nvim-notify")

    use("dhruvasagar/vim-table-mode")

    use("nvim-orgmode/orgmode")

    use("lvimuser/lsp-inlayhints.nvim")
    use({ "ThePrimeagen/harpoon", requires = "nvim-lua/plenary.nvim" })
end)
