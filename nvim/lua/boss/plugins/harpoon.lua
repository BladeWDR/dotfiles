return {
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set(
      "n",
      "<leader>a",
      "<cmd>lua require('harpoon.mark').add_file()<cr>",
      { desc = "Mark file with harpoon" }
    )
    keymap.set(
      "n",
      "<leader>r",
      "<cmd>lua require('harpoon.mark').rm_file()<cr>",
      { desc = "unmark file with harpoon" }
    )
    keymap.set(
      "n",
      "<C-e>",
      "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
      { desc = "Go to previous harpoon mark" }
    )
    keymap.set(
      "n",
      "<C-h>",
      "<cmd>lua require('harpoon.ui').nav_file(1)<cr>",
      { desc = "Go to first file" }
        )
    keymap.set(
      "n",
      "<C-j>",
      "<cmd>lua require('harpoon.ui').nav_file(2)<cr>",
      { desc = "Go to first file" }
        )
    keymap.set(
      "n",
      "<C-k>",
      "<cmd>lua require('harpoon.ui').nav_file(3)<cr>",
      { desc = "Go to first file" }
        )
    keymap.set(
      "n",
      "<C-l>",
      "<cmd>lua require('harpoon.ui').nav_file(4)<cr>",
      { desc = "Go to first file" }
        )
  end,
}

