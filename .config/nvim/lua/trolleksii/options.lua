-- See `:help vim.opt`
vim.opt.guicursor = ''

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Set highlight on search
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.nvim/undodir'
vim.opt.undofile = true

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Sync clipboard between OS and Neovim. --  Remove this option if you want your OS clipboard to remain independent. --  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.wrap = false
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.opt.termguicolors = true

vim.opt.scrolloff = 3

vim.opt.fillchars = { eob = " " }
