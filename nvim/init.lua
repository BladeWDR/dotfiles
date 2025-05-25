-- Set <space> as the leader key
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

require("lazy-bootstrap") -- loads the lazy plugin manager

require("config") -- sets Neovim options, remap, etc.
