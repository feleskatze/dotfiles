-- ~/.config/nvim/init.lua
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 基本（必要最低限）
vim.o.number = true
vim.o.relativenumber = false
vim.o.termguicolors = true
vim.o.updatetime = 200
vim.o.signcolumn = "yes"
vim.o.completeopt = "menu,menuone,noselect"

-- Key map
vim.keymap.set("i", "jj", "<ESC>", { silent = true})
vim.keymap.set("n", "<leader>nh", "<cmd>nohlsearch<cr>", { desc = "No highlight" })


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
