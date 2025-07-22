-- [[ Setting options ]]
-- See `:help vim.opt`
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.nu = true
vim.g.netrw_bufsettings = "noma nomod nu rnu nobl nowrap ro"

vim.opt.spellfile = vim.fn.expand("~/.spell/en.utf-8.add")

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Disable wrapping
vim.opt.wrap = false

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set the listchars options
vim.o.listchars = "trail:-,nbsp:+,tab:▏ ,leadmultispace:▏ ,eol:↲"
vim.opt.list = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.cursorline = true

-- Add undo points for punctuation - useful when writing something other than code.
vim.keymap.set("i", "!", "!<C-g>u", { noremap = true, silent = true })
vim.keymap.set("i", ",", ",<C-g>u", { noremap = true, silent = true })
vim.keymap.set("i", ".", ".<C-g>u", { noremap = true, silent = true })
vim.keymap.set("i", ":", ":<C-g>u", { noremap = true, silent = true })
vim.keymap.set("i", ";", ";<C-g>u", { noremap = true, silent = true })
vim.keymap.set("i", "?", "?<C-g>u", { noremap = true, silent = true })
vim.keymap.set("i", "(", "<C-g>u(", { noremap = true, silent = true })
vim.keymap.set("i", ")", ")<C-g>u", { noremap = true, silent = true })

-- Options for nvim-ufo and folds.
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
