require("catppuccin").setup({
    flavour = "mocha",             -- latte, frappe, macchiato, mocha
    transparent_background = true, -- disables setting the background color.
    show_end_of_buffer = false,    -- shows the '~' characters after the end of buffers

    dim_inactive = {
        enabled = true,    -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },

    color_overrides = {
        all = {
            surface1 = "#6e738d", --line numbers
            overlay0 = "#6e738d", --comments
        }
    }
})

vim.o.termguicolors = true
-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"
