return {
	"hedyhli/outline.nvim",
	ft = "markdown",
	config = function()
		-- Example mapping to toggle outline
		vim.keymap.set("n", "<leader>O", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

		require("outline").setup({})
	end,
}
