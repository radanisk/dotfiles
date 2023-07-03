vim.g.mapleader = " "
vim.g.maplocalleader = " "

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

vim.o.termguicolors = true

require('lazy').setup({
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {                                      -- Optional
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'L3MON4D3/LuaSnip'},     -- Required
    }
  },

  'tpope/vim-sensible',
  'tpope/vim-fugitive',
  'AndrewRadev/splitjoin.vim',
  'tpope/vim-repeat',
  {
    'kyazdani42/nvim-tree.lua',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function() require('nvim-tree').setup {} end
  },
  {
    'freddiehaddad/feline.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function() require('feline').setup() end
  },
  {
    'nvim-zh/auto-save.nvim',
    config = function ()
      require('auto-save').setup()
    end
  },
  'ntpeters/vim-better-whitespace',
  'tpope/vim-sleuth',
  'tpope/vim-rails',
  'tpope/vim-surround',
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'gruvbox'
    end
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' }
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
    dependecies = { { 'nvim-lsp-config'} }
  },

  { 'aklt/plantuml-syntax' },
  { 'tyru/open-browser.vim' },
  { 'weirongxu/plantuml-previewer.vim'},
})

vim.opt.langmap = 'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'
vim.wo.number = true
vim.wo.signcolumn = 'yes'
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.undofile = true

require('nvim-treesitter.configs').setup {
  auto_install = true,
  ensure_installed = { 'go', 'lua', 'ruby', 'vimdoc', 'vim' },
  endwise = { enable = true },
  highlight = { enable = true }, -- false will disable the whole extension
  -- indent = { enable = true },
  incremental_selection = { enable = true },
}

local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

lsp.ensure_installed({'solargraph'})

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

local bind = vim.keymap.set
local opts = { silent = true, noremap = true }

bind("n", "<leader>h", ":nohlsearch<CR>", opts)

bind('n', '<leader>vr', ':so $MYVIMRC<CR>')

-- Better window movement
bind("n", "<C-l>", "<C-w>l", opts)
bind("n", "<C-h>", "<C-w>h", opts)
bind("n", "<C-j>", "<C-w>j", opts)
bind("n", "<C-k>", "<C-w>k", opts)

bind("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
bind("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
bind("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
bind("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", opts)
--
bind('n', '<leader><leader>', ':NvimTreeToggle<CR>')

bind('n', '<leader>tf', ':NvimTreeFindFile<CR>')