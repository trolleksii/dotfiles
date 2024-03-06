local jsonGroup = vim.api.nvim_create_augroup('json', {})

vim.api.nvim_create_autocmd('BufWinEnter', {
    group = jsonGroup,
    -- add
    pattern = '*.yaml',
    callback = function()
        vim.opt.expandtab = true
        vim.opt.shiftwidth = 2
        vim.opt.softtabstop = 2
    end,
})
