local pythonGroup = vim.api.nvim_create_augroup('Python', {})

vim.api.nvim_create_autocmd('BufWinEnter', {
    group = pythonGroup,
    pattern = '*.py',
    callback = function()
        vim.opt.expandtab = true
        vim.opt.shiftwidth = 4
        vim.opt.softtabstop = 4
        vim.opt.colorcolumn = '80'
    end,
})
