local bind = vim.keymap.set

bind('n', '<leader><leader>', ':NvimTreeToggle<CR>', { silent = true })
bind('n', '<leader>tf', ':NvimTreeFindFile<CR>')

bind("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
bind("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
bind("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
bind("n", "<leader>bo", function() Snacks.bufdelete.other() end, { desc = "Delete Other Buffers" })

bind('n', '<Esc>', '<cmd>nohlsearch<CR>')

bind('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
bind('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
bind('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
bind('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

bind('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev Diagnostic' })
bind('n', ']d', vim.diagnostic.goto_next, { desc = 'Next Diagnostic' })
bind('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
