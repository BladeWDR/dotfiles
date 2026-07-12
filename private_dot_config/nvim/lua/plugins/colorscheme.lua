return {
	"Yahddyyp/mauve.nvim",
	priority = 1000,
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
