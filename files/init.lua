require("config.lazy")

local bind = vim.keymap.set

bind('n', '<leader><leader>', ':NvimTreeToggle<CR>', { silent = true })
bind('n', '<leader>tf', ':NvimTreeFindFile<CR>')

bind("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
bind("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
bind("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
bind("n", "<leader>bo", function() Snacks.bufdelete.other() end, { desc = "Delete Other Buffers" })

vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
