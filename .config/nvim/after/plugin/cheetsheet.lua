require("cheatsheet").setup({
    bundled_cheatsheets = {
        enabled = {
            "default",
            "regex"
        },
        bundled_plugin_cheatsheets = {
            enable = {
                "gitsigns",
                "telescope",
            }
        }
    },
    telescope_mappings = {
        ['<CR>'] = require('cheatsheet.telescope.actions').select_or_fill_commandline,
        ['<A-CR>'] = require('cheatsheet.telescope.actions').select_or_execute,
        ['<C-Y>'] = require('cheatsheet.telescope.actions').copy_cheat_value,
        ['<C-E>'] = require('cheatsheet.telescope.actions').edit_user_cheatsheet,
    }
})
