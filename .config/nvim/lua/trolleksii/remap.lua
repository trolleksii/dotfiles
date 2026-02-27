vim.g.mapleader = " "
vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)
vim.keymap.set("n", "<leader>w", function()
    vim.opt.wrap = not vim.opt.wrap:get()
end)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")


vim.keymap.set("n", "<leader>j", "<cmd>cnext<CR>", { silent = true })
vim.keymap.set("n", "<leader>k", "<cmd>cprev<CR>", { silent = true })

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>f", "<cmd>!tmux neww tmux-sessionizer<CR>", { silent = true })

vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

vim.keymap.set("n", "<leader>qq", "<cmd>:bw<CR>", { silent = true })
vim.keymap.set("n", "<leader>n", "<cmd>:bn<CR>", { silent = true })
vim.keymap.set("n", "<leader>p", "<cmd>:bp<CR>", { silent = true })

vim.keymap.set("n", "<M-Up>", "<C-Y>")
vim.keymap.set("n", "<M-Down>", "<C-E>")
