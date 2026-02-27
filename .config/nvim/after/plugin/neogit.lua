require('gitsigns').setup {
    current_line_blame = true,
    signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
    },
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, { expr = true })

        map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, { expr = true })

        -- Actions
        map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
        map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
        map('n', '<leader>hS', gs.stage_buffer)
        map('n', '<leader>ha', gs.stage_hunk)
        map('n', '<leader>hu', gs.undo_stage_hunk)
        map('n', '<leader>hR', gs.reset_buffer)
        map('n', '<leader>hp', gs.preview_hunk)
        map('n', '<leader>hb', function() gs.blame_line { full = true } end)
        map('n', '<leader>tb', ':Gitsigns blame<CR>')
        map('n', '<leader>hd', gs.diffthis)
        map('n', '<leader>hD', function() gs.diffthis('~') end)
        map('n', '<leader>td', gs.toggle_deleted)

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
}
--vim.keymap.set('n', '<leader>gs', ':Neogit kind=floating<CR>')
vim.keymap.set('n', '<leader>gs', ':Neogit<CR>')
require("neogit").setup({
    git_services = {
        ["github.com"] = {
            pull_request = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
            commit = "https://github.com/${owner}/${repository}/commit/${oid}",
            tree = "https://github.com/${owner}/${repository}/tree/${branch_name}",
        },
    },
    integrations = {
        telescope = true,
        diffview = true
    },
})
--require("octo").setup({
--    enable_builtin = true
--})
--vim.keymap.set('n', '<leader>O', ':Octo<CR>')
--vim.keymap.set('n', '<leader>Opc', ':Octo pr create<CR>')
--vim.keymap.set('n', '<leader>Opl', ':Octo pr list<CR>')
--vim.keymap.set('n', '<leader>Opr', ':Octo pr reload<CR>')
--vim.keymap.set('n', '<leader>Opm', ':Octo pr merge<CR>')
