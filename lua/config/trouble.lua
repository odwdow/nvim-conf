local trouble = require("trouble")

trouble.setup({
  cmd = "Trouble",
})

vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<CR>')
vim.keymap.set('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>')
vim.keymap.set('n', '<leader>xcs', '<cmd>Trouble symbols toggle focus=false<CR>')
vim.keymap.set('n', '<leader>xcl', '<cmd>Trouble lsp toggle focus=false win.position=right<CR>')
vim.keymap.set('n', '<leader>xL', '<cmd>Trouble loclist toggle<CR>')
vim.keymap.set('n', '<leader>xQ', '<cmd>Trouble qflist toggle<CR>')
