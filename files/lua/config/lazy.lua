-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.cursorline = true

vim.opt.langmap = 'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

require("codecompanion").setup({
  adapters = {
    coder = function()
      return require("codecompanion.adapters").extend("openai_compatible", {
        schema = {
          model = {
            default = "coder",
          },
        },
      })
    end,
  },
  strategies = {
    chat = {
      adapter = "coder",
    },
    inline = {
      adapter = "coder",
    },
    cmd = {
      adapter = "coder",
    }
  }
})

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
