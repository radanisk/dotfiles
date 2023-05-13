local M = {}

function M.run(use)
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
end

return M
