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

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
  {'neovim/nvim-lspconfig'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/nvim-cmp'},
  {'L3MON4D3/LuaSnip'},

  'tpope/vim-sensible',
  'tpope/vim-fugitive',
  'AndrewRadev/splitjoin.vim',
  'tpope/vim-repeat',
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
    end,
  },
  {
    'akinsho/bufferline.nvim',
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    },
    opts = {
      options = {
        close_command = function(n) require("mini.bufremove").delete(n, false) end,
        right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(_, _, diag)
          local ret = (diag.error and " " .. diag.error .. " " or "")
            .. (diag.warning and " " .. diag.warning or "")
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
	    highlight = "Directory",
            text_align = "left",
          },
        },
      }
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function() require('lualine').setup() end
  },
  {
    'nvim-zh/auto-save.nvim',
    config = function ()
      require('auto-save').setup()
    end
  },
  'ntpeters/vim-better-whitespace',
  'tpope/vim-sleuth',
  {
    'tpope/vim-rails',
    -- https://github.com/nvim-treesitter/nvim-treesitter/issues/1352
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "eruby.yaml",
        command = "set filetype=yaml"
      })
    end
  },
  'tpope/vim-surround',
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'gruvbox'
    end
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },
  {
    "echasnovski/mini.bufremove",
    keys = {
      { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { "<leader>ff", function() require('telescope.builtin').find_files() end },
      { "<leader>sg", function() require('telescope.builtin').live_grep() end, desc = "Grep (root dir)" },
      { "<leader>sG", function() require('telescope.builtin').live_grep({ cwd = false }) end, desc = "Grep (cwd)" },
      { "<leader>sb", function() require('telescope.builtin').buffers() end },
      { "<leader>sh", function() require('telescope.builtin').help_tags() end },
      { "<leader>sw", function() require('telescope.builtin').grep_string({ word_match = '-w' }) end, desc = "Word" },
      { "<leader>sw", function() require('telescope.builtin').grep_string() end, mode = "v", desc = "Selection" },
    },
  },
  'jvirtanen/vim-hcl',
  'tpope/vim-bundler',
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    dependencies = {
      'hrsh7th/nvim-cmp',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function ()
      require('nvim-autopairs').setup({
        check_ts = true
      })
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      'RRethy/nvim-treesitter-endwise',
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ":TSUpdate",
  },
  {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    opts = {},
    dependencies = { { 'neovim/nvim-lspconfig' } }
  },

  { 'aklt/plantuml-syntax' },
  { 'tyru/open-browser.vim' },
  { 'weirongxu/plantuml-previewer.vim'},
  {
    'nvim-pack/nvim-spectre',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    }
  },
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  }
})

require('nvim-treesitter.configs').setup {
  auto_install = true,
  ensure_installed = { 'go', 'gomod', 'gowork', 'gosum', 'lua', 'ruby', 'vimdoc', 'vim', 'yaml' },
  endwise = { enable = true },
  highlight = { enable = true }, -- false will disable the whole extension
  -- indent = { enable = true },
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
