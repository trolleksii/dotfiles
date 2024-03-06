local ensure_packer = function()
    local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
        vim.fn.execute('!git clone --depth 1 https://github.com/wbthomason/packer.nvim ' .. install_path)
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
    use('wbthomason/packer.nvim')

    use({
        'nvim-telescope/telescope.nvim',
        tag = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    })

    use({
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    })

    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    })

    use({ 'christoomey/vim-tmux-navigator' })

    use({
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    })

    use({
        'nvim-treesitter/nvim-treesitter',
        run = function()
            require('nvim-treesitter.install').update({ with_sync = true })
        end
    })

    use('nvim-treesitter/nvim-treesitter-context')
    use('theprimeagen/harpoon')
    use('mbbill/undotree')

    use({
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        }
    })

    use('tpope/vim-fugitive')

    use('folke/trouble.nvim')

    use('APZelos/blamer.nvim')

    use({ 'towolf/vim-helm', ft = { 'helm' } })

    use('github/copilot.vim')
    if packer_bootstrap then
        require('packer').sync()
    end
end)
