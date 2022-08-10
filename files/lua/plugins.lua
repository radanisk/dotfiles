return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use { 'tpope/vim-sensible' }
  use 'tpope/vim-repeat'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function() require('nvim-tree').setup {} end
  }
  use {
    'feline-nvim/feline.nvim',
    after = "nvim-web-devicons",
    config = function()
      require('feline').setup()
    end
  }

  use { 'ntpeters/vim-better-whitespace' }

  use 'tpope/vim-rails'

  use 'tpope/vim-surround'
  use 'dyng/ctrlsf.vim'
  use { "ellisonleao/gruvbox.nvim" }

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }

  use { 'jvirtanen/vim-hcl' }
end)
