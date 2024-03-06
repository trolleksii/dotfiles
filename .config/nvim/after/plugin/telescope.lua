local builtin = require('telescope.builtin')
require('telescope').setup({
    defaults = {
        file_ignore_patterns = {
            '.git/', 'node_modules/', '.npm', '*.py[co]', '__pycache__', '*.pdf',
            '*.zip', '*.tar.gz', '*.tar.bz2', '*.rar', '*.7z', '*.iso', '*.tmp',
            '*.exe', '*.dll', '*.obj', '*.o', '*.a', '*.lib', '*.so', '*.dmg',
            '*.jpg', '*.jpeg', '*.png', '*.gif', '*.bmp', '*.tiff', '*.ico',
            '.terraform/', '.terraform.*', '.venv'
        },
        vimgrep_arguments = {
            'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case',
            '--hidden'
        },
        mappings = {
            i = {
                ["<C-o>"] = function(p_bufnr)
                    require("telescope.actions").send_selected_to_qflist(p_bufnr)
                    vim.cmd.cfdo("edit")
                end,
            },
        }
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = false, -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        }
    }
})

require('telescope').load_extension('fzf')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>ft', builtin.git_files, {})
