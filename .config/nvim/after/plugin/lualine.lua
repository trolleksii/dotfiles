require('lualine').setup({
    options = {
        icons_enabled = false,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 3000,
            winbar = 5000
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'filename' },
        lualine_c = { 'branch', 'diff', 'diagnostics' },
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'progress' }
    },
})
