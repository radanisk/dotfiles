vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.opt.clipboard = 'unnamedplus'
vim.opt.undofile = true
vim.opt.updatetime = 200
vim.opt.ignorecase = true
vim.opt.laststatus = 3
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.cursorline = true

vim.opt.langmap = 'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'

local nvim_tree_group = vim.api.nvim_create_augroup('NvimTreeAutoOpen', { clear = true })

vim.api.nvim_create_autocmd('VimEnter', {
  group = nvim_tree_group,
  callback = function()
    if vim.fn.argc() ~= 1 then
      return
    end

    local arg = vim.fn.argv(0)
    if vim.fn.isdirectory(arg) == 0 then
      return
    end

    local dir_buf = vim.api.nvim_get_current_buf()

    vim.cmd.cd(arg)
    vim.cmd('enew')
    local new_buf = vim.api.nvim_get_current_buf()
    if dir_buf ~= new_buf and vim.api.nvim_buf_is_valid(dir_buf) then
      vim.api.nvim_buf_delete(dir_buf, { force = true })
    end
    vim.cmd('NvimTreeOpen')
    if vim.fn.winnr('$') > 1 then
      vim.cmd('wincmd p')
    end
  end,
})
