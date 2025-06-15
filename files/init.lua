require("config.lazy")

require('nvim-treesitter.configs').setup {
  auto_install = true,
  ensure_installed = { 'go', 'gomod', 'gowork', 'gosum', 'lua', 'ruby', 'vimdoc', 'vim', 'yaml' },
  endwise = { enable = true },
  highlight = { enable = true }, -- false will disable the whole extension
  incremental_selection = { enable = true },
}

local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
  vim.keymap.set('n', "gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, {desc = "Goto Definition", buffer = bufnr})
  vim.keymap.set('n', "gr", "<cmd>Telescope lsp_references<cr>", {desc = "References", buffer = bufnr})
  vim.keymap.set('n', "gI", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, {desc = "Goto Implementation", buffer = bufnr })
  vim.keymap.set('n', "gy", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, {desc = "Goto T[y]pe Definition", buffer = bufnr })
  vim.keymap.set('n', "gK", vim.lsp.buf.signature_help, {desc = "Signature Help", buffer = bufnr})
  vim.keymap.set('i', "<c-k>", vim.lsp.buf.signature_help, {desc = "Signature Help", buffer = bufnr})
  vim.keymap.set('n', "<leader>ca", vim.lsp.buf.code_action, {desc = "Code Action", buffer = bufnr})
  vim.keymap.set('v', "<leader>ca", vim.lsp.buf.code_action, {desc = "Code Action", buffer = bufnr})
  vim.keymap.set('n', "<leader>cA", function() vim.lsp.buf.code_action({context = {only = {"source"}, diagnostics = {}}}) end, { desc = "Source Action", buffer = bufnr })
  vim.keymap.set('n', "<leader>cr", vim.lsp.buf.rename, {desc = "Rename", buffer = bufnr})
end)
lsp_zero.setup_servers({'solargraph', 'gopls'})

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
