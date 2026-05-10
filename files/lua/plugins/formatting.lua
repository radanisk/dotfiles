return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format({ async = true })
        end,
        desc = 'Format Buffer',
      },
    },
    opts = {
      default_format_opts = {
        lsp_format = 'fallback',
      },
      format_on_save = {
        timeout_ms = 500,
      },
      formatters_by_ft = {
        go = { 'goimports', 'gofmt' },
        lua = { 'stylua' },
        ruby = { 'rubocop' },
        sh = { 'shfmt' },
        zsh = { 'shfmt' },
      },
    },
  },
}
