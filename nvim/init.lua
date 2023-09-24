-- Load in lazy.nvim plugin manager. 
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Need to set the leader key here so that the mapping is loaded before lazy.nvim
vim.g.mapleader = " "

require("lazy").setup("boss.plugins")
require("boss")
