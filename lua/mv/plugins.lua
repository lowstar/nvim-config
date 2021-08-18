local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    vim.cmd('packadd packer.nvim')
end

vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile'

require('packer').init { display = { open_fn = 'new [packer]' } }

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'nanotee/nvim-lua-guide'

    use 'chriskempson/base16-vim'
    use 'machakann/vim-highlightedyank'

    use {
        'airblade/vim-rooter',
        config = function()
            vim.g.rooter_patterns = { ".git", "Makefile", "package.json", "Cargo.toml", "pom.xml" }
        end
    }

    use 'ryanoasis/vim-devicons'
    use 'kyazdani42/nvim-web-devicons'
    use 'kyazdani42/nvim-tree.lua'

    use { 'hoob3rt/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }

    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'

    if vim.fn.has('bsd') then
        use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'gmake' }
    else
        use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    end

    use 'nvim-telescope/telescope-symbols.nvim'
    use 'nvim-telescope/telescope-hop.nvim'

    use 'neovim/nvim-lspconfig'
    use 'onsails/lspkind-nvim'
    use 'nvim-lua/lsp_extensions.nvim'
    use 'glepnir/lspsaga.nvim'
    use 'wbthomason/lsp-status.nvim'
    use 'kosayoda/nvim-lightbulb'

    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/nvim-treesitter-refactor'
    use 'nvim-treesitter/playground'
    use 'p00f/nvim-ts-rainbow'
    use 'JoosepAlviste/nvim-ts-context-commentstring'
    use 'windwp/nvim-ts-autotag'

    use 'hrsh7th/nvim-compe'
    use 'hrsh7th/vim-vsnip'

    use 'airblade/vim-gitgutter'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use 'windwp/nvim-autopairs'
    use 'tommcdo/vim-exchange'

    use 'simrat39/rust-tools.nvim'
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'

    use 'rust-lang/rust.vim'

    use {
        'phaazon/hop.nvim',
        config = function()
            require'hop'.setup()
        end
    }
end)
