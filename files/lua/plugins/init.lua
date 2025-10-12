return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      notifier = { enabled = true },
    },
    keys = {
      { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notification History" },
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.enable('gopls')
      vim.lsp.enable('solargraph')
    end,
    keys = {
      { "gd", vim.lsp.buf.definition, desc = "Goto Definition" },
      { "gr", vim.lsp.buf.references, desc = "References", nowait = true },
      { "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
      { "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
      { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
      { "K", function() return vim.lsp.buf.hover() end, desc = "Hover" },
      { "gK", function() return vim.lsp.buf.signature_help() end, desc = "Signature Help" },
      { "<c-k>", function() return vim.lsp.buf.signature_help() end, mode = "i", desc = "Signature Help" },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
      { "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" } },
      { "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" } },
      { "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },
    }
  },
  {
    'saghen/blink.cmp',
    version = '1.*',
    opts = {
      keymap = { preset = 'default' },
      appearance = {
        nerd_font_variant = 'mono'
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200
        },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
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
        close_command = function(n) Snacks.bufdelete(n) end,
        right_mouse_command = function(n) Snacks.bufdelete(n) end,
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
    config = function()
      require('lualine').setup {
        options = { globalstatus = true },
        sections = {
          lualine_c = {
            { 'filename', path = 1 },
          },
        },
        extensions = { "lazy", "nvim-tree", "trouble" },
      }
    end
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
    opts = {
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        map("n", "]h", function() gs.nav_hunk("next") end, "Next Hunk")
        map("n", "[h", function() gs.nav_hunk("prev") end, "Prev Hunk")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
      end,
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
    config = function ()
      require('nvim-autopairs').setup({
        check_ts = true
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      'RRethy/nvim-treesitter-endwise',
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = {
          'bash',
          'css',
          'dockerfile',
          'go',
          'gomod',
          'gowork',
          'gosum',
          'html',
          'javascript',
          'jsdoc',
          'json',
          'jsonc',
          'lua',
          'luadoc',
          'make',
          'markdown',
          'markdown_inline',
          'regex',
          'ruby',
          'scss',
          'toml',
          'tsx',
          'typescript',
          'vim',
          'vimdoc',
          'yaml',
        },
        endwise = { enable = true },
        highlight = { enable = true }, -- false will disable the whole extension
        incremental_selection = { enable = true },
        indent = { enable = true },
      })
    end
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
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      scope = { show_start = false, show_end = false },
    },
    main = "ibl",
  },
  {
    "olimorris/codecompanion.nvim",
    opts = {
      language = "Russian",
      strategies = {
        chat = { adapter = { name = "ollama", model = "coder" } },
        inline = { adapter = { name = "ollama", model = "coder" } },
        cmd = { adapter = { name = "ollama", model = "coder" } }
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
