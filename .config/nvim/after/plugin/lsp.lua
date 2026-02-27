local cmp = require('cmp')

cmp.setup({
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip', priority = 900, group_index = 2 },
    }, {
        { name = 'buffer' },
    }),
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
    }),
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },
})

local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lspconfig_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

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

vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

local default_setup = function(server)
    require('lspconfig')[server].setup({
        capabilities = lspconfig_defaults,
    })
end

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'gopls', 'dockerls', 'bashls', 'helm_ls', 'jsonls', 'lua_ls',
        'pyright', 'terraformls', 'elixirls'
    },
    handlers = {
        default_setup,
        lua_ls = function()
            local lua_opts = {
                capabilities = lspconfig_defaults,
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
                capabilities = lspconfig_defaults,
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
                capabilities = lspconfig_defaults,
            })
        end,
        elixirls = function()
            require('lspconfig').elixirls.setup({
                capabilities = lspconfig_defaults,
            })
        end,
        gopls = function()
            require('lspconfig').gopls.setup({
                capabilities = lspconfig_defaults,
            })
        end,
        pyright = function()
            require('lspconfig').pyright.setup({
                capabilities = lspconfig_defaults,
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = "off"
                        }
                    }
                }
            })
        end,
    },
})
