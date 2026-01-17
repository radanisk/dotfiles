return {
  'tpope/vim-sensible',
  'AndrewRadev/splitjoin.vim',
  'tpope/vim-repeat',
  {
    'nvim-zh/auto-save.nvim',
    config = function ()
      require('auto-save').setup({
        trigger_events = { 'InsertLeave', 'FocusLost' },
        debounce_delay = 300,
        condition = function(buf)
          if not vim.api.nvim_buf_is_valid(buf) then
            return false
          end
          local bo = vim.bo[buf]
          if not bo.modifiable or bo.buftype ~= '' then
            return false
          end
          if bo.filetype == 'gitcommit' or bo.filetype == 'gitrebase' then
            return false
          end
          return true
        end,
      })
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
  'tpope/vim-bundler',
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function ()
      require('nvim-autopairs').setup({
        check_ts = true
      })
    end,
  },
}
