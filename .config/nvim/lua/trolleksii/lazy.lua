local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
    },
    { 'christoomey/vim-tmux-navigator' },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    { 'nvim-treesitter/nvim-treesitter',  build = ':TSUpdate' },
    'nvim-treesitter/nvim-treesitter-context',
    'theprimeagen/harpoon',
    'mbbill/undotree',
    { 'VonHeikemen/lsp-zero.nvim',        branch = 'v3.x' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'L3MON4D3/LuaSnip' },
    'tpope/vim-surround',
    {
        'NeogitOrg/neogit',
        dependencies = {
            'nvim-lua/plenary.nvim',         -- required
            'sindrets/diffview.nvim',        -- optional - Diff integration
            'nvim-telescope/telescope.nvim', -- optional
            'lewis6991/gitsigns.nvim'
        },
        config = true
    },
    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        opts = {
            background_colour = '#000000'
        },
        dependencies = {
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
        }
    },
    'folke/trouble.nvim',
    { 'towolf/vim-helm', ft = { 'helm' } },
    'github/copilot.vim',
})
