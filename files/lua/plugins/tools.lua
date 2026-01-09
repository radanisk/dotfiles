return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { "<leader>ff", function() require('telescope.builtin').find_files() end, desc = "Find Files" },
      { "<leader>sg", function() require('telescope.builtin').live_grep() end, desc = "Grep" },
      { "<leader>bl", function() require('telescope.builtin').buffers() end, desc = "Buffer List" },
      { "<leader>sh", function() require('telescope.builtin').help_tags() end, desc = "Help Tags" },
      { "<leader>sw", function() require('telescope.builtin').grep_string({ word_match = '-w' }) end, desc = "Word" },
      { "<leader>sw", function() require('telescope.builtin').grep_string() end, mode = "v", desc = "Selection" },
    },
  },
  'christoomey/vim-tmux-navigator',
  {
    'nvim-pack/nvim-spectre',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    }
  },
  { 'tyru/open-browser.vim' },
  { 'weirongxu/plantuml-previewer.vim' },
}
