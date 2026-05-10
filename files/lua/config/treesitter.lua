local enabled = {
  c = true,
  help = true,
  lua = true,
  markdown = true,
  query = true,
  vim = true,
  vimdoc = true,
}

vim.api.nvim_create_autocmd('FileType', {
  callback = function(event)
    if not enabled[event.match] then
      return
    end

    local lang = vim.treesitter.language.get_lang(event.match)
    if not lang or not vim.treesitter.language.add(lang) then
      return
    end

    pcall(vim.treesitter.start, event.buf, lang)
  end,
})
