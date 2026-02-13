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
vim.opt.listchars = { trail = "·", extends = "›", precedes = "‹", nbsp = "␣" }
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
vim.keymap.set("n", "<leader>k", vim.diagnostic.open_float)

-- Window
vim.keymap.set("n", "<leader>ws", "<cmd>split<cr>", { desc = "Window: split" })
vim.keymap.set("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "Window: vsplit" })
vim.keymap.set("n", "<leader>wd", "<cmd>close<cr>", { desc = "Window: close" })

-- Buffer
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Buffer: next" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Buffer: prev" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Buffer: delete" })




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

-- Auto Display LSP Hint
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, {
      focus = false,
      scope = "cursor",
    })
  end,
})

-- Set LSP Hint Window Looks
vim.diagnostic.config({
  float = {
    border = "rounded",
    source = "if_many",
    header = "",
    focusable = false,
    winblend = 10,
  },
})

vim.o.winborder = "rounded"
vim.o.winblend = 10



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
