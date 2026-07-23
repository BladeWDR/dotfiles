return {
	"Yahddyyp/mauve.nvim",
	priority = 1000,
	lazy = false,
	config = function()
		require("mauve").setup({
			-- integrations = {
			-- 	noice = true,
			-- },
		})
		vim.cmd.colorscheme("mauve")
		vim.cmd.hi("Comment gui=none")
	end,
}
