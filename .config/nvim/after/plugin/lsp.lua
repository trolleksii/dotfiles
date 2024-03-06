local lsp_zero = require('lsp-zero')

vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = { buffer = event.buf }

        -- these will be buffer-local keybindings
        -- because they only work if you have an active language server
        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    end
})

lsp_zero.on_attach(function(_, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })
end)

lsp_zero.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 5000,
    },
    servers = {
        ['lua_ls'] = 'lua',
        ['terraformls'] = 'terraform',
        ['gopls'] = 'go',
        ['jedi_language_server'] = 'python',
        ['elixirls'] = 'elixir',
    }
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local default_setup = function(server)
    require('lspconfig')[server].setup({
        capabilities = lsp_capabilities,
    })
end

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'gopls', 'dockerls', 'bashls', 'helm_ls', 'jsonls', 'lua_ls',
        'jedi_language_server', 'terraformls', 'elixirls'
    },
    handlers = {
        default_setup,
        lua_ls = function()
            local lua_opts = {
                capabilities = lsp_capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT'
                        },
                        diagnostics = {
                            globals = { 'vim' }
                        },
                        workspace = {
                            library = {
                                vim.env.VIMRUNTIME
                            }
                        }
                    }
                }
            }
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
        helm_ls = function()
            local helm_opts = {
                capabilities = lsp_capabilities,
                settings = {
                    ['helm-ls'] = {
                        logLevel = "info",
                        valuesFiles = {
                            mainValuesFile = "values.yaml",
                            lintOverlayValuesFile = "values.lint.yaml",
                            additionalValuesFilesGlobPattern = "values*.yaml"
                        },
                        yamlls = {
                            enabled = false
                        }
                    }
                }
            }
            require('lspconfig').helm_ls.setup(helm_opts)
        end,
        terraformls = function()
            require('lspconfig').terraformls.setup({
                capabilities = lsp_capabilities
            })
        end,
    },
})

local cmp = require('cmp')

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-k>'] = cmp.mapping.scroll_docs(-4),
        ['<C-j>'] = cmp.mapping.scroll_docs(4),
    }),
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
})
