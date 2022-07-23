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

  use { 'ntpeters/vim-better-whitespace' }

  use 'tpope/vim-rails'

  use 'tpope/vim-surround'
  use 'dyng/ctrlsf.vim'
end)
