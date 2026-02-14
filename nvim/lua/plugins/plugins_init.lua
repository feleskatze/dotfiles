-- ~/.config/nvim/lua/plugins/init.lua
return {
  -- Theme
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
    config = function()
      vim.o.background = "dark"
      vim.g.gruvbox_material_background = "hard"
      -- パレット（material / mix / original）
      vim.g.gruvbox_material_foreground = "original"
      -- サイドバーやポップアップを少し暗く
      vim.g.gruvbox_material_dim_inactive_windows = 0
      vim.g.gruvbox_material_better_performance = 1

      vim.cmd.colorscheme("gruvbox-material")
    end,
  },
   {
    "luisiacc/gruvbox-baby",
    priority = 1000,
    config = function()
      vim.o.background = "dark"
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        auto_integrations = true,
      })
    end,
    },

  -- Icons（fzf-lua / lualine などで使う）
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- Lualine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = { globalstatus = true, section_separators = "", component_separators = "" },
    },
  },

  -- Oil（ファイル操作）
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Oil",
    opts = {
      view_options = { show_hidden = true },
      buf_options = {
        buftype = "nofile",
        bufhidden = "wipe",
        swapfile = false,
      },
      -- qで閉じるのを明示
      keymaps = {
        ["q"] = "actions.close",
      },
    },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Oil" },
    },
  },



  -- fzf-lua
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "FzfLua",
    opts = {},
    keys = {
     -- files
      { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "File: files" },
      { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "File: live grep" },
      { "<leader>fG", "<cmd>FzfLua grep_cword<cr>", desc = "File: grep word" },
      { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "File: buffers" },
      { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "File: recent" },

      -- symbols
      { "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Symbols: document" },
      { "<leader>sS", "<cmd>FzfLua lsp_workspace_symbols<cr>", desc = "Symbols: workspace" },
      { "<leader>st", "<cmd>FzfLua treesitter<cr>", desc = "Symbols: treesitter" },
    },
  },

  -- ToggleTerm
{
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = { { "<leader>t", "<cmd>ToggleTerm<cr>", desc = "Terminal" } },
  opts = function()
    local bash = "C:/PROGRA~1/Git/usr/bin/bash.exe"
    return {
      shell = (vim.fn.executable(bash) == 1) and bash or vim.o.shell,
      open_mapping = [[<c-\>]],
      direction = "float",
      float_opts = { border = "rounded" },
    }
  end,
},

-- Treesitter
{
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  opts = {
    ensure_installed = { "go", "lua", "vim", "vimdoc", "query" },
    highlight = { enable = true },
    indent = { enable = false },  
  },
  config = function(_, opts)
    require("nvim-treesitter.config").setup(opts)
    -- treesitter を自動 start させる
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        -- すでに attach してたら何もしない
        if vim.treesitter.highlighter.active[args.buf] ~= nil then
          return
        end
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
},


  -- Mason（LSPバイナリ管理）
{
  "williamboman/mason.nvim",
  cmd = "Mason",
  opts = {},
},

{
  "williamboman/mason-lspconfig.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "williamboman/mason.nvim" },
  opts = {
    ensure_installed = { "gopls" },
    automatic_installation = true,
  },
},

{
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "saghen/blink.cmp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

  -- LspAttach: LSPが付いたバッファにだけキーマップを貼る
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true, noremap = true }

        -- keumap
        vim.keymap.set("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<cr>", vim.tbl_extend("force", opts, { desc = "LSP: definition" }))
        vim.keymap.set("n", "<leader>lr", "<cmd>lua vim.lsp.buf.references()<cr>", vim.tbl_extend("force", opts, { desc = "LSP: references" }))
        vim.keymap.set("n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<cr>", vim.tbl_extend("force", opts, { desc = "LSP: implementation" }))
        vim.keymap.set("n", "<leader>lt", "<cmd>lua vim.lsp.buf.type_definition()<cr>", vim.tbl_extend("force", opts, { desc = "LSP: type definition" }))

        vim.keymap.set("n", "<leader>ln", "<cmd>lua vim.lsp.buf.rename()<cr>", vim.tbl_extend("force", opts, { desc = "LSP: rename" }))
        vim.keymap.set({ "n", "v" }, "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", vim.tbl_extend("force", opts, { desc = "LSP: code action" }))
        vim.keymap.set("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({async=true})<cr>", vim.tbl_extend("force", opts, { desc = "LSP: format" }))

        vim.keymap.set("n", "<leader>le", "<cmd>lua vim.diagnostic.open_float()<cr>", vim.tbl_extend("force", opts, { desc = "LSP: diagnostics float" }))
     end,
    })


    -- ここが新方式
    vim.lsp.config("gopls", {
      capabilities = capabilities,
      settings = {
        gopls = {
          semanticTokens = true,
          staticcheck = true,
          gofumpt = true,
          analyses = { unusedparams = true, shadow = true },
        },
      },
    })

    vim.lsp.enable("gopls")
  end,
},

  -- signature help
  {
    "ray-x/lsp_signature.nvim",
    event = "LspAttach",
    opts = {
      bind = true,
      floating_window = true,
      hint_enable = false,
      doc_lines = 0,
      handler_opts = { border = "rounded" },
    },
  },

  -- Fidget（LSP進捗UI）
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {},
  },

  -- Completion
  {
  "saghen/blink.cmp",
  version = "*",
  event = { "InsertEnter", "CmdLineEnter" },

  ---@module "blink.cmp"
  ---@type blink.cmp.Config
  opts = {
    -- Keymap
    keymap = {
      preset = "enter",
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
    },

    sources = {
      default = { "lsp", "buffer", "path", "snippets" },
    },

    completion = {
      list = {
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },
      menu = { border = "rounded" },
      documentation = { window = { border = "rounded" }, auto_show = true, auto_show_delay_ms = 300 },
    },

    -- lsp_signature.nvimを使う
    signature = { enabled = false },
  },

  -- sources.default をoptsで拡張するためのおまじない（lazy.nvim向け）
  opts_extend = { "sources.default" },
},



  -- conform（保存時フォーマット）
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    opts = {
      format_on_save = function(bufnr)
        -- Go は速いので常時でOK。重くなったらタイムアウトを短く。
        return { timeout_ms = 2000, lsp_fallback = true }
      end,
      formatters_by_ft = {
        go = { "goimports", "gofmt" }, -- goimports が無ければ gofmt に落ちる
        lua = { "stylua" },
      },
    },
  },


  {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      go = { "golangcilint" },
    }

    -- 手動実行
    vim.api.nvim_create_user_command("GoLint", function()
      lint.try_lint()
    end, {})
  end,
 },

  -- autopairs
{
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    require("nvim-autopairs").setup({
      check_ts = true, -- treesitterがあれば文脈判定
    })
  end,
},



  -- Git差分表示
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      signs = {
        add    = { text = "│" },
        change = { text = "│" },
        delete = { text = "─" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      signcolumn = true,
      numhl = false,
      linehl = false,
      current_line_blame = false, -- 必要なら true
    },
  },

  -- キーバインド表示
{
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    triggers = {
      { "<auto>", mode = "nixsotc" }, -- ほぼすべてのモードを対象に
    },
    disable = {
      buftypes = {},  -- 特定バッファで無効化しない
      filetypes = {}, -- 特定ファイルで無効化しない
    },
    plugins = {
      marks = true,
      registers = true,
      spelling = { enabled = true, suggestions = 20 },
    },
    win = {
      border = "rounded",
      padding = { 1, 2 },
    },
    layout = {
      spacing = 3,
      align = "left",
    },
    icons = {
      breadcrumb = "›",
      separator = "➜",
      group = "+",
    },
    spec = {
      { "<leader>w", buffer = 1, group = "window"},
      { "<leader>b", buffer = 1, group = "buffer"},
      { "<leader>l", buffer = 1, group = "lsp"},
      { "<leader>s", buffer = 1, group = "symbols"},
      { "<leader>f", buffer = 1, group = "fzf"},
    },
  },
},

  -- indent/blankline chunk highlight
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      chunk = {
        enable = true,
        use_treesitter = true,
        delay = 100,
      },
      indent = { enable = false },
      line_num ={
        enable = true,
      },
      blank = { enable = false },
    },
  },
}

