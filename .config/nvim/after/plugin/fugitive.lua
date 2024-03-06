local fugitiveGroup = vim.api.nvim_create_augroup('Fugitive', {})

vim.keymap.set('n', '<leader>gs', vim.cmd.Git)

vim.api.nvim_create_autocmd('BufWinEnter', {
  group = fugitiveGroup,
  pattern = '*',
  callback = function()
    if vim.bo.filetype ~= 'fugitive' then
      return
    end

    local bufn = vim.api.nvim_get_current_buf()
    local opts = { buffer = bufn, remap = false }
    vim.keymap.set('n', '<leader>p', function()
      vim.cmd.Git('push')
    end, opts)

    vim.keymap.set('n', '<leader>P', function()
      vim.cmd.Git('pull --rebase')
    end, opts)

    vim.keymap.set('n', '<leader>t', ':Git push -u origin', opts)
  end,
})
