-- freely move text up and down.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- keep cursor in the middle during jump or search operations.
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- copy / paste to system clipboard.
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]])
vim.keymap.set("n", "<leader>P", [["+P]])

-- remap ctrl+c to the escape key
vim.keymap.set({ "i", "v" }, "<C-c>", "<Esc>")

-- do search and replace for word the cursor is on in normal mode.
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- enclose selection in double quotes.
vim.keymap.set("n", "<leader>q", [[:s/\<<C-r><C-w>\>/"<C-r><C-w>"<CR>]])

-- change the working directory to the current file.
vim.keymap.set("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>")

-- toggle wrap / nowrap
vim.keymap.set("n", "<leader>W", ":PencilToggle<CR>")

-- Open Obsidian daily note
vim.keymap.set("n", "<leader>o", ":ObsidianToday<CR>")

-- enable spellcheck
vim.keymap.set("n", "<leader>z", ":setlocal spell spelllang=en_us<CR>")

-- correct previous spelling mistake while in insert mode.
vim.keymap.set("i", "<C-l>", "<C-g>u<Esc>[s1z=`]a<C-g>u")

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.api.nvim_set_keymap('n', '<leader>ms', [[:w<CR>:!bash pandoc-wrapper.sh -o "%"<CR>]], { noremap = true, silent = true })

-- Yank current buffer path to system clipboard.
vim.keymap.set('n', '<leader>yp', function()
  local path = vim.fn.expand('%:p')
  vim.fn.setreg('+', path)
  print('Copied path: ' .. path)
end, { noremap = true, silent = true })
