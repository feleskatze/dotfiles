-- ~/.config/nvim/init.lua
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 基本
vim.o.number = true
vim.o.relativenumber = false
vim.o.cursorline = true
vim.o.showmode = false
vim.o.termguicolors = true
vim.o.signcolumn = "yes"
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.showmatch = true
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", extends = "›", precedes = "‹", nbsp = "␣" }
vim.o.autoread = true
vim.o.showcmd = true
vim.o.linebreak = true
vim.cmd.syntax("on")


-- 検索
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.inccommand = "split" -- :s時にリアルタイムプレビュー表示が崩れるなら消す

-- indent
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.smartindent = true
vim.o.breakindent = true

-- clopboard/chara
vim.o.clipboard = "unnamedplus"
vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"

-- comp
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.o.pumheight = 12
vim.o.conceallevel = 0
vim.o.updatetime = 200
vim.o.timeoutlen = 400
vim.o.wildmode = "longest:full,full"
vim.o.wildignorecase = true

-- Key map
vim.o.mouse = "a"
vim.keymap.set("i", "jj", "<ESC>", { silent = true})
vim.keymap.set("n", "<leader>nh", "<cmd>nohlsearch<cr>", { desc = "No highlight" })


-- Windows: Neovim内蔵ターミナルの既定シェルを Git Bash にする
if vim.fn.has("win32") == 1 then
  local bash = "C:/PROGRA~1/Git/usr/bin/bash.exe"
  if vim.fn.executable(bash) == 1 then
    vim.opt.shell = bash
    vim.opt.shellcmdflag = "-lc"
    vim.opt.shellquote = ""
    vim.opt.shellxquote = ""
  else
    vim.notify("Git Bash not found: " .. bash, vim.log.levels.WARN)
  end
end

-- When Save File run formatter
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- run gopls formatter
    if client and client.name == "gopls" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,
})

-- lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  ui = { border = "rounded" },
  change_detection = { notify = false },
})
