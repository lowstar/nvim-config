vim.o.ts = 8
vim.o.sw = 8
vim.o.sts = 8
vim.o.expandtab = false
vim.o.smartindent = true
vim.o.wrap = false
vim.o.hidden = true
vim.o.modelines = 1
vim.o.laststatus = 2
vim.o.cmdheight = 1
vim.o.lazyredraw = true
vim.o.history = 1000
vim.o.title = true
vim.o.showmode = false
vim.o.scrolloff = 5
vim.o.listchars = "tab:>⋅,eol:↩,extends:…,precedes:…,trail:⋅"
vim.o.list = true
vim.o.showbreak = "↪"
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.formatoptions = "qrn12j"
vim.o.signcolumn = "yes"
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.showmatch = true
vim.o.wildmode = "longest:full,full"
vim.o.wildoptions = "pum"
vim.o.wildignore = vim.o.wildignore .. ".hg,.git,.svn,*.DS_Store"
vim.o.completeopt = "menuone,noselect"
vim.o.timeout = false
vim.o.ttimeout = true
vim.o.ttimeoutlen = 10
vim.o.shortmess = vim.o.shortmess .. "c"
vim.o.updatetime = 250
vim.o.equalalways = false
vim.o.breakindent = true
vim.o.foldmethod = "marker"
vim.o.termguicolors = true
vim.o.undofile = true
vim.g.mapleader = ','

vim.o.mouse = 'a'

if vim.fn.executable('rg') then
    vim.o.grepprg = 'rg\\ --no-heading\\ --vimgrep'
    vim.o.grepformat = '%f:%l:%c:%m'
end

vim.cmd [[
    autocmd BufRead * autocmd FileType <buffer> ++once
      \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif
]]
