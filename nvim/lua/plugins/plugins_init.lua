-- ~/.config/nvim/lua/plugins/init.lua
return {
  -- Theme
  {
    "luisiacc/gruvbox-baby",
    priority = 1000,
    config = function()
      vim.o.background = "dark"
      vim.cmd.colorscheme("gruvbox-baby")
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

  -- Treesitter
{
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
opts = {
  ensure_installed = { "go", "gomod", "gosum", "lua", "vim", "vimdoc" },
  highlight = { enable = true },
  indent = { enable = true },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
  config = function(_, opts)
    local ok, configs = pcall(require, "nvim-treesitter.configs")
    if not ok then
      vim.notify("nvim-treesitter not loaded (run :Lazy sync)", vim.log.levels.WARN)
      return
    end
    configs.setup(opts)
  end,
},
},
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = { "BufReadPre", "BufNewFile" },
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
      { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
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


  -- Mason（LSPバイナリ管理）
 {
  "williamboman/mason.nvim",
  cmd = "Mason",
  opts = {},
  config = function(_, opts)
    require("mason").setup(opts)

    -- gopls (mason) をネイティブLSPで起動
    local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
    local gopls_cmd = mason_bin .. "/gopls"

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    do
      local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if ok then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      end
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "go",
      callback = function(args)
        if vim.fn.executable(gopls_cmd) ~= 1 then
          vim.notify("gopls not found: " .. gopls_cmd .. " (install via :Mason)", vim.log.levels.WARN)
          return
        end

        local clients = vim.lsp.get_clients({ bufnr = args.buf, name = "gopls" })
        if #clients > 0 then return end

        vim.lsp.start({
          name = "gopls",
          cmd = { gopls_cmd },
          root_dir = vim.fs.root(args.buf, { "go.work", "go.mod", ".git" }),
          capabilities = capabilities,
          settings = {
            gopls = {
              staticcheck = true,
              analyses = { unusedparams = true, shadow = true },
            },
          },
        })
      end,
    })
  end,
},


  -- Fidget（LSP進捗UI）
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {},
  },

  -- completion stack
  { "onsails/lspkind.nvim", lazy = true },
  { "L3MON4D3/LuaSnip", event = "InsertEnter" },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "L3MON4D3/LuaSnip",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
        },
        window = {
          completion = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
            scrollbar = false,
          }),
          documentation = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,Search:None",
          }),
        },
        formatting = {
          format = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 }),
        },
      })
    end,
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

  -- Git差分表示
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
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
  },
}


}

