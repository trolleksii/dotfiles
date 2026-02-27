local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

local debug_table = function(tbl)
  -- Create scratch buffer
  local buf = vim.api.nvim_create_buf(false, true)
  
  local lines = {}
  -- Pretty print the table
  local content = vim.inspect(tbl)
  vim.list_extend(lines, vim.split(content, '\n'))
  
  -- Set buffer content and options
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(buf, 'filetype', 'lua')
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)
  
  -- Open in vertical split
  vim.cmd('vsplit')
  vim.api.nvim_set_current_buf(buf)
end

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
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-context',
            'nvim-treesitter/nvim-treesitter-textobjects',
        }
    },
    'theprimeagen/harpoon',
    'mbbill/undotree',
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'L3MON4D3/LuaSnip' },
    { 'saadparwaiz1/cmp_luasnip' },
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
            background_colour = '#000000',
        },
        dependencies = {
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
        }
    },
    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },
    { 'towolf/vim-helm', ft = { 'helm' } },
    {
        'folke/zen-mode.nvim',
        opts = {
            window = {
                width = 150
            },
            plugins = {
                kitty = {
                    enabled = false,
                    font = "+4"
                }
            }
        }
    },
    {
        'sudormrfbin/cheatsheet.nvim',
        dependencies = {
            { 'nvim-telescope/telescope.nvim' },
            { 'nvim-lua/popup.nvim' },
            { 'nvim-lua/plenary.nvim' },
        }
    },
    {
      'pwntester/octo.nvim',
      cmd = 'Octo',
      opts = {
        picker = "telescope",
        enable_builtin = true,
      },
      keys = {
        {
          "<leader>oi",
          "<CMD>Octo issue list<CR>",
          desc = "List GitHub Issues",
        },
        {
          "<leader>op",
          "<CMD>Octo pr list<CR>",
          desc = "List GitHub PullRequests",
        },
        {
          "<leader>od",
          "<CMD>Octo discussion list<CR>",
          desc = "List GitHub Discussions",
        },
        {
          "<leader>on",
          "<CMD>Octo notification list<CR>",
          desc = "List GitHub Notifications",
        },
        {
          "<leader>os",
          function()
            require("octo.utils").create_base_search_command { include_current_repo = true }
          end,
          desc = "Search GitHub",
        },
      },
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "nvim-tree/nvim-web-devicons",
      },
    },
    {
        'gsuuon/model.nvim',
        cmd = { 'M', 'Model', 'Mchat' },
        init = function()
            vim.filetype.add({
                extension = {
                    mchat = 'mchat',
                }
            })
        end,
        ft = 'mchat',
        keys = {
            { '<C-m>d',       ':Mdelete<cr>', mode = 'n' },
            { '<C-m>s',       ':Mselect<cr>', mode = 'n' },
            { '<C-m><space>', ':Mchat<cr>',   mode = 'n' }
        },

        config = function()
            local ollama = require('model.providers.ollama')
            local ollama_cfg = {
                url = 'http://192.168.0.10:11434',
            }
            require('model').setup({
                default_prompt = {
                    provider = ollama,
                    options = ollama_cfg,
                    params = {
                        model = 'qwen3-coder:latest',
                        options = {
                            temperature = 0.2,
                            top_p = 0.9,
                            top_k = 20,
                        }
                    },
                    mode = require('model').mode.APPEND,
                    builder = function(input, context)
                        local prompt = "<|im_start|>system\n"
                            .. "You are an AI assistant built for the senior software engineer. The user values precision and brevity "
                            .. "above all else.\n\n Task: You need to create a block of code following users description.\n<|im_end|>\n"
                            .. "<|im_start|>user\n"
                            .. "Filename: " .. context.filename .. "\n"
                            .. "Code befor the cursor:\n" .. context.before
                            .. "Code after the cursor:\n" .. context.after
                            .. "Request:\n" .. input .. "\n<|im_end|>\n"
                            .. "<|im_start|>assistant\n"
                        return {
                            prompt = prompt
                        }
                    end
                },
                -- Custom prompts for different tasks
                prompts = {
                    -- Fill in the middle
                    ['fim'] = {
                        provider = ollama,
                        options = ollama_cfg,
                        params = {
                            model = 'qwen3-coder:latest',
                            options = {
                                temperature = 0.5,
                                top_p = 0.9,
                                top_k = 20,
                            }
                        },
                        mode = require('model').mode.INSERT_OR_REPLACE,
                        builder = function(input, context)
                            local prompt = "<|im_start|>system\n"
                                .. "Fill in the missing code between prefix and suffix. Only output the missing code, no explanations.\n"
                                .. "The code should do the following:\n" .. input
                                .. "\n<|im_end|>\n"
                                .. "<|im_start|>user\n"
                                .. "<prefix>\n" .. context.before .. "\n</prefix>\n"
                                .. "<suffix>\n" .. context.after .. "\n</suffix>\n<|im_end|>\n"
                                .. "<|im_start|>assistant\n"
                            return {
                                prompt = prompt
                            }
                        end
                    },
                    -- Explain code
                    ['explain'] = {
                        provider = ollama,
                        options = ollama_cfg,
                        params = {
                            model = 'qwen3-coder:latest',
                            options = {
                                temperature = 0.6,
                                top_p = 0.9,
                                top_k = 20,
                            }
                        },
                        mode = require('model').mode.BUFFER,
                        builder = function(input, context)
                            local prompt = "<|im_start|>system\n"
                                .. "You are an AI assistant built for the senior software engineer. The user values precision and brevity "
                                .. "above all else.\n\n Task: You need to explain a block of code. The input data will come in three chunks:\n"
                                .. "Before:\n ...\nCode to explain:\n ...\nAfter:\n ...\n While `Before` and `After` can be useful to understand "
                                .. "the project better, you need to focus on explaining the block `Code to explain`.<|im_end|>\n"
                                .. "<|im_start|>user\nBefore:\n" .. context.before
                                .. "\nCode to explain:\n" .. input
                                .. "After:\n" .. context.after .. "\n<|im_end|>\n"
                                .. "<|im_start|>assistant\n"
                            return {
                                prompt = prompt
                            }
                        end
                    },

                    -- Fix/improve code
                    ['fix'] = {
                        provider = ollama,
                        options = ollama_cfg,
                        params = {
                            model = 'qwen3-coder:latest',
                            options = {
                                temperature = 0.2,
                                top_p = 0.9,
                                top_k = 20,
                            }
                        },
                        mode = require('model').mode.REPLACE,
                        builder = function(input, context)
                            local prompt = "<|im_start|>system\n"
                                .. "You will be reviewing and corecting the code. You will be provided with a filename, <|im_end|>"
                                .. "<|im_start|>user"
                                .. "\nFilename: " .. context.filename
                                .. "\nBefore:\n```go\n" .. context.before
                                .. "\n```\nAfter:\n```go\n" .. context.after
                                .. "\n```\nCode to review and correct:\n```go\n"
                                .. input
                                .. "\n```<|im_end|>"
                                .. "<|im_start|>assistant\n```go\n"
                            return {
                                prompt = prompt
                            }
                        end
                    },
                },

                -- Chat prompts for conversations
                chats = {
                    ['chat'] = {
                        provider = ollama,
                        options = ollama_cfg,
                        params = {
                            model = 'qwen3-coder:latest',
                            options = {
                                temperature = 0.6,
                                top_p = 0.9,
                                top_k = 20,
                            }
                        },
                        system = "You are a senior software engineer. Provide brief, actionable responses. "
                            .. "Focus on practical solutions with commands and code snippets. "
                            .. "Use bullet points for multiple steps. Avoid long explanations unless specifically asked.",
                        create = function(input, context)
                            return input
                        end,
                        run = function(messages, config)
                            local prompt = ""

                            if config.system then
                                prompt = "<|im_start|>system\n" .. config.system .. "<|im_end|>\n"
                            end

                            for _, message in ipairs(messages) do
                                prompt = prompt .. "<|im_start|>" .. message.role .. "\n"
                                    .. message.content .. "<|im_end|>\n"
                            end

                            prompt = prompt .. "<|im_start|>assistant\n"

                            return {
                                prompt = prompt,
                                raw = true
                            }
                        end
                    },
                }
            })
        end
    }
    --'github/copilot.vim',
})

