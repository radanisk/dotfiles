local bind = vim.keymap.set

bind('n', '<leader>fe', ':NvimTreeToggle<CR>', { silent = true, desc = 'Toggle File Explorer' })
bind('n', '<leader>fr', ':NvimTreeFindFile<CR>', { desc = 'Reveal File in Explorer' })

bind("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

bind('n', '<Esc>', '<cmd>nohlsearch<CR>')

bind('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev Diagnostic' })
bind('n', ']d', vim.diagnostic.goto_next, { desc = 'Next Diagnostic' })
bind('n', '<leader>xd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
